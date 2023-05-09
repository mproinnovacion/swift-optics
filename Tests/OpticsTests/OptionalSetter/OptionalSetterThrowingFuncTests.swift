import Foundation
import XCTest

import Optics

class OptionalSetterThrowingFuncTests: XCTestCase {
	func testFunc0() throws {
		struct Group {
			var f: () throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapThrows()

		var group = Group {
			true
		}

		group = zeroOptic.tryUpdating(in: group) { bool in
			bool == false
		}

		let zero = try group.f()
		XCTAssertEqual(zero, false)
	}
	
	func testFunc1() throws {
		struct Group {
			var f: (String) throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapThrows()

		var group = Group { _ in
			true
		}

		group = zeroOptic.tryUpdating(in: group) { bool in
			bool == false
		}

		let zero = try group.f("0")
		XCTAssertEqual(zero, false)
	}

	func testFunc2() throws {
		struct Group {
			var f: (String, String) throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapThrows()

		var group = Group { _, _ in
			true
		}

		group = zeroOptic.tryUpdating(in: group) { bool in
			bool == false
		}

		let zero = try group.f("0", "1")
		XCTAssertEqual(zero, false)
	}

	func testFunc3() throws {
		struct Group {
			var f: (String, String, String) throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapThrows()

		var group = Group { _, _, _ in
			true
		}

		group = zeroOptic.tryUpdating(in: group) { bool in
			bool == false
		}

		let zero = try group.f("0", "1", "2")
		XCTAssertEqual(zero, false)
	}

	func testFunc4() throws {
		struct Group {
			var f: (String, String, String, String) throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapThrows()

		var group = Group { _, _, _, _ in
			true
		}

		group = zeroOptic.tryUpdating(in: group) { bool in
			bool == false
		}

		let zero = try group.f("0", "1", "2", "3")
		XCTAssertEqual(zero, false)
	}

	func testFunc5() throws {
		struct Group {
			var f: (String, String, String, String, String) throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapThrows()

		var group = Group { _, _, _, _, _ in
			true
		}

		group = zeroOptic.tryUpdating(in: group) { bool in
			bool == false
		}

		let zero = try group.f("0", "1", "2", "3", "4")
		XCTAssertEqual(zero, false)
	}
	
	func testFunc6() throws {
		struct Group {
			var f: (String, String, String, String, String, String) throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapThrows()

		var group = Group { _, _, _, _, _, _ in
			true
		}

		group = zeroOptic.tryUpdating(in: group) { bool in
			bool == false
		}

		let zero = try group.f("0", "1", "2", "3", "4", "5")
		XCTAssertEqual(zero, false)
	}

	func testFunc0InVariable() throws {
		func f() throws -> Int {
			5
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}

		let result = try myFunc()

		XCTAssertEqual(result, 10)
	}

	func testFunc1InVariable() throws {
		func f(_ string: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}

		let result = try myFunc("hello")

		XCTAssertEqual(result, 10)
	}

	func testFunc2InVariable() throws {
		func f(_ string: String, _ string2: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}

		let result = try myFunc("hello", "world")

		XCTAssertEqual(result, 10)
	}

	func testFunc3InVariable() throws {
		func f(_ string: String, _ string2: String, _ string3: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}

		let result = try myFunc("hello", "2", "3")

		XCTAssertEqual(result, 10)
	}

	func testFunc4InVariable() throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}

		let result = try myFunc("hello", "2", "3", "4")

		XCTAssertEqual(result, 10)
	}

	func testFunc5InVariable() throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}

		let result = try myFunc("hello", "2", "3", "4", "5")

		XCTAssertEqual(result, 10)
	}

	func testFunc6InVariable() throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String, _ string6: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}

		let result = try myFunc("hello", "2", "3", "4", "5", "6")

		XCTAssertEqual(result, 10)
	}
}
