import Foundation
import Optics
import XCTest

enum Rep: Int {
	case one = 1
	case two = 2
	case three = 3
}

class RawRepresentableTests: XCTestCase {
	func testOptional() {
		let rep = Rep.one
		
		XCTAssertEqual(
			Rep.rawValueOptic().tryGet(rep),
			1
		)
		
		XCTAssertEqual(
			Rep.rawValueOptic().tryUpdate(rep, { $0 + 1 }),
			.two
		)
	}
	
	func testPrism() {
		let rep = Rep.one
		
		XCTAssertEqual(
			Rep.prismOptic().embed(rep),
			1
		)
		
		XCTAssertEqual(
			Rep.prismOptic().extract(from: 1),
			.one
		)
		
		XCTAssertEqual(
			Rep.prismOptic().extract(from: 9),
			nil
		)
	}
}
