import Foundation
import XCTest

import Optics

fileprivate struct Item: Codable {
	var name: String
	var created: Date
}

fileprivate struct Group: Codable {
	var name: String
	var date: Date
	var items: [Item]
	var children: [Group]
}

fileprivate struct GroupDatesOptic: ArrayOptic {
	fileprivate typealias Whole = Group
	fileprivate typealias Part = Date
	fileprivate typealias NewWhole = Group
	fileprivate typealias NewPart = Date
	
	var body: some SimpleArrayOptic<Group, Part> {
		Concat {
			Many {
				\Group.date
			}
			
			Many {
				Each {
					\Group.items
				}
				
				\Item.created
			}
			
			Many {
				Each {
					\Group.children
				}
				
				Self()
			}
		}
	}
}

class FileOpticsTests: XCTestCase {
	/// For me it was Tuesday
	func testReadWrite() throws {
		let targetUrl = try FileManager.default
			.url(
				for: .documentDirectory,
				in: .userDomainMask,
				appropriateFor: nil,
				create: false
			)
			.appendingPathComponent("model.json", isDirectory: false)
		
		print(targetUrl)
		
		let assetUrl = Bundle.module.url(forResource: "model", withExtension: "json")!
		
		try? FileManager.default.removeItem(at: targetUrl)
		
		try FileManager.default.copyItem(at: assetUrl, to: targetUrl)
		
		let datesOptic = ManyThrowing {
			URL.fileOptic()
			Group.codableOptic()
			GroupDatesOptic()
		}
		
		let weekdayOptic = Many {
			datesOptic
			Date.weekdayOptic()
		}
		
		XCTAssertEqual(
			datesOptic.getAll(
				weekdayOptic.settingAll(targetUrl, to: .tuesday)
			),
			[
				Date(timeIntervalSinceReferenceDate: 702856800),
				Date(timeIntervalSinceReferenceDate: -977878800),
				Date(timeIntervalSinceReferenceDate: -977878800),
				Date(timeIntervalSinceReferenceDate: -977878800),
				Date(timeIntervalSinceReferenceDate: -977878800),
				Date(timeIntervalSinceReferenceDate: -977878800)
			]
		)
		
		try? FileManager.default.removeItem(at: targetUrl)
	}
}
