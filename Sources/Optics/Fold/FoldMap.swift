import Foundation

import Algebra

public struct FoldMap<O: ArrayGetterOptic, Result>: GetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = Result
	
	public let optic: O
	public let monoid: Monoid<Part>
	public let map: (O.Part) -> Result
	
	@inlinable
	public init(
		monoid: Monoid<Part>,
		map: @escaping (O.Part) -> Result,
		@FoldBuilder with build: () -> O
	) {
		self.optic = build()
		self.monoid = monoid
		self.map = map
	}
	
	@inlinable
	public init(
		map: @escaping (O.Part) -> Result,
		@FoldBuilder with build: () -> O
	) where Result: Monoidal {
		self.optic = build()
		self.monoid = Result.monoid
		self.map = map
	}
	
	public func get(
		_ whole: Whole
	) -> Part {
		self.optic.getAll(whole).foldMap(map, monoid)
	}
}

extension ArrayGetterOptic {
	public func foldMap<Result>(
		_ monoid: Monoid<Result>,
		map: @escaping (Part) -> Result
	) -> FoldMap<Self, Result> {
		FoldMap(monoid: monoid) { part in
			map(part)
		} with: {
			self
		}
	}
	
	public func foldMap<Result>(
		_ monoid: Monoid<Result>,
		map: @escaping (Part) -> Result
	) -> FoldMap<Self, Result>
	where Result: Monoidal{
		FoldMap { part in
			map(part)
		} with: {
			self
		}
	}
}
