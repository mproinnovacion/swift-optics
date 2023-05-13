import Foundation
import XCTest
import Optics

class ArrayTakeFirstTests: XCTestCase {
	func testTakeFirst() {
		let people = Many {
			\Company.employees
			[Person].optic()
		}
		
		XCTAssertEqual(
			people
				.takeFirst(1)
				.getAll(company),
			[ mike ]
		)
		
		XCTAssertEqual(
			people
				.takeFirst(2)
				.getAll(company),
			[ mike, louis ]
		)
		
		XCTAssertEqual(
			people
				.takeFirst(0)
				.getAll(company),
			[ ]
		)
		
		var updated = company
		
		people
			.takeFirst()
			.setAll(in: &updated, to: john)
		
		XCTAssertEqual(
			updated.employees[0],
			john
		)
				
		XCTAssertEqual(
			updated.employees[1],
			louis
		)
	}
}
