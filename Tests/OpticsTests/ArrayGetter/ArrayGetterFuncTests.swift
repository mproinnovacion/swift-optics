import XCTest

import Optics

class ArrayGetterFuncTests: XCTestCase {
	func testFunc() {
		struct User {
			var name: String
		}
		
		let getter = ManyGetter {
			\User.name
			{ (string: String) -> Int in
				string.count
			}
		}
		
		let user = User(name: "john")
		
		XCTAssertEqual(
			getter.getAll(user),
			[4]
		)
	}
	
	func testFunc2() {
		struct User {
			var name: String
			var surname: String
		}
		
		let getter = ManyGetter {
			ConcatGetters {
				\User.name
				\User.surname
			}
			{ (string: String) -> Int in
				string.count
			}
		}
		
		let user = User(name: "john", surname: "Smith")
		
		XCTAssertEqual(
			getter.getAll(user),
			[4, 5]
		)
	}
}
