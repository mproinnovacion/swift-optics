import Foundation
import XCTest

import Optics

class OptionalSetterEventsTests: XCTestCase {
	func testOnUpdate() {
		struct Address {
			var number: Int?
		}
		
		struct User {
			var address: Address?
		}
		
		var userUpdated = false
		var addressUpdated = false
		
		let setter = OptionalSetter {
			\User.address
			Address?.optic()
			
			OptionalSetter {
				\Address.number
				Int?.optic()
			}.onUpdate {
				addressUpdated = true
			}
		}.onUpdate {
			userUpdated = true
		}
		
		let userNoAddress = User()
		let userWithAddress = User(address: .init(number: 7))
		
		_ = setter.tryUpdating(in: userNoAddress) { $0 + 1 }
		
		XCTAssertEqual(userUpdated, true)
		XCTAssertEqual(addressUpdated, false)
		
		_ = setter.tryUpdating(in: userWithAddress) { $0 + 1 }
		
		XCTAssertEqual(userUpdated, true)
		XCTAssertEqual(addressUpdated, true)
	}
}
