import Foundation
import XCTest
import Optics

class DropFirstTests: XCTestCase {
	func testDropFirst() {
		let people = Lens {
				\Company.employees
		}
		
		XCTAssertEqual(
			people
				.dropFirst(1)
				.get(company),
			[ louis, jessica ]
		)
		
		XCTAssertEqual(
			people
				.dropFirst(2)
				.get(company),
			[ jessica ]
		)
		
		XCTAssertEqual(
			people
				.dropFirst(20)
				.get(company),
			[ ]
		)
		
		var updated = company
		
		people
			.dropFirst()
			.set(&updated, to: [ john ])
		
		XCTAssertEqual(
			updated.employees[1],
			john
		)
	}
}
