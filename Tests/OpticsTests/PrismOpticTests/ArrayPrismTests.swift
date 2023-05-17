import Foundation
import XCTest

import Optics
import CasePaths

class ArrayPrismTests: XCTestCase {
	func testSingle() {
		enum MyError: Error {
			case error
		}
		
		struct User: Equatable {
			var name: String
		}
		
		let firstUser = User(name: "first")
		let users: [Result<User, MyError>] = [
			.success(firstUser),
			.success(User(name: "second")),
			.failure(.error)
		]
		
		let optic = Prism {
			[Result<User, MyError>].singleOptic()
			/Result<User, MyError>.success
		}
		
		XCTAssertEqual(
			optic.extract(from: users),
			firstUser
		)
		
		XCTAssertEqual(
			optic.embed(firstUser),
			[.success(firstUser)]
		)
	}
	
	func testFirst() {
		enum MyError: Error {
			case error
		}
		
		struct User: Equatable {
			var name: String
		}
		
		let firstUser = User(name: "first")
		let users: [Result<User, MyError>] = [
			.success(firstUser),
			.success(User(name: "second")),
			.failure(.error)
		]
		
		let optic = Optionally {
			[Result<User, MyError>].firstElementOptic()
			\(Result<User, MyError>, [Result<User, MyError>]).0
			/Result<User, MyError>.success
		}
		
		XCTAssertEqual(
			optic.tryGet(users),
			firstUser
		)
		
		XCTAssertEqual(
			optic.trySetting(in: users, to: firstUser),
			[
				.success(firstUser),
				.success(User(name: "second")),
				.failure(.error)
			]
		)
	}
	
	func testLast() {
		enum MyError: Error {
			case error
		}
		
		struct User: Equatable {
			var name: String
		}
		
		let firstUser = User(name: "first")
		let lastUser = User(name: "last")
		let users: [User] = [
			firstUser,
			lastUser
		]
		
		let optic = [User].lastElementOptic()
		
		XCTAssertEqual(
			optic.extract(from: users)?.0,
			[firstUser]
		)
		
		XCTAssertEqual(
			optic.extract(from: users)?.1,
			lastUser
		)
		
		let newUser = User(name: "new")
		
		XCTAssertEqual(
			optic.embed(([], newUser)),
			[ newUser ]
		)
	}
}
