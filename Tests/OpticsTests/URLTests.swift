import Foundation
import Optics
import XCTest

class URLTests: XCTestCase {
	func testURL() {
		let url = URL(string: "https://user:password@www.google.com/path?item=true")!
			
		// MARK: Scheme
		XCTAssertEqual(
			URL.schemeOptic().tryGet(url),
			"https"
		)
		
		XCTAssertEqual(
			URL.schemeOptic().trySet(url, to: "ftp").absoluteString,
			"ftp://user:password@www.google.com/path?item=true"
		)
		
		// MARK: Host
		XCTAssertEqual(
			URL.hostOptic().tryGet(url),
			"www.google.com"
		)
		
		XCTAssertEqual(
			URL.hostOptic().trySet(url, to: "www.tyris-software.com").absoluteString,
			"https://user:password@www.tyris-software.com/path?item=true"
		)
		
		// MARK: User
		XCTAssertEqual(
			URL.userOptic().tryGet(url),
			"user"
		)
		
		XCTAssertEqual(
			URL.userOptic().trySet(url, to: "john").absoluteString,
			"https://john:password@www.google.com/path?item=true"
		)
		
		// MARK: Password
		XCTAssertEqual(
			URL.passwordOptic().tryGet(url),
			"password"
		)
		
		XCTAssertEqual(
			URL.passwordOptic().trySet(url, to: "secret").absoluteString,
			"https://user:secret@www.google.com/path?item=true"
		)
		
		// MARK: Port
		XCTAssertEqual(
			URL.portOptic().tryGet(url),
			nil
		)
		
		XCTAssertEqual(
			URL.portOptic().trySet(url, to: 12).absoluteString,
			"https://user:password@www.google.com:12/path?item=true"
		)
		
		// MARK: Path
		XCTAssertEqual(
			URL.pathOptic().tryGet(url),
			"path"
		)
		
		XCTAssertEqual(
			URL.pathOptic().trySet(url, to: "newpath").absoluteString,
			"https://user:password@www.google.com/newpath?item=true"
		)
		
		// MARK: Query
		XCTAssertEqual(
			URL.queryOptic().tryGet(url),
			"item=true"
		)
		
		XCTAssertEqual(
			URL.queryOptic().trySet(url, to: "item1=false").absoluteString,
			"https://user:password@www.google.com/path?item1=false"
		)
		
		// MARK: Fragment
		XCTAssertEqual(
			URL.fragmentOptic().tryGet(url),
			nil
		)
		
		XCTAssertEqual(
			URL.fragmentOptic().trySet(url, to: "fragment").absoluteString,
			"https://user:password@www.google.com/path?item=true#fragment"
		)
		
		// MARK: Query Items
		XCTAssertEqual(
			URL.queryItemsOptic().tryGet(url),
			[
				URLQueryItem(name: "item", value: "true")
			]
		)
		
		XCTAssertEqual(
			URL.queryItemsOptic().trySet(
				url,
				to: [
					URLQueryItem(name: "item1", value: "1"),
					URLQueryItem(name: "item2", value: "2")
				]
			).absoluteString,
			"https://user:password@www.google.com/path?item1=1&item2=2"
		)
		
		XCTAssertEqual(
			URL.absoluteStringOptic().tryGet(url),
			"https://user:password@www.google.com/path?item=true"
		)
		
		XCTAssertEqual(
			URL.absoluteStringOptic().tryGet(
				URL.absoluteStringOptic().tryUpdate(url, { urlString in
					urlString + "&blah=true"
				})
			),
			"https://user:password@www.google.com/path?item=true&blah=true"
		)
	}
}
