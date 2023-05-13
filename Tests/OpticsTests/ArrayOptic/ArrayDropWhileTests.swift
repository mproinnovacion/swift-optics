import Foundation
import XCTest
import Optics

class ArrayDropWhileTests: XCTestCase {
	func testDropWhile() {
		let people = Many {
			\Company.employees
			[Person].optic()
		}
		
		XCTAssertEqual(
			people
				.dropWhile { person in
					person.age < 40
				}
				.getAll(company),
			[ louis, jessica ]
		)
		
		XCTAssertEqual(
			Many {
				people
				\Person.name
			}.getAll(
				Many {
					people.dropWhile { person in
						person.age < 40
					}
					\Person.name
				}.updatingAll(in: company) {
					$0.uppercased()
				}
			),
			[
				"Mike" , "LOUIS", "JESSICA"
			]
		)
		
		XCTAssertEqual(
			people
				.dropWhile { person in
					person.age > 0
				}
				.getAll(company),
			[]
		)
	}
}
