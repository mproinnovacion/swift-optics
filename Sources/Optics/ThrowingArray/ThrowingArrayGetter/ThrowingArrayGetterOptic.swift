import Foundation

import Algebra

public protocol ThrowingArrayGetterOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	
	@inlinable
	func getAll(_ whole: Whole) throws -> [Part]
}

extension ThrowingArrayGetterOptic where Whole == Void {
	func getAll() throws -> [Part] {
		try self.getAll(())
	}
}
