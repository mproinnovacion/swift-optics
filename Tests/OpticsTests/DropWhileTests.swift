import Foundation
import XCTest
import Optics

class DropWhileTests: XCTestCase {
	func testDropWhile() {
		let people = Lens {
			\Company.employees
		}
		
		XCTAssertEqual(
			people
				.dropWhile { person in
					person.age < 40
				}
				.get(company),
			[ louis, jessica ]
		)
		
		XCTAssertEqual(
			Lens {
				people
				\Person.name
			}.get(
				Lens {
					people.dropWhile { person in
						person.age < 40
					}
					\Person.name
				}.each().updatingAll(company) {
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
				.get(company),
			[]
		)
	}
}
