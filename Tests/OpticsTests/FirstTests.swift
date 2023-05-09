import Foundation
import XCTest

import Optics

class FirstTests: XCTestCase {
	func testFirst() {
		let people = Lens {
			\Company.employees
		}
		
		let first = First {
			people
		}
		
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
