import Foundation

import Algebra

public protocol ArrayGetterOptic<Whole, Part> {
	associatedtype Whole
	associatedtype Part
	
	func getAll(_ whole: Whole) -> [Part]
}

extension ArrayGetterOptic where Whole == Void {
	public func getAll() -> [Part] {
		self.getAll(())
	}
}

extension ArrayGetterOptic {
	public func fold(
		_ monoid: Monoid<Part>
	) -> Fold<Self> {
		Fold(monoid: monoid) {
			self
		}
	}
	
	public func fold() -> Fold<Self> where Part: Monoidal {
		Fold {
			self
		}
	}
	
	public func foldMap<Result>(
		_ monoid: Monoid<Result>,
		_ map: @escaping (Part) -> Result
	) -> FoldMap<Self, Result> {
		FoldMap(monoid: monoid) {
			map($0)
		} with: {
			self
		}
	}
}
