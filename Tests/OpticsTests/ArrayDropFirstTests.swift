import Foundation
import XCTest
import Optics

class ArrayDropFirstTests: XCTestCase {
	func testDropFirst() {
		let people = Many {
			\Company.employees
			[Person].optic()
		}
		
		XCTAssertEqual(
			people
				.dropFirst(1)
				.getAll(company),
			[ louis, jessica ]
		)
		
		XCTAssertEqual(
			people
				.dropFirst(2)
				.getAll(company),
			[ jessica ]
		)
		
		XCTAssertEqual(
			people
				.dropFirst(20)
				.getAll(company),
			[ ]
		)
		
		var updated = company
		
		people
			.dropFirst()
			.setAll(in: &updated, to: john)
		
		XCTAssertEqual(
			updated.employees[0],
			company.employees[0]
		)
		
		XCTAssertEqual(
			updated.employees[1],
			john
		)
		
		XCTAssertEqual(
			updated.employees[2],
			john
		)
	}
}
