import Foundation
import XCTest

import Optics

fileprivate struct Group {
	var name: String
	var zero: () async -> Bool
	var one: (String) async -> Bool
}

@MainActor
class SetterAsyncFuncTests: XCTestCase {
	func testFunc() async {
		let zeroOptic =
			Lens {
				\Group.zero
			}.mapAsync()
		
		let oneOptic =
			Lens {
				\Group.one
			}.mapAsync()
		
		var group = Group(name: "") {
			true
		} one: { p in
			p == "john"
		}

		zeroOptic.update(&group) { bool in
			bool.toggle()
		}
		
		oneOptic.update(&group) { bool in
			bool.toggle()
		}
		
		let zero = await group.zero()
		XCTAssertEqual(zero, false)
		
		let oneFalse = await group.one("john")
		let oneTrue = await group.one("joe")
		XCTAssertEqual(oneFalse, false)
		XCTAssertEqual(oneTrue, true)
	}
	
	func testFunc0InVariable() async {
		func f() async -> Int {
			5
		}

		var myFunc = f

		let setter = Setter {
			myFunc
		}

		myFunc = setter.updating { number in
			number * 2
		}

		let result = await myFunc()

		XCTAssertEqual(result, 10)
	}
	
	func testFunc1InVariable() async {
		func f(_ string: String) async -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = Setter {
			myFunc
		}
		
		myFunc = setter.updating { number in
			number * 2
		}
		
		let result = await myFunc("hello")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc2InVariable() async {
		func f(_ string: String, _ string2: String) async -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = Setter {
			myFunc
		}
		
		myFunc = setter.updating { number in
			number * 2
		}
		
		let result = await myFunc("hello", "world")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc3InVariable() async {
		func f(_ string: String, _ string2: String, _ string3: String) async -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = Setter {
			myFunc
		}
		
		myFunc = setter.updating { number in
			number * 2
		}
		
		let result = await myFunc("hello", "2", "3")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc4InVariable() async {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String) async -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = Setter {
			myFunc
		}
		
		myFunc = setter.updating { number in
			number * 2
		}
		
		let result = await myFunc("hello", "2", "3", "4")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc5InVariable() async {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String) async -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = Setter {
			myFunc
		}
		
		myFunc = setter.updating { number in
			number * 2
		}
		
		let result = await myFunc("hello", "2", "3", "4", "5")
		
		XCTAssertEqual(result, 10)
	}
	
	func testFunc6InVariable() async {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String, _ string6: String) async -> Int {
			string.count
		}
		
		var myFunc = f
		
		let setter = Setter {
			myFunc
		}
		
		myFunc = setter.updating { number in
			number * 2
		}
		
		let result = await myFunc("hello", "2", "3", "4", "5", "6")
		
		XCTAssertEqual(result, 10)
	}
}
