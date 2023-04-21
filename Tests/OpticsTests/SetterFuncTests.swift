import Foundation
import XCTest

import Optics

fileprivate struct Group {
	var name: String
	var zero: () -> Bool
	var one: (String) -> Bool
	var two: (String, String) -> Bool
	var three: (String, String, String) -> Bool
	var four: (String, String, String, String) -> Bool
	var five: (String, String, String, String, String) -> Bool
	var six: (String, String, String, String, String, String) -> Bool
}

class SetterFuncTests: XCTestCase {
	func testFunc() {
		let zeroOptic =
			Lens {
				\Group.zero
			}.map()
		
		let oneOptic =
			Lens {
				\Group.one
			}.map()
		
		let twoOptic =
			Lens {
				\Group.two
			}.map()
		
		let threeOptic =
			Lens {
				\Group.three
			}.map()
		
		let fourOptic =
			Lens {
				\Group.four
			}.map()
		
		let fiveOptic =
			Lens {
				\Group.five
			}.map()
		
		let sixOptic =
			Lens {
				\Group.six
			}.map()
		
		var group = Group(name: "") {
			true
		} one: { p in
			p == "john"
		} two: { p0, p1 in
			p0 == p1
		} three: { p0, p1, p2 in
			p0 == p1 && p1 == p2
		} four: { p0, p1, p2, p3 in
			p0 == p1 && p1 == p2 && p2 == p3
		} five: { p0, p1, p2, p3, p4 in
			p0 == p1 && p1 == p2 && p2 == p3 && p3 == p4
		} six: { p0, p1, p2, p3, p4, p5 in
			p0 == p1 && p1 == p2 && p2 == p3 && p3 == p4 && p4 == p5
		}

		
		zeroOptic.update(&group) { bool in
			bool.toggle()
		}
		
		oneOptic.update(&group) { bool in
			bool.toggle()
		}
		
		twoOptic.update(&group) { bool in
			bool.toggle()
		}
		
		threeOptic.update(&group) { bool in
			bool.toggle()
		}
		
		fourOptic.update(&group) { bool in
			bool.toggle()
		}
		
		fiveOptic.update(&group) { bool in
			bool.toggle()
		}
		
		sixOptic.update(&group) { bool in
			bool.toggle()
		}
		
		
		XCTAssertEqual(group.zero(), false)
		
		XCTAssertEqual(group.one("john"), false)
		XCTAssertEqual(group.one("joe"), true)
		
		XCTAssertEqual(group.two("one", "one"), false)
		XCTAssertEqual(group.two("one", "two"), true)
		
		XCTAssertEqual(group.three("one", "one", "one"), false)
		XCTAssertEqual(group.three("one", "two", "one"), true)
		
		XCTAssertEqual(group.four("one", "one", "one", "one"), false)
		XCTAssertEqual(group.four("one", "two", "one", "one"), true)
		
		XCTAssertEqual(group.five("one", "one", "one", "one", "one"), false)
		XCTAssertEqual(group.five("one", "two", "one", "one", "one"), true)
		
		XCTAssertEqual(group.six("one", "one", "one", "one", "one", "one"), false)
		XCTAssertEqual(group.six("one", "two", "one", "one", "one", "one"), true)
	}
}
