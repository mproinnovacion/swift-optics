import Foundation
import Optics
import XCTest

enum Rep: Int {
	case one = 1
	case two = 2
	case three = 3
}

class RawRepresentableTests: XCTestCase {
	func testRawRepresentable() {
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
}
