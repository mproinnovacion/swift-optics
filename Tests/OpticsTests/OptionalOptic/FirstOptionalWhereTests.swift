import Foundation
import XCTest

import Optics

class FirstOptionalWhereTests: XCTestCase {
	func testFirst() {
		let people = Optionally {
			\Company.employees
		}
		
		let first = people.first(where: { $0.age > 50 })
		
		XCTAssertEqual(
			first.tryGet(company),
			louis
		)
		
		let firstName = Optionally {
			first
			\Person.name
		}
		
		var local = company
		
		firstName.tryUpdate(in: &local) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			firstName.tryGet(local),
			"LOUIS"
		)
	}
}
