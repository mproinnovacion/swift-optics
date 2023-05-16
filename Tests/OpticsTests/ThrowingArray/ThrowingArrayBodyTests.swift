import Foundation
import XCTest

import Optics

fileprivate struct Item: Codable {
	var strings: [String]?
}

fileprivate struct ItemStringsOptic: ThrowingArrayOptic {
	typealias Whole = Item
	typealias NewWhole = Item
	typealias Part = String
	typealias NewPart = String
	
	var body: some SimpleThrowingArrayOptic<Item, String> {
		ManyThrowing {
			\Item.strings
			[String]?.optic()
			[String].optic()
		}
	}
}

class ThrowingArrayBodyTests: XCTestCase {
	func testThrowingArray() throws {
		let item = Item(
			strings: ["hello", "world", "bye", "earth"]
		)
		
		XCTAssertEqual(
			try ItemStringsOptic().getAll(item),
			["hello", "world", "bye", "earth"]
		)
		
		XCTAssertEqual(
			try ItemStringsOptic().getAll(
				try ItemStringsOptic().updatingAll(in: item) { $0 + "!" }
			),
			["hello!", "world!", "bye!", "earth!"]
		)
		
		XCTAssertEqual(
			try ItemStringsOptic().getAll(
				try ItemStringsOptic().settingAll(in: item, to: "fix")
			),
			["fix", "fix", "fix", "fix"]
		)
	}
	
	func testArrayThrowing() throws {
		let optic = ManyThrowing {
			\Item.strings
			
			[String]?.optic()
			
			Many {
				[String].optic()
			}.throwing()
		}
		
		let item = Item(
			strings: ["hello", "world", "bye", "earth"]
		)
		
		XCTAssertEqual(
			try optic.getAll(
				try optic.settingAll(in: item, to: "fix")
			),
			["fix", "fix", "fix", "fix"]
		)
	}
}
