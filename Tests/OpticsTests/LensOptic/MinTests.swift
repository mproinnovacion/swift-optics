import Foundation
import Optics
import XCTest

class MinTests: XCTestCase {
	func testMin() {
		let people = Lens {
			\Company.employees
		}
		
		let youngest = Min {
			people
		} by: {
			\Person.age
		}
		
		XCTAssertEqual(
			youngest.tryGet(company),
			mike
		)
		
		let youngestName = Optionally {
			youngest
			\Person.name
		}
		
		var local = company
		
		youngestName.tryUpdate(in: &local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			youngestName.tryGet(local),
			"MIKE"
		)
		
		youngest.trySet(in: &local, to: louis)
		
		XCTAssertEqual(
			youngestName.tryGet(local),
			"Jessica"
		)
	}
	
	func testEmpty() {
		let people = Lens {
			\Company.freelance
		}

		let youngest = Min {
			people
		} by: {
			\Person.age
		}
		
		var empty = company
		empty.freelance = []
		
		XCTAssertEqual(
			youngest.tryGet(empty),
			nil
		)
		
		XCTAssertEqual(
			youngest.tryGet(
				youngest.trySetting(in: empty, to: john)
			),
			nil
		)
	}
}
