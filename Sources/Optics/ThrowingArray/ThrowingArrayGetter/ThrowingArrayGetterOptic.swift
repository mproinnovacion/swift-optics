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

extension ThrowingArrayGetterOptic {
	public func fold(
		_ monoid: Monoid<Part>
	) -> FoldThrowing<Self> {
		FoldThrowing(monoid: monoid) {
			self
		}
	}
	
	public func fold() -> FoldThrowing<Self> where Part: Monoidal {
		FoldThrowing {
			self
		}
	}
	
	public func foldMap<Result>(
		_ monoid: Monoid<Result>,
		_ map: @escaping (Part) -> Result
	) -> FoldMapThrowing<Self, Result> {
		FoldMapThrowing(monoid: monoid) {
			map($0)
		} with: {
			self
		}
	}
}
