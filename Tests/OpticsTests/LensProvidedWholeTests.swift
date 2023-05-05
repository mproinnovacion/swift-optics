import Foundation
import XCTest

import Optics

class LastProvidedWholeTests: XCTestCase {
	func testLast() {
		let ceoAge = Lens {
			\Company.ceo
			\Person.age
		}.provide(company)

		XCTAssertEqual(
			ceoAge.get(),
			50
		)

		let local = ceoAge.updating { $0 + 1 }
			
		XCTAssertEqual(local.ceo.age, 51)
		
		let local2 = ceoAge.setting(to: 22)
			
		XCTAssertEqual(local2.ceo.age, 22)
	}
}
