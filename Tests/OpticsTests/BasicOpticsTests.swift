import Foundation
import XCTest

import Optics

enum MyError: Error {
	case error
}

class BasicOpticsTests: XCTestCase {
	func testArray() {
		let array = [1,2,3]
		
		XCTAssertEqual(
			[Int].optic().getAll(array),
			array
		)
		
		XCTAssertEqual(
			[Int].optic().updatingAll(in: array) { $0 * 2 },
			[2,4,6]
		)
	}
	
	func testSet() {
		let set = Set([1,2,3])
		
		XCTAssertEqual(
			Set<Int>.optic().getAll(set).sorted(),
			[1,2,3]
		)
		
		XCTAssertEqual(
			Set<Int>.optic().updatingAll(in: set) { $0 * 2 },
			Set([2,4,6])
		)
	}
	
	func testDictionary() {
		let dic = [
			"0": 1,
			"1": 2,
			"2": 3
		]
		
		XCTAssertEqual(
			[String: Int].valuesOptic().getAll(dic).sorted(),
			[1,2,3]
		)
		
		XCTAssertEqual(
			[String: Int].valuesOptic().updatingAll(in: dic) { $0 * 2 },
			[
				"0": 2,
				"1": 4,
				"2": 6
			]
		)
	}
	
	func testOptional() {
		let some: Int? = 1
		let none: Int? = nil
		
		XCTAssertEqual(
			Int?.optic().extract(from: some),
			1
		)
		
		XCTAssertEqual(
			Int?.optic().tryUpdating(in: some) { $0 * 2 },
			2
		)
		
		XCTAssertEqual(
			Int?.optic().extract(from: none),
			nil
		)
		
		XCTAssertEqual(
			Int?.optic().tryUpdating(in: none) { $0 * 2 },
			nil
		)
	}
	
	func testResult() {
		let success = Result<Int, MyError>.success(1)
		let fail = Result<Int, MyError>.failure(.error)
		
		XCTAssertEqual(
			Result<Int, MyError>.optic().extract(from: success),
			1
		)
		
		XCTAssertEqual(
			Result<Int, MyError>.optic().tryUpdating(in: success) { $0 * 2 },
			.success(2)
		)
		
		XCTAssertEqual(
			Result<Int, MyError>.optic().extract(from: fail),
			nil
		)
		
		XCTAssertEqual(
			Result<Int, MyError>.optic().tryUpdating(in: fail) { $0 * 2 },
			fail
		)
	}
}
