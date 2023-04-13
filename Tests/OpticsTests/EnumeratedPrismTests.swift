import Foundation
import XCTest

import CasePaths

import Optics

fileprivate enum DataLoad: Equatable {
	case ready
	case loading
	case loaded([String])
}

class EnumeratedPrismTests: XCTestCase {
	func testEnumerated() {
		let optic = EnumeratedPrism {
			/DataLoad.loaded
		}
		
		let ready = DataLoad.ready
		let loaded = DataLoad.loaded(["hello", "world"])
		
		XCTAssert(
			optic.extract(from: ready) == nil
		)
		
		let extracted = optic.extract(from: loaded)
		XCTAssert(
			extracted![0] == (0, "hello")
		)
		XCTAssert(
			extracted![1] == (1, "world")
		)
		
		let embedded = optic.embed([ (2, "hello"), (3, "world")])
		
		XCTAssertEqual(
			embedded,
			loaded
		)
	}
}
