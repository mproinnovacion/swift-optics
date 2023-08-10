import Foundation
import XCTest

import Optics

class CompactMapArrayTests: XCTestCase {
	func testMapArray() {
		let optic: some ArrayGetterOptic<[String], String?> = [String].optic().compactMap { string in
			guard string.count > 5 else {
				return nil
			}
			
			return String(string.reversed())
		}
		
		let strings = [
			"hello",
			"world!"
		]
		
		XCTAssertEqual(
			optic.getAll(strings),
			["!dlrow"]
		)
	}
	
	func testConversion() {
		let reverseStrings: Conversion<String, String?> = Conversion { string in
			let string = string ?? ""
			return String(string.reversed())
		} to: { string in
			guard string.count > 5 else {
				return nil
			}
			
			return String(string.reversed())
		}

		let optic = [String].optic().compactMap(reverseStrings)
		
		let strings = [
			"hello",
			"world!"
		]
		
		XCTAssertEqual(
			optic.getAll(strings),
			["!dlrow"]
		)
	}
}
