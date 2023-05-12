import Foundation
import XCTest

import Optics

class SetterEventsTests: XCTestCase {
	func testOnUpdate() {
		struct User {
			var name: String
		}
		
		var updated = false
		
		let setter = Setter {
			\User.name
		}.onUpdate {
			updated = true
		}
		
		let user = User(name: "john")
		
		_ = setter.updating(in: user) { $0.uppercased() }
		
		XCTAssert(updated)
	}
}
