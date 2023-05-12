import Foundation
import XCTest

import CasePaths

import Optics

fileprivate enum Item {
	case group(Group)
	case leaf(String)
}

fileprivate struct Group {
	var items: [Item]
}

fileprivate struct GroupLeafsOptic: ArrayOptic {
	fileprivate typealias Whole = Group
	fileprivate typealias Part = String
	fileprivate typealias NewWhole = Group
	fileprivate typealias NewPart = String
	
	var maxRecursion: Int
	
	init(maxRecursion: Int) {
		self.maxRecursion = maxRecursion
	}

	var body: some SimpleArrayOptic<Group, String> {
		if self.maxRecursion > 0 {
			Many {
				Lens {
					\Group.items
				}.each()
				
				Concat {
					Many {
						/Item.leaf
					}
					
					Many {
						/Item.group
						Self(maxRecursion: maxRecursion - 1)
					}
				}
			}
		}
	}
}

class MaxRecursionTests: XCTestCase {
	func testRecursive() {
		let group = Group(items: [
			.group(.init(items: [
				.leaf("leaf0"),
				.group(.init(items: [
					.leaf("leaf1"),
					.group(.init(items: [
						.leaf("leaf2")
					]))
				]))
			])),
			.leaf("leaf3")
		])

		XCTAssertEqual(
			GroupLeafsOptic(maxRecursion: 0).getAll(group),
			[]
		)
		
		XCTAssertEqual(
			GroupLeafsOptic(maxRecursion: 1).getAll(group),
			[ "leaf3" ]
		)
		
		XCTAssertEqual(
			GroupLeafsOptic(maxRecursion: 4).getAll(group),
			[ "leaf0", "leaf1", "leaf2", "leaf3" ]
		)

		XCTAssertEqual(
			GroupLeafsOptic(maxRecursion: 4).getAll(
				GroupLeafsOptic(maxRecursion: 1)
					.updatingAll(in: group) { $0 + "!" }
			),
			[ "leaf0", "leaf1", "leaf2", "leaf3!" ]
		)
	}
}
