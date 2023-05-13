import Foundation
import XCTest

import Algebra

import Optics

class FoldMapTests: XCTestCase {
	func testFoldMap() {
		let optic = Many {
			\Company.employees
			[Person].optic()
		}.foldMap(Monoid.max) { person in
			person.age
		}
		
		XCTAssertEqual(
			optic.tryGet(company),
			65
		)
	}
}
