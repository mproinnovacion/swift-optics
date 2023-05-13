import Foundation
import XCTest

import Optics

class MapArrayTests: XCTestCase {
	func testMapArray() {
		
		let optic = [String].optic().map { string in
			String(string.reversed())
		} to: { (_, string: String) in
			String(string.reversed())
		}
		
		let strings = [
			"hello",
			"world"
		]
		
		XCTAssertEqual(
			optic.getAll(strings),
			["olleh", "dlrow"]
		)
	}
	
	func testConversion() {
		let reverseStrings: Conversion<String, String> = Conversion {
			String($0.reversed())
		} to: {
			String($0.reversed())
		}

		let optic = [String].optic().map(reverseStrings)
		
		let strings = [
			"hello",
			"world"
		]
		
		XCTAssertEqual(
			optic.getAll(strings),
			["olleh", "dlrow"]
		)
	}
}
