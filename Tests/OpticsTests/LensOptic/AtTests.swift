import Foundation
import Optics
import XCTest

class AtTests: XCTestCase {
	func testAt() {
		let people = Lens {
			\Company.employees
		}
		
		let person = people.at(2)
		
		XCTAssertEqual(
			person.tryGet(company),
			jessica
		)
		
		let personName = Optionally {
			person
			\Person.name
		}
		
		var local = company
		
		personName.tryUpdate(in: &local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			personName.tryGet(local),
			"JESSICA"
		)
	}
	
	func testAtSubscript() {
		let people = Lens {
			\Company.employees
		}
		
		let person = people[2]
		
		XCTAssertEqual(
			person.tryGet(company),
			jessica
		)
		
		let personName = Optionally {
			person
			\Person.name
		}
		
		var local = company
		
		personName.tryUpdate(in: &local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			personName.tryGet(local),
			"JESSICA"
		)
	}
}
