import Foundation

public struct ManyThrowing<O: ThrowingArrayOptic>: ThrowingArrayOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	@inlinable
	public init(
		@ThrowingArrayOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: O.Whole) throws -> [O.Part] {
		try optic.getAll(whole)
	}
	
	public func updatingAll(
		in whole: O.Whole,
		update f: @escaping (O.Part) throws -> O.NewPart
	) throws -> O.NewWhole {
		try optic.updatingAll(in: whole, update: f)
	}
}
