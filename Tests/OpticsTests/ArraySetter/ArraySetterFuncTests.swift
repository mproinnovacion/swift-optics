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

class ManySetterFuncTests: XCTestCase {
	func testFunc() {
		let zeroOptic =
		Many {
			\Group.zero
		}.mapFunc()
		
		let oneOptic = Many {
			\Group.one
		}.mapFunc()
		
		let twoOptic = Many {
			\Group.two
		}.mapFunc()
		
		let threeOptic =
		Many {
			\Group.three
		}.mapFunc()
		
		let fourOptic =
		Many {
			\Group.four
		}.mapFunc()
		
		let fiveOptic =
		Many {
			\Group.five
		}.mapFunc()
		
		let sixOptic =
		Many {
			\Group.six
		}.mapFunc()
		
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
		
		zeroOptic.updateAll(&group) { bool in
			bool.toggle()
		}
		
		oneOptic.updateAll(&group) { bool in
			bool.toggle()
		}
		
		twoOptic.updateAll(&group) { bool in
			bool.toggle()
		}
		
		threeOptic.updateAll(&group) { bool in
			bool.toggle()
		}
		
		fourOptic.updateAll(&group) { bool in
			bool.toggle()
		}
		
		fiveOptic.updateAll(&group) { bool in
			bool.toggle()
		}
		
		sixOptic.updateAll(&group) { bool in
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
	
	func testFunc0InVariable() {
		func f() -> Int {
			5
		}
		
		var myFunc = f
		
		let setter = ManySetter {
			myFunc
		}
		
		myFunc = setter.updatingAll { number in
			number * 2
		}
		
		let result = myFunc()
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc1InVariable() {
		func f(_ string: String) -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = ManySetter {
			myFunc
		}
		
		myFunc = setter.updatingAll { number in
			number * 2
		}
		
		let result = myFunc("hello")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc2InVariable() {
		func f(_ string: String, _ string2: String) -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = ManySetter {
			myFunc
		}
		
		myFunc = setter.updatingAll { number in
			number * 2
		}
		
		let result = myFunc("hello", "world")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc3InVariable() {
		func f(_ string: String, _ string2: String, _ string3: String) -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = ManySetter {
			myFunc
		}
		
		myFunc = setter.updatingAll { number in
			number * 2
		}
		
		let result = myFunc("hello", "2", "3")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc4InVariable() {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String) -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = ManySetter {
			myFunc
		}
		
		myFunc = setter.updatingAll { number in
			number * 2
		}
		
		let result = myFunc("hello", "2", "3", "4")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc5InVariable() {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String) -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = ManySetter {
			myFunc
		}
		
		myFunc = setter.updatingAll { number in
			number * 2
		}
		
		let result = myFunc("hello", "2", "3", "4", "5")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc6InVariable() {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String, _ string6: String) -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = ManySetter {
			myFunc
		}
		
		myFunc = setter.updatingAll { number in
			number * 2
		}
		
		let result = myFunc("hello", "2", "3", "4", "5", "6")
		
		XCTAssertEqual(result, 10)
	}
}
