import Foundation
import Optics
import XCTest
import CasePaths

class AnyOfTests: XCTestCase {
	enum State<A: Equatable>: Equatable {
		case ready
		case loadedLocal(A)
		case loadedRemote(A)
	}
	
	func testAnyOf() {
		let optic = AnyOf {
			/State<Int>.loadedLocal
			/State<Int>.loadedRemote
		}
		
		let local = State<Int>.loadedLocal(7)
		let remote = State<Int>.loadedRemote(14)
		
		XCTAssertEqual(
			optic.tryGet(local),
			7
		)
		
		XCTAssertEqual(
			optic.tryGet(remote),
			14
		)
		
		XCTAssertEqual(
			optic.tryGet(
				optic.trySetting(in: local, to: 12)
			),
			12
		)
		
		XCTAssertEqual(
			optic.tryGet(
				optic.trySetting(in: remote, to: 20)
			),
			20
		)
		
		XCTAssertEqual(
			optic.tryGet(
				optic.tryUpdating(in: remote) { $0 + 1 }
			),
			15
		)
	}
	
	func testStatement() {
		let includeRemote = false
		let optic = AnyOf {
			/State<Int>.loadedLocal

			if includeRemote {
				/State<Int>.loadedRemote
			}
		}
		
		let local = State<Int>.loadedLocal(7)
		let remote = State<Int>.loadedRemote(14)
		
		XCTAssertEqual(
			optic.tryGet(local),
			7
		)
		
		XCTAssertEqual(
			optic.tryGet(remote),
			nil
		)
		
		XCTAssertEqual(
			optic.tryGet(
				optic.trySetting(in: local, to: 12)
			),
			12
		)
		
		XCTAssertEqual(
			optic.trySetting(in: remote, to: 20),
			remote
		)
	}
}
