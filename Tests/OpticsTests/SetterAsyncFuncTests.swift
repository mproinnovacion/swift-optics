import Foundation
import XCTest

import Optics

fileprivate struct Group {
	var name: String
	var zero: () async -> Bool
	var one: (String) async -> Bool
}

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
	
//	func testFuncInVariable() async {
//		func asyncF(_ string: String) async -> Int {
//			string.count
//		}
//		
//		var myFunc = asyncF
//		
//		let setter = Setter {
//			Setter {
//				\Self.myFunc
//			}.mapAsync()
//		}
//		
//		setter.update(&myFunc) { number in
//			number * 2
//		}
//	}
}
