import Foundation

import Algebra

/// Main ReduceOptic builder.
public struct Reduce<Optic: ReduceOptic>: ReduceOptic {
	public typealias Whole = Optic.Whole
	public typealias Part = Optic.Part
	
	public let optic: Optic
	
	@inlinable
	public init(
		@ReduceOpticBuilder with build: () -> Optic
	) {
		self.optic = build()
	}
	
	public func reduced<Result>(
		_ whole: Whole,
		_ monoid: Monoid<Result>,
		foldMap: (Part) -> Result
	) -> Result {
		self.optic.reduced(whole, monoid, foldMap: foldMap)
	}
}
