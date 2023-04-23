import Foundation
import XCTest

import Algebra

import Optics

fileprivate struct Group {
	var strings: [String]
	var name: String
	var isBig: Bool
}

class FoldTests: XCTestCase {
	func testFold() {
		let optic = Fold(monoid: .all) {
			ArrayGetter {
				\Group.isBig
			}
			
			Fold(monoid: .any) {
				Getter {
					\Group.name
				}.map { string in
					string.count > 0
				}

				Getter {
					\Group.name
				}.map { string in
					string.contains("h")
				}
			}

			ArrayGetter {
				Getter {
					\Group.strings
				}.map { strings in
					strings.count > 0
				}
			}
		}
		
		let group = Group(
			strings: [ "hello", "world" ],
			name: "group",
			isBig: true
		)
		
		XCTAssertEqual(
			optic.get(group),
			true
		)
	}
	
	func testBool() {
		let optic = And {
			ArrayGetter {
				\Group.isBig
			}
			
			Or {
				Getter {
					\Group.name
				}.map { string in
					string.count > 0
				}

				Getter {
					\Group.name
				}.map { string in
					string.contains("h")
				}
			}

			ArrayGetter {
				Getter {
					\Group.strings
				}.map { strings in
					strings.count > 0
				}
			}
		}
		
		let group = Group(
			strings: [ "hello", "world" ],
			name: "group",
			isBig: true
		)
		
		XCTAssertEqual(
			optic.get(group),
			true
		)
	}
	
//	func testReduce() {
//		let optic = Fold(monoid: Monoid<Bool>.any) {
//
//		}
//
//		Fold {
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
}
