import Foundation
import XCTest

import Optics

fileprivate struct Group {
	var name: String
	var isUser: (String) -> Bool
}

class FuncTests: XCTestCase {
	func testFunc() {
		let optic =
			Lens {
				\Group.isUser
			}.map()		
		
		var group = Group(name: "group") { name in
			name == "john"
		}
		optic.update(&group) { bool in
			bool.toggle()
		}
		
		XCTAssertEqual(group.isUser("john"), false)
		XCTAssertEqual(group.isUser("joe"), true)
	}
}
