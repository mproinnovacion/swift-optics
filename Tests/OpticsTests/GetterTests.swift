import Foundation
import Optics
import XCTest

fileprivate func getCompany() -> Company {
	company
}

class GetterTests: XCTestCase {
	func testGetter() {
		let optic: some GetterOptic<Void, Int> = Get {
			getCompany
			
			Lens {
				\Company.ceo
				\Person.age
			}
		}
		
		XCTAssertEqual(
			optic.get(),
			50
		)
	}
}
