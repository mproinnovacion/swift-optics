import Foundation
import Optics
import XCTest

class ZipTests: XCTestCase {
	func testZip() {
		var local = company
		
		let ageAndName = Zip {
			Lens {
				\Company.ceo
				\Person.age
			}
			
			Lens {
				\Company.cto
				\Person.name
			}
		}
		
		XCTAssert(
			ageAndName.get(local) == (50, "Harvey")
		)
		
		ageAndName.update(in: &local) {
			$0.0 += 1
			$0.1 = $0.1.uppercased()
		}
		
		XCTAssert(
			ageAndName.get(local) == (51, "HARVEY")
		)
	}
}
