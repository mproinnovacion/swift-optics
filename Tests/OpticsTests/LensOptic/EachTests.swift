import Foundation
import XCTest
import Optics

class EachTests: XCTestCase {
	func testEach() {
		let people = Lens {
			\Company.employees
		}

		var uppercased = company
		
		let namesExceptFirst = Each {
			Lens {
				people.dropFirst(1)
				\Person.name
			}
		}
		
		namesExceptFirst.updateAll(in: &uppercased) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			namesExceptFirst.getAll(uppercased),
			[ "LOUIS", "JESSICA" ]
		)
		
		let names = Each {
			Lens {
				people
				\Person.name
			}
		}
		
		XCTAssertEqual(
			names.getAll(uppercased),
			[ "Mike", "LOUIS", "JESSICA" ]
		)
	}
	
	func testEachOptional() {
		struct Group {
			var children: [String]?
		}
		
		let optic = Optionally {
			\Group.children
			[String]?.optic()
		}.each()
		
		var group = Group(
			children: [ "one", "two", "three" ]
		)
		
		XCTAssertEqual(
			optic.getAll(group),
			[ "one", "two", "three" ]
		)
		
		optic.updateAll(in: &group) { $0 = $0.uppercased() }
		
		XCTAssertEqual(
			optic.getAll(group),
			[ "ONE", "TWO", "THREE" ]
		)
	}
}
