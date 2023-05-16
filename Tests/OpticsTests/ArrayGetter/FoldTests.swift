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
			ManyGetter {
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
			
			ManyGetter {
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
		let groupNameIsEmpty = Getter {
			\Group.name
		}.map { string in
			string.count > 0
		}
		
		let groupNameContainsH = Getter {
			\Group.name
		}.map { string in
			string.contains("h")
		}
		
		let groupHasStrings = Getter {
			\Group.strings
		}.map { strings in
			strings.count > 0
		}
		
		let optic = And {
			ManyGetter {
				\Group.isBig
			}
			
			Or {
				groupNameIsEmpty
				
				groupNameContainsH
			}
			
			ManyGetter {
				groupHasStrings
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
	
	func testFunc() {
		let optic = Many {
			\Company.employees
			[Person].optic()
			\Person.age
		}.fold(Monoid.max)
		
		XCTAssertEqual(
			optic.tryGet(company),
			65
		)
	}
}
