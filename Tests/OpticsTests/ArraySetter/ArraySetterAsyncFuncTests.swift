import Foundation
import XCTest

import Optics

@MainActor
class ArraySetterAsyncFuncTests: XCTestCase {
	func testFunc0() async {
		struct Group {
			var f: () async -> Bool
		}
		
		let zeroOptic: some SimpleArraySetterOptic<Group, Bool> = ManySetter {
			\Group.f
		}.mapAsync()

		var group = Group {
			true
		}

		group = zeroOptic.updatingAll(in: group) { bool in
			bool == false
		}

		let zero = await group.f()
		XCTAssertEqual(zero, false)
	}
	
	func testFunc1() async {
		struct Group {
			var f: (String) async -> Bool
		}

		let zeroOptic: some SimpleArraySetterOptic<Group, Bool> = ManySetter {
			\Group.f
		}.mapAsync()

		var group = Group { _ in
			true
		}

		group = zeroOptic.updatingAll(in: group) { bool in
			bool == false
		}

		let zero = await group.f("0")
		XCTAssertEqual(zero, false)
	}
	
	func testFunc2() async {
		struct Group {
			var f: (String, String) async -> Bool
		}

		let zeroOptic: some SimpleArraySetterOptic<Group, Bool> = ManySetter {
			\Group.f
		}.mapAsync()

		var group = Group { _, _ in
			true
		}

		group = zeroOptic.updatingAll(in: group) { bool in
			bool == false
		}

		let zero = await group.f("0", "1")
		XCTAssertEqual(zero, false)
	}
	
	func testFunc3() async {
		struct Group {
			var f: (String, String, String) async -> Bool
		}

		let zeroOptic: some SimpleArraySetterOptic<Group, Bool> = ManySetter {
			\Group.f
		}.mapAsync()

		var group = Group { _, _, _ in
			true
		}

		group = zeroOptic.updatingAll(in: group) { bool in
			bool == false
		}

		let zero = await group.f("0", "1", "2")
		XCTAssertEqual(zero, false)
	}
	
	func testFunc4() async {
		struct Group {
			var f: (String, String, String, String) async -> Bool
		}

		let zeroOptic: some SimpleArraySetterOptic<Group, Bool> = ManySetter {
			\Group.f
		}.mapAsync()

		var group = Group { _, _, _, _ in
			true
		}

		group = zeroOptic.updatingAll(in: group) { bool in
			bool == false
		}

		let zero = await group.f("0", "1", "2", "3")
		XCTAssertEqual(zero, false)
	}
	
	func testFunc5() async {
		struct Group {
			var f: (String, String, String, String, String) async -> Bool
		}

		let zeroOptic: some SimpleArraySetterOptic<Group, Bool> = ManySetter {
			\Group.f
		}.mapAsync()

		var group = Group { _, _, _, _, _ in
			true
		}

		group = zeroOptic.updatingAll(in: group) { bool in
			bool == false
		}

		let zero = await group.f("0", "1", "2", "3", "4")
		XCTAssertEqual(zero, false)
	}
	
	func testFunc6() async {
		struct Group {
			var f: (String, String, String, String, String, String) async -> Bool
		}

		let zeroOptic: some SimpleArraySetterOptic<Group, Bool> = ManySetter {
			\Group.f
		}.mapAsync()

		var group = Group { _, _, _, _, _, _ in
			true
		}

		group = zeroOptic.updatingAll(in: group) { bool in
			bool == false
		}

		let zero = await group.f("0", "1", "2", "3", "4", "5")
		XCTAssertEqual(zero, false)
	}

	func testFunc0InVariable() async {
		func f() async -> Int {
			5
		}

		var myFunc = f

		let setter = ManySetter {
			myFunc
		}

		myFunc = setter.updatingAll { number in
			number * 2
		}.run

		let result = await myFunc()

		XCTAssertEqual(result, 10)
	}

	func testFunc1InVariable() async {
		func f(_ string: String) async -> Int {
			string.count
		}

		var myFunc = f

		let setter = ManySetter {
			myFunc
		}

		myFunc = setter.updatingAll { number in
			number * 2
		}.run

		let result = await myFunc("hello")

		XCTAssertEqual(result, 10)
	}

	func testFunc2InVariable() async {
		func f(_ string: String, _ string2: String) async -> Int {
			string.count
		}

		var myFunc = f

		let setter = ManySetter {
			myFunc
		}

		myFunc = setter.updatingAll { number in
			number * 2
		}.run

		let result = await myFunc("hello", "world")

		XCTAssertEqual(result, 10)
	}

	func testFunc3InVariable() async {
		func f(_ string: String, _ string2: String, _ string3: String) async -> Int {
			string.count
		}

		var myFunc = f

		let setter = ManySetter {
			myFunc
		}

		myFunc = setter.updatingAll { number in
			number * 2
		}.run

		let result = await myFunc("hello", "2", "3")

		XCTAssertEqual(result, 10)
	}

	func testFunc4InVariable() async {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String) async -> Int {
			string.count
		}

		var myFunc = f

		let setter = ManySetter {
			myFunc
		}

		myFunc = setter.updatingAll { number in
			number * 2
		}.run

		let result = await myFunc("hello", "2", "3", "4")

		XCTAssertEqual(result, 10)
	}

	func testFunc5InVariable() async {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String) async -> Int {
			string.count
		}

		var myFunc = f

		let setter = ManySetter {
			myFunc
		}

		myFunc = setter.updatingAll { number in
			number * 2
		}.run

		let result = await myFunc("hello", "2", "3", "4", "5")

		XCTAssertEqual(result, 10)
	}

	func testFunc6InVariable() async {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String, _ string6: String) async -> Int {
			string.count
		}

		var myFunc = f

		let setter = ManySetter {
			myFunc
		}

		myFunc = setter.updatingAll { number in
			number * 2
		}.run

		let result = await myFunc("hello", "2", "3", "4", "5", "6")

		XCTAssertEqual(result, 10)
	}
}
