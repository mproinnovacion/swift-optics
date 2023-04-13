import Foundation
import XCTest

import Optics

fileprivate struct Item: Codable {
	var name: String?
	var date: Date
}

class ThrowingOpticTests: XCTestCase {
	func testThrowing() throws {
		let optic = Optionally {
			\Item.name
			String?.optic()
		}.throwing()
		
		let item = Item(
			name: "John",
			date: Date(timeIntervalSince1970: 1)
		)
		
		XCTAssertEqual(
			try optic.get(item),
			"John"
		)
		
		XCTAssertEqual(
			try optic.get(
				try optic.setting(item, to: "James")
			),
			"James"
		)
		
		XCTAssertEqual(
			try optic.get(
				try optic.updating(item) { $0 += "!" }
			),
			"John!"
		)
	}
	
	func testCombinator() throws {
		let optic = Throwing {
			\Item.name
			String?.optic()
		}
		
		let item = Item(
			name: "John",
			date: Date(timeIntervalSince1970: 1)
		)
		
		XCTAssertEqual(
			try optic.get(item),
			"John"
		)
		
		XCTAssertEqual(
			try optic.get(
				try optic.setting(item, to: "James")
			),
			"James"
		)
		
		XCTAssertEqual(
			try optic.get(
				try optic.updating(item) { $0 += "!" }
			),
			"John!"
		)
	}
	
	func testOptionalsCombinator() throws {
		let optic = Throwing {
			String?.optic()
		}
		
		var string: String? = "hello"
		
		XCTAssertEqual(
			try optic.get(string),
			"hello"
		)
			
		XCTAssertEqual(
			try optic.updating(string) {
				$0 + "!"
			},
			"hello!"
		)
		
		string = nil
		
		do {
			_ = try optic.get(string)
			
			XCTFail("Expected to throw")
		} catch {
			switch error {
				case ThrowingError.noData:
					break
				default:
					XCTFail("Unknown error")
			}
		}
		
		do {
			try optic.update(&string) { $0 + "!" }
			
			XCTFail("Expected to throw")
		} catch {
			switch error {
				case ThrowingError.noData:
					break
				default:
					XCTFail("Unknown error")
			}
		}
	}
}

