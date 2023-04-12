import Foundation
import Optics
import XCTest

class FilterTests: XCTestCase {
	func testFilter() {
		let odd = MapArray {
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
		}

		XCTAssertEqual(
			odd.getAll(company),
			[ john, mike ]
		)

		var local = company
		local = odd.updatingAll(local, { person in
			var result = person
			result.name = result.name.uppercased()
			return result
		})

		let oddNames = Many {
			odd
			\Person.name
		}

		XCTAssertEqual(
			oddNames.getAll(
				oddNames.updatingAll(company, { name in
					name = name.uppercased()
				})
			),
			[ "JOHN", "MIKE" ]
		)
	}
	
	func testFilterFunc() {
		let odd = (\Company.freelance).filterIndexed { index, _ in
			index % 2 == 0
		}

		XCTAssertEqual(
			odd.getAll(company),
			[ john, mike ]
		)

		var local = company
		local = odd.updatingAll(local, { person in
			var result = person
			result.name = result.name.uppercased()
			return result
		})

		let oddNames = Many {
			odd
			\Person.name
		}

		XCTAssertEqual(
			oddNames.getAll(
				oddNames.updatingAll(company, { name in
					name = name.uppercased()
				})
			),
			[ "JOHN", "MIKE" ]
		)
	}
}
