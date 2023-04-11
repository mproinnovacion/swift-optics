import Foundation
import Optics
import XCTest

class StringOpticTests: XCTestCase {
	func testSplitBy() {
		let value = "hello world!"
		
		let optic = Lens {
			\String.self
		}.splitBy(separator: " ")
		
		
		XCTAssertEqual(
			optic.get(value),
			["hello", "world!"]
		)
			
		XCTAssertEqual(
			optic.update(value) {
				$0 + [ "I", "am", "Groot!" ]
			},
			"hello world! I am Groot!"
		)
	}
	
	func testJoinedBy() {
		let value = ["hello", "world!"]
		
		let optic = Lens {
			\[String].self
		}.joinedBy(separator: " ")
		
		
		XCTAssertEqual(
			optic.get(value),
			"hello world!"
		)
			
		XCTAssertEqual(
			optic.update(value) {
				$0 + " I am Groot!"
			},
			[ "hello", "world!", "I", "am", "Groot!" ]
		)
	}
}
