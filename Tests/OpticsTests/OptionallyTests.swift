import Foundation
import XCTest
import Optics
import CasePaths

class OptionallyTests: XCTestCase {
	func testOptionally() {
		let advisor = Optionally {
			\Company.advisor
			Prism {
				/Failable<Person>?.some
				/Failable<Person>.valid
			}
		}
		
		let advisorName = Optionally {
			advisor
			\Person.name
		}
				
		var local = company
		
		XCTAssertNil(advisorName.tryGet(local))

		advisorName.trySet(&local, to: "Joe")
		
		XCTAssertNil(advisorName.tryGet(local))
		
		advisor.trySet(&local, to: joe)

		XCTAssertEqual(
			advisor.tryGet(local),
			joe
		)
		
		advisorName.trySet(&local, to: "John")
		
		XCTAssertEqual(
			advisorName.tryGet(local),
			"John"
		)
		
		advisorName.tryUpdate(&local) { $0 + "!" }

		XCTAssertEqual(
			advisorName.tryGet(local),
			"John!"
		)
		
		XCTAssertEqual(
			advisorName.tryGet(
				advisorName.tryUpdating(local) { $0 = $0.uppercased() }
			),
			"JOHN!"
		)
	}
	
	func testMap() {
		let advisor = Optionally {
			\Company.advisor
			Prism {
				/Failable<Person>?.some
				/Failable<Person>.valid
			}
		}
			
		let advisorNameShouted = Optionally {
			advisor
			\Person.name
		}.map { string in
			string + "!"
		} to: { string in
			string.replacingOccurrences(of: "!", with: "")
		}

		var updated = advisor.trySetting(company, to: john)
		
		XCTAssertEqual(
			advisorNameShouted.tryGet(updated),
			"John!"
		)
		
		updated = advisorNameShouted.trySetting(updated, to: "Tony")
		
		XCTAssertEqual(
			advisorNameShouted.tryGet(updated),
			"Tony!"
		)
		
		switch updated.advisor {
			case let .valid(person):
				XCTAssertEqual(
					person.name,
					"Tony"
				)
			default:
				XCTFail("Invalid advisor")
		}
	}
	
	func testStatement() {
		let advisor = Optionally {
			if true {
				\Company.advisor
				Prism {
					/Failable<Person>?.some
					/Failable<Person>.valid
				}
			}
		}
		
		let updated = advisor.trySetting(company, to: john)
		
		let includeAdvisor = false
		let noAdvisor = Optionally {
			if includeAdvisor {
				\Company.advisor
				Prism {
					/Failable<Person>?.some
					/Failable<Person>.valid
				}
			}
		}
		
		XCTAssertEqual(
			advisor.tryGet(updated),
			john
		)
		
		XCTAssertEqual(
			noAdvisor.tryGet(updated),
			nil
		)
	}
}
