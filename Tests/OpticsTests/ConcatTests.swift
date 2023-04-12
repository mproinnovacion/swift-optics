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
		
		names.updateAll(&local, { $0 = $0.uppercased() })
		
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
}
