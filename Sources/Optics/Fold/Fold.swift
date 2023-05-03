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
		@FoldBuilder with build: () -> O
	) {
		self.optic = build()
		self.monoid = monoid
	}
	
	@inlinable
	public init(
		@FoldBuilder with build: () -> O
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
