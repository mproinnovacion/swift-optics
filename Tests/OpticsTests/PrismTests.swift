import Foundation
import XCTest

import CasePaths

import Optics

class PrismTests: XCTestCase {
	func testMatches() {
		let success: Result<Int, MyError> = .success(7)
		let failure: Result<Int, MyError> = .failure(.error)
		
		let prism = Prism {
			/Result<Int, MyError>.success
		}
		
		XCTAssertEqual(prism.matches(success), true)
		XCTAssertEqual(prism.matches(failure), false)
	}
	
	func testMatchesOptional() {
		let some: Int? = 7
		let none: Int? = nil
		
		let prism = Prism {
			/Int?.some
		}
		
		XCTAssertEqual(prism.matches(some), true)
		XCTAssertEqual(prism.matches(none), false)
	}
}
