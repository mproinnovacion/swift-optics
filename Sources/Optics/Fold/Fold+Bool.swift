import Foundation

import Algebra

public struct And<O: ArrayGetterOptic>: GetterOptic where O.Part == Bool {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@FoldBuilder with build: () -> O
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
		@FoldBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func get(
		_ whole: Whole
	) -> Part {
		self.optic.getAll(whole).reduced(.any)
	}
}
