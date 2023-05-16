import Foundation
import XCTest
import Optics
import CasePaths

class MapOptionalGetterTests: XCTestCase {
	func testMap() {
		let advisor = Optionally {
			\Company.advisor
			Prism {
				/Failable<Person>?.some
				/Failable<Person>.valid
			}
		}
		
		var local = company
		advisor.trySet(in: &local, to: jessica)
		
		let advisorNameShouted = OptionalGetter {
			advisor
			\Person.name
		}.map { string in
			string + "!"
		}
		
		XCTAssertEqual(
			advisorNameShouted.tryGet(local),
			"Jessica!"
		)
	}
}
