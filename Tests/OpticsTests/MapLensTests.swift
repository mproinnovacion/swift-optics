import Foundation
import XCTest

import Optics

class MapLensTests: XCTestCase {
	func testMap() {
		let optic = Lens {
			\(String, Int).0
		}.map { string in
			string.count
		} to: { old, number in
			String(old.prefix(number))
		}

		XCTAssertEqual(
			optic.get(("hello", 7)),
			5
		)
		
		XCTAssertEqual(
			optic.setting(
				("hello", 7),
				to: 3
			).0,
			"hel"
		)
	}
}
