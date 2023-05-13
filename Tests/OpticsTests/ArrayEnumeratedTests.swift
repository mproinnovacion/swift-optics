import Foundation
import XCTest

import Optics

class ArrayEnumeratedTests: XCTestCase {
	func testEnumerated() {
		let optic = Many {
			\Company.freelance
			[Person].optic()
		}.enumerated()
		
		let enumerated = optic.getAll(company).map { index, element in (index, element)  }
		
		XCTAssertEqual(
			enumerated[0].0,
			0
		)
		
		XCTAssertEqual(
			enumerated[0].1,
			john
		)
		
		XCTAssertEqual(
			enumerated[1].0,
			1
		)
		
		XCTAssertEqual(
			enumerated[1].1,
			joe
		)
		
		XCTAssertEqual(
			enumerated[2].0,
			2
		)
		
		XCTAssertEqual(
			enumerated[2].1,
			mike
		)
		
		var updated = company
		updated = optic.updatingAll(in: updated) { pair in
			var person = pair.1
			person.age = pair.0
			return (pair.0, person)
		}
		
		let allAges = Many {
			\Company.freelance
			[Person].optic()
			\Person.age
		}
		
		XCTAssertEqual(
			allAges.getAll(updated),
			[0, 1, 2]
		)
	}
}
