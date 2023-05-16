import Foundation
import XCTest

import CasePaths

import Optics

class LiftToArrayTests: XCTestCase {
	func testLiftLens() {
		var local = company

		let ceoAges = Lens {
			\Company.ceo
			\Person.age
		}.array()

		XCTAssertEqual(
			ceoAges.getAll(local),
			[50]
		)

		ceoAges.updateAll(in: &local) { $0 += 1 }

		XCTAssertEqual(
			ceoAges.getAll(local),
			[51]
		)

		XCTAssertEqual(
			ceoAges.getAll(
				ceoAges.updatingAll(in: local) { $0 += 1 }
			),
			[52]
		)

		XCTAssertEqual(
			ceoAges.getAll(
				ceoAges.settingAll(in: local, to: 22)
			),
			[22]
		)
	}

	func testLiftOptional() {
		let advisors = Optionally {
			\Company.advisor
			Prism {
				/Failable<Person>?.some
				/Failable<Person>.valid
			}
		}.array()
		
		let advisorNames = Many {
			advisors
			\Person.name
		}
				
		var local = company
		
		XCTAssertEqual(advisorNames.getAll(local), [])

		advisorNames.setAll(in: &local, to: "Joe")
		
		XCTAssertEqual(advisorNames.getAll(local), [])
		
		advisors.setAll(in: &local, to: joe)

		XCTAssertEqual(
			advisors.getAll(local),
			[joe]
		)
		
		advisorNames.setAll(in: &local, to: "John")
		
		XCTAssertEqual(
			advisorNames.getAll(local),
			["John"]
		)
	}
}
