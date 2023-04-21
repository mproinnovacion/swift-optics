import Foundation
import XCTest

import Algebra

import Optics

fileprivate struct Group {
	var strings: [String]
}

//class ReduceTests: XCTestCase {
//	func testReduce() {
//		let optic = Reduce {
//			\Group.strings
//			[String].optic()
//		}
//		
//		let group = Group(
//			strings: [
//				"hello", "world", "bye"
//			]
//		)
//		
//		XCTAssertEqual(
//			optic.reduced(group, Int.sum) { $0.count },
//			13
//		)
//		
//		
//		XCTAssertEqual(
//			optic.reduced(group, String.monoid) { $0 },
//			"helloworldbye"
//		)
//	}
//}
