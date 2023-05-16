import Foundation
import XCTest

import Optics

class FirstWhereTests: XCTestCase {
	func testFirst() {
		let people = Lens {
			\Company.employees
		}
		
		let first = people.first()
		
		XCTAssertEqual(
			first.tryGet(company),
			mike
		)
		
		let firstName = Optionally {
			first
			\Person.name
		}
		
		var local = company
		
		firstName.tryUpdate(in: &local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			firstName.tryGet(local),
			"MIKE"
		)
	}
}
