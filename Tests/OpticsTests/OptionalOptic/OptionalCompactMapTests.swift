import Foundation
import XCTest

import CasePaths

import Optics

class OptionalCompactMapTests: XCTestCase {
	func testCompactMap() {
		let advisor = Optionally {
			\Company.advisor
			Prism {
				/Failable<Person>?.some
				/Failable<Person>.valid
			}
		}
			
		let advisorLongName = OptionalGetter {
			advisor
			\Person.name
		}.flatMap { name in
			name.count > 5 ? name : nil
		}

		var updated = advisor.trySetting(in: company, to: john)
		
		XCTAssertNil(advisorLongName.tryGet(updated))
		
		updated = Optionally {
			advisor
			\Person.name
		}.trySetting(in: updated, to: "Mario Luigi")
		
		XCTAssertEqual(
			advisorLongName.tryGet(updated),
			"Mario Luigi"
		)
	}
}
