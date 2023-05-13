import Foundation
import XCTest
import Optics
import CasePaths

class OptionalGetterOpticTests: XCTestCase {
	func testOptionally() {
		var read = false
		
		let advisor = Optionally {
			\Company.advisor
			Prism {
				/Failable<Person>?.some
				/Failable<Person>.valid
			}
		}.onGet {
			read = true
		}
		
		let advisorName = OptionalGetter {
			advisor
			\Person.name
		}
		
		XCTAssertEqual(
			advisorName.provide(company).tryGet(),
			nil
		)
		
		XCTAssertEqual(read, true)
	}
}
