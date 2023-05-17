import Foundation
import Optics
import XCTest

class ConcatSetterTests: XCTestCase {
	func testConcat() {
		struct Group: Equatable {
			var admin: String
			var user: String
			var name: String
		}
		
		let optic = ConcatSetters {
			\Group.admin
			\Group.user
			\Group.name
		}
		
		let group = Group(
			admin: "Admin",
			user: "User",
			name: "Name"
		)
		
		XCTAssertEqual(
			optic.updatingAll(in: group, update: { $0.uppercased() }),
			Group(
				admin: "ADMIN",
				user: "USER",
				name: "NAME"
			)
		)
	}
}
