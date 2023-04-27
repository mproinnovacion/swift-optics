import Foundation
import Optics
import XCTest

class DateTests: XCTestCase {
	func testDate() {
		let date = Date(timeIntervalSince1970: 0)
				
		XCTAssertEqual(
			Date.dayOptic().tryGet(date),
			1
		)
		
		XCTAssertEqual(
			Date.dayOptic().tryGet(
				Date.dayOptic().trySetting(date, to: 2)
			),
			2
		)
		
		XCTAssertEqual(
			Date.monthOptic().tryGet(date),
			1
		)
		
		XCTAssertEqual(
			Date.yearOptic().tryGet(date),
			1970
		)
		
		XCTAssertEqual(
			Date.yearOptic().tryGet(
				Date.yearOptic().tryUpdating(date, { $0 + 1 })
			),
			1971
		)
		
		XCTAssertEqual(
			Date.weekdayOptic().tryGet(date),
			.thursday
		)
		
		dump(
			Date.weekdayOptic().trySetting(date, to: .tuesday).timeIntervalSince1970
		)
		
		XCTAssertEqual(
			Date.dayOptic().tryGet(
				Date.weekdayOptic().trySetting(date, to: .tuesday)
			),
			6
		)
	}
}
