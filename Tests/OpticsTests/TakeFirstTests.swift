import Foundation
import XCTest
import Optics

class TakeFirstTests: XCTestCase {
	func testTakeFirst() {
		let people = Lens {
			\Company.employees
		}
		
		XCTAssertEqual(
			people
				.takeFirst(1)
				.get(company),
			[ mike ]
		)
		
		XCTAssertEqual(
			people
				.takeFirst(2)
				.get(company),
			[ mike, louis ]
		)
		
		XCTAssertEqual(
			people
				.takeFirst(0)
				.get(company),
			[ ]
		)
		
		var updated = company
		
		people
			.takeFirst()
			.set(in: &updated, to: [ john ])
		
		XCTAssertEqual(
			updated.employees[0],
			john
		)
	}
}
