import Foundation
import Optics
import XCTest

class ConcatTests: XCTestCase {
	func testConcat() {
		var includeFreelance = false
		
		let people = Concat {
			if includeFreelance {
				Each {
					\Company.freelance
				}
			}
			
			Each {
				\Company.employees
			}
		}
		
		let names = Many {
			people
			\Person.name
		}
		
		XCTAssertEqual(
			names.getAll(company),
			[ "Mike", "Louis", "Jessica" ]
		)
		
		var local = company
		
		names.updateAll(in: &local) { $0 = $0.uppercased() }
		
		includeFreelance = true
		
		let peopleIncludingFreelance = Concat {
			Each {
				\Company.employees
			}
			
			if includeFreelance {
				Each {
					\Company.freelance
				}
			}
		}
		
		XCTAssertEqual(
			Many {
				peopleIncludingFreelance
				\Person.name
			}.getAll(local),
			[ "MIKE", "LOUIS", "JESSICA", "John", "Joe", "Mike" ]
		)
	}
	
	func testConcatLenses() {
		struct Group {
			var admin: String
			var user: String
			var name: String
		}
		
		let optic = Concat {
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
			optic.getAll(group),
			[ "Admin", "User", "Name" ]
		)
	
		XCTAssertEqual(
			optic.getAll(
				optic.updatingAll(in: group, update: { $0.uppercased() })
			),
			[ "ADMIN", "USER", "NAME" ]
		)
		
		XCTAssertEqual(
			optic.getAll(
				optic.settingAll(in: group, to: "value")
			),
			[ "value", "value", "value" ]
		)
	}
}
