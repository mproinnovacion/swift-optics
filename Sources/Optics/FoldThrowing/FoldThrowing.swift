import Foundation

import Algebra

public struct FoldThrowing<O: ThrowingArrayGetterOptic>: ThrowingGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	public let monoid: Monoid<Part>
	
	@inlinable
	public init(
		monoid: Monoid<Part>,
		@FoldThrowingBuilder<Whole, Part> with build: () -> O
	) {
		self.optic = build()
		self.monoid = monoid
	}
	
	@inlinable
	public init(
		@FoldThrowingBuilder<Whole, Part> with build: () -> O
	) where Part: Monoidal {
		self.optic = build()
		self.monoid = Part.monoid
	}
	
	public func get(
		_ whole: Whole
	) throws -> Part {
		try self.optic.getAll(whole).reduced(monoid)
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
}
