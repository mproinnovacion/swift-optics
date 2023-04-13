import Foundation
import Optics
import XCTest

class MaxTests: XCTestCase {
	func testMax() {
		let people = Lens {
			\Company.employees
		}
		
		let oldest = Max {
			people
		} by: {
			\Person.age
		}
		
		XCTAssertEqual(
			oldest.tryGet(company),
			louis
		)
		
		let oldestName = Optionally {
			oldest
			\Person.name
		}
		
		var local = company
		
		local = oldestName.tryUpdating(local) { $0.uppercased() }
		
		XCTAssertEqual(
			oldestName.tryGet(local),
			"LOUIS"
		)
		
		oldest.trySet(&local, to: mike)
		
		XCTAssertEqual(
			oldestName.tryGet(local),
			"Jessica"
		)
	}
	
	func testEmpty() {
		let people = Lens {
			\Company.freelance
		}

		let oldest = Max {
			people
		} by: {
			\Person.age
		}
		
		var empty = company
		empty.freelance = []
		
		XCTAssertEqual(
			oldest.tryGet(empty),
			nil
		)
		
		XCTAssertEqual(
			oldest.tryGet(
				oldest.trySetting(empty, to: john)
			),
			nil
		)
	}
}
