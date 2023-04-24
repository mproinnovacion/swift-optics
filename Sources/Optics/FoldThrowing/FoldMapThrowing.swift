import Foundation

import Algebra

public struct FoldMapThrowing<O: ThrowingArrayGetterOptic, Result>: ThrowingGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = Result
	
	public let optic: O
	public let monoid: Monoid<Part>
	public let map: (O.Part) -> Result
	
	@inlinable
	public init(
		monoid: Monoid<Part>,
		map: @escaping (O.Part) -> Result,
		@FoldThrowingBuilder<Whole, O.Part> with build: () -> O
	) {
		self.optic = build()
		self.monoid = monoid
		self.map = map
	}
	
	@inlinable
	public init(
		map: @escaping (O.Part) -> Result,
		@FoldThrowingBuilder<Whole, O.Part> with build: () -> O
	) where Result: Monoidal {
		self.optic = build()
		self.monoid = Result.monoid
		self.map = map
	}
	
	public func get(
		_ whole: Whole
	) throws -> Part {
		try self.optic.getAll(whole).foldMap(map, monoid)
	}
}
