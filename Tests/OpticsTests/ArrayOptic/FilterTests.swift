import Foundation
import Optics
import XCTest

fileprivate struct Group {
	var strings: [String]?
}

class FilterTests: XCTestCase {
	func testFilter() {
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
		}

		XCTAssertEqual(
			even.getAll(company),
			[ john, mike ]
		)

		var local = company
		local = even.updatingAll(in: local) { person in
			var result = person
			result.name = result.name.uppercased()
			return result
		}

		let evenNames = Many {
			even
			\Person.name
		}

		XCTAssertEqual(
			evenNames.getAll(
				evenNames.updatingAll(in: company) { name in
					name = name.uppercased()
				}
			),
			[ "JOHN", "MIKE" ]
		)
	}
	
	func testFilterIndexed() {
		let even = (\Company.freelance).filterIndexed { index, _ in
			index % 2 == 0
		}

		XCTAssertEqual(
			even.getAll(company),
			[ john, mike ]
		)

		var local = company
		local = even.updatingAll(in: local) { person in
			var result = person
			result.name = result.name.uppercased()
			return result
		}

		let evenNames = Many {
			even
			\Person.name
		}

		XCTAssertEqual(
			evenNames.getAll(
				evenNames.updatingAll(in: company) { name in
					name = name.uppercased()
				}
			),
			[ "JOHN", "MIKE" ]
		)
	}
	
	func testEven() {
		let even = (\Company.freelance).selectEven()

		XCTAssertEqual(
			even.getAll(company),
			[ john, mike ]
		)

		var local = company
		local = even.updatingAll(in: local) { person in
			var result = person
			result.name = result.name.uppercased()
			return result
		}

		let evenNames = Many {
			even
			\Person.name
		}

		XCTAssertEqual(
			evenNames.getAll(
				evenNames.updatingAll(in: company) { name in
					name = name.uppercased()
				}
			),
			[ "JOHN", "MIKE" ]
		)
	}
	
	func testOdd() {
		let odd = (\Company.freelance).selectOdd()

		XCTAssertEqual(
			odd.getAll(company),
			[ joe ]
		)

		var local = company
		local = odd.updatingAll(in: local) { person in
			var result = person
			result.name = result.name.uppercased()
			return result
		}

		let oddNames = Many {
			odd
			\Person.name
		}

		XCTAssertEqual(
			oddNames.getAll(
				oddNames.updatingAll(in: company) { name in
					name = name.uppercased()
				}
			),
			[ "JOE" ]
		)
	}
	
	func testFilterIndexedOptional() {
		let even = Optionally {
			\Group.strings
			[String]?.optic()
		}.filterIndexed { index, _ in
			index % 2 == 0
		}
		
		var group = Group(
			strings: [
				"hello",
				"world"
			]
		)

		XCTAssertEqual(
			even.getAll(group),
			[ "hello" ]
		)

		even.updateAll(in: &group) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			group.strings,
			[ "HELLO", "world" ]
		)
	}
}
