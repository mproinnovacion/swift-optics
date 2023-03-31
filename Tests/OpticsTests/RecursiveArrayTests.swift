import Foundation
import XCTest

import CasePaths

import Optics

enum Item {
	case group(Group)
	case leaf(String)
}

struct Group {
	var items: [Item]
}

struct GroupLeafsOptic: ArrayOptic {
	typealias Whole = Group
	typealias Part = String
	typealias NewWhole = Group
	typealias NewPart = String
	
	var body: some SimpleArrayOptic<Group, String> {
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
					Self()
				}
			}
		}
	}
}

class RecursiveArrayTests: XCTestCase {
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
			GroupLeafsOptic().getAll(group),
			[ "leaf0", "leaf1", "leaf2", "leaf3" ]
		)
		
		XCTAssertEqual(
			GroupLeafsOptic().getAll(
				GroupLeafsOptic().updateAll(group, { $0 + "!" })
			),
			[ "leaf0!", "leaf1!", "leaf2!", "leaf3!" ]
		)
	}
}
