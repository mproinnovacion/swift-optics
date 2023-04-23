import Foundation

import Algebra

public struct Fold<O: ArrayGetterOptic>: GetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	public let monoid: Monoid<Part>
	
	@inlinable
	public init(
		monoid: Monoid<Part>,
		@FoldBuilder<Whole, Part> with build: () -> O
	) {
		self.optic = build()
		self.monoid = monoid
	}
	
	@inlinable
	public init(
		@FoldBuilder<Whole, Part> with build: () -> O
	) where Part: Monoidal {
		self.optic = build()
		self.monoid = Part.monoid
	}
	
	public func get(
		_ whole: Whole
	) -> Part {
		self.optic.getAll(whole).reduced(monoid)
	}
}

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
		@FoldBuilder<Whole, O.Part> with build: () -> O
	) {
		self.optic = build()
		self.monoid = monoid
		self.map = map
	}
	
	@inlinable
	public init(
		map: @escaping (O.Part) -> Result,
		@FoldBuilder<Whole, O.Part> with build: () -> O
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

public struct And<O: ArrayGetterOptic>: GetterOptic where O.Part == Bool {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@FoldBuilder<Whole, Part> with build: () -> O
	) {
		self.optic = build()
	}
	
	public func get(
		_ whole: Whole
	) -> Part {
		self.optic.getAll(whole).reduced(Monoid.all)
	}
}

public struct Or<O: ArrayGetterOptic>: GetterOptic where O.Part == Bool {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@FoldBuilder<Whole, Part> with build: () -> O
	) {
		self.optic = build()
	}
	
	public func get(
		_ whole: Whole
	) -> Part {
		self.optic.getAll(whole).reduced(.any)
	}
}
