import Foundation
import XCTest

import Optics

class SetterThrowingAsyncFuncTests: XCTestCase {
	func testFunc0() async throws {
		struct Group {
			var f: () async throws -> Bool
		}

		let zeroOptic: some SimpleSetterOptic<Group, Bool> = Lens {
			\Group.f
		}.mapAsyncThrows()

		var group = Group {
			true
		}

		group = zeroOptic.updating(group) { bool in
			bool == false
		}

		let zero = try await group.f()
		XCTAssertEqual(zero, false)
	}
	
	func testFunc1() async throws {
		struct Group {
			var f: (String) async throws -> Bool
		}

		let zeroOptic: some SimpleSetterOptic<Group, Bool> = Lens {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _ in
			true
		}

		group = zeroOptic.updating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0")
		XCTAssertEqual(zero, false)
	}

	func testFunc2() async throws {
		struct Group {
			var f: (String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleSetterOptic<Group, Bool> = Lens {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _ in
			true
		}

		group = zeroOptic.updating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1")
		XCTAssertEqual(zero, false)
	}

	func testFunc3() async throws {
		struct Group {
			var f: (String, String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleSetterOptic<Group, Bool> = Lens {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _, _ in
			true
		}

		group = zeroOptic.updating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1", "2")
		XCTAssertEqual(zero, false)
	}

	func testFunc4() async throws {
		struct Group {
			var f: (String, String, String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleSetterOptic<Group, Bool> = Lens {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _, _, _ in
			true
		}

		group = zeroOptic.updating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1", "2", "3")
		XCTAssertEqual(zero, false)
	}

	func testFunc5() async throws {
		struct Group {
			var f: (String, String, String, String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleSetterOptic<Group, Bool> = Lens {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _, _, _, _ in
			true
		}

		group = zeroOptic.updating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1", "2", "3", "4")
		XCTAssertEqual(zero, false)
	}
	
	func testFunc6() async throws {
		struct Group {
			var f: (String, String, String, String, String, String) async throws -> Bool
		}

		let zeroOptic: some SimpleSetterOptic<Group, Bool> = Lens {
			\Group.f
		}.mapAsyncThrows()

		var group = Group { _, _, _, _, _, _ in
			true
		}

		group = zeroOptic.updating(group) { bool in
			bool == false
		}

		let zero = try await group.f("0", "1", "2", "3", "4", "5")
		XCTAssertEqual(zero, false)
	}

	func testFunc0InVariable() async throws {
		func f() throws -> Int {
			5
		}

		var myFunc = f

		let setter = Setter {
			myFunc
		}

		myFunc = setter.updating { number in
			number * 2
		}

		let result = try await myFunc()

		XCTAssertEqual(result, 10)
	}

	func testFunc1InVariable() async throws {
		func f(_ string: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = Setter {
			myFunc
		}

		myFunc = setter.updating { number in
			number * 2
		}

		let result = try await myFunc("hello")

		XCTAssertEqual(result, 10)
	}

	func testFunc2InVariable() async throws {
		func f(_ string: String, _ string2: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = Setter {
			myFunc
		}

		myFunc = setter.updating { number in
			number * 2
		}

		let result = try await myFunc("hello", "world")

		XCTAssertEqual(result, 10)
	}

	func testFunc3InVariable() async throws {
		func f(_ string: String, _ string2: String, _ string3: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = Setter {
			myFunc
		}

		myFunc = setter.updating { number in
			number * 2
		}

		let result = try await myFunc("hello", "2", "3")

		XCTAssertEqual(result, 10)
	}

	func testFunc4InVariable() async throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = Setter {
			myFunc
		}

		myFunc = setter.updating { number in
			number * 2
		}

		let result = try await myFunc("hello", "2", "3", "4")

		XCTAssertEqual(result, 10)
	}

	func testFunc5InVariable() async throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = Setter {
			myFunc
		}

		myFunc = setter.updating { number in
			number * 2
		}

		let result = try await myFunc("hello", "2", "3", "4", "5")

		XCTAssertEqual(result, 10)
	}

	func testFunc6InVariable() async throws {
		func f(_ string: String, _ string2: String, _ string3: String, _ string4: String, _ string5: String, _ string6: String) throws -> Int {
			string.count
		}

		var myFunc = f

		let setter = Setter {
			myFunc
		}

		myFunc = setter.updating { number in
			number * 2
		}

		let result = try await myFunc("hello", "2", "3", "4", "5", "6")

		XCTAssertEqual(result, 10)
	}
}
