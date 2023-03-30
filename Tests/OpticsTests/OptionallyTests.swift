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

		var updated = advisor.trySet(company, to: john)
		
		XCTAssertEqual(
			advisorNameShouted.tryGet(updated),
			"John!"
		)
		
		updated = advisorNameShouted.trySet(updated, to: "Tony")
		
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
}
