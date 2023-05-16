import Foundation
import Optics
import XCTest

fileprivate struct Group {
	var strings: [String]?
}

class ThrowingArrayFilterTests: XCTestCase {
	func testFilter() throws {
		let even = MapArray {
			Filter {
				$0.0 % 2 == 0
			} with: {
				Each {
					Enumerated {
						\Company.freelance
					}
				}
			}
		} from: { (indexed: (Int, Person)) -> Person in
			indexed.1
		} to: { (original, updated) -> (Int, Person) in
			(original.0, updated)
		}.throwing()

		XCTAssertEqual(
			try even.getAll(company),
			[ john, mike ]
		)

		var local = company
		local = try even.updatingAll(in: local) { person in
			var result = person
			result.name = result.name.uppercased()
			return result
		}

		let evenNames = ManyThrowing {
			even
			\Person.name
		}

		XCTAssertEqual(
			try evenNames.getAll(
				try evenNames.updatingAll(in: company) { name in
					name = name.uppercased()
				}
			),
			[ "JOHN", "MIKE" ]
		)
	}
}
