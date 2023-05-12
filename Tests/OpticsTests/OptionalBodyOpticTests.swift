import Foundation
import XCTest
import Optics
import CasePaths

fileprivate struct Group {
	var name: String?
}

fileprivate struct GroupNameOptic: OptionalOptic {
	fileprivate typealias Whole = Group
	fileprivate typealias NewWhole = Group
	fileprivate typealias Part = String
	fileprivate typealias NewPart = String
	
	var body: some SimpleOptionalOptic<Group, String> {
		Optionally {
			\Group.name
			String?.optic()
		}
	}
}

class OptionalBodyOpticTests: XCTestCase {
	func testOptionally() {
		let withName = Group(name: "group")
		let noName = Group()
		
		XCTAssertEqual(
			GroupNameOptic().tryGet(withName),
			"group"
		)
		
		XCTAssertEqual(
			GroupNameOptic().tryGet(
				GroupNameOptic().trySetting(in: withName, to: "item")
			),
			"item"
		)
		
		XCTAssertEqual(
			GroupNameOptic().tryGet(noName),
			nil
		)
		
		XCTAssertEqual(
			GroupNameOptic().tryGet(
				GroupNameOptic().tryUpdating(in: noName) { $0 + "!" }
			),
			nil
		)
		
		XCTAssertEqual(
			GroupNameOptic().tryGet(
				GroupNameOptic().trySetting(in: noName, to: "item")
			),
			"item"
		)
	}
}
