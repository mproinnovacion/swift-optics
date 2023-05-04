import Foundation
import XCTest

import Optics

class OptionalSetterAsyncThrowingFuncTests: XCTestCase {
	func testFunc0() async throws {
		struct Group {
			var f: () async throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapAsyncThrows()

		var group = Group {
			true
		}

		group = zeroOptic.tryUpdating(group) { bool in
			bool == false
		}

		let zero = try await group.f()
		XCTAssertEqual(zero, false)
	}
	
	func testFunc1() async throws {
		struct Group {
			var f: (String) async throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _ in
			true
		}

		group = zeroOptic.tryUpdating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0")
		XCTAssertEqual(zero, false)
	}

	func testFunc2() async throws {
		struct Group {
			var f: (String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _ in
			true
		}

		group = zeroOptic.tryUpdating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1")
		XCTAssertEqual(zero, false)
	}

	func testFunc3() async throws {
		struct Group {
			var f: (String, String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _, _ in
			true
		}

		group = zeroOptic.tryUpdating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1", "2")
		XCTAssertEqual(zero, false)
	}

	func testFunc4() async throws {
		struct Group {
			var f: (String, String, String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _, _, _ in
			true
		}

		group = zeroOptic.tryUpdating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1", "2", "3")
		XCTAssertEqual(zero, false)
	}

	func testFunc5() async throws {
		struct Group {
			var f: (String, String, String, String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _, _, _, _ in
			true
		}

		group = zeroOptic.tryUpdating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1", "2", "3", "4")
		XCTAssertEqual(zero, false)
	}
	
	func testFunc6() async throws {
		struct Group {
			var f: (String, String, String, String, String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleOptionalSetterOptic<Group, Bool> = OptionalSetter {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _, _, _, _, _ in
			true
		}

		group = zeroOptic.tryUpdating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1", "2", "3", "4", "5")
		XCTAssertEqual(zero, false)
	}

	func testFunc0InVariable() async throws {
		func f() async throws -> Int {
			5
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}.run

		let result = try await myFunc()

		XCTAssertEqual(result, 10)
	}

	func testFunc1InVariable() async throws {
		func f(_ string: String) async throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}.run

		let result = try await myFunc("hello")

		XCTAssertEqual(result, 10)
	}

	func testFunc2InVariable() async throws {
		func f(_ string: String, _ string2: String) async throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}.run

		let result = try await myFunc("hello", "world")

		XCTAssertEqual(result, 10)
	}

	func testFunc3InVariable() async throws {
		func f(_ string: String, _ string2: String, _ string3: String) async throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}.run

		let result = try await myFunc("hello", "2", "3")

		XCTAssertEqual(result, 10)
	}

	func testFunc4InVariable() async throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String) async throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}.run

		let result = try await myFunc("hello", "2", "3", "4")

		XCTAssertEqual(result, 10)
	}

	func testFunc5InVariable() async throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String) async throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}.run

		let result = try await myFunc("hello", "2", "3", "4", "5")

		XCTAssertEqual(result, 10)
	}

	func testFunc6InVariable() async throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String, _ string6: String) async throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = OptionalSetter {
			myFunc
		}

		myFunc = setter.tryUpdating { number in
			number * 2
		}.run

		let result = try await myFunc("hello", "2", "3", "4", "5", "6")

		XCTAssertEqual(result, 10)
	}
}
