import Foundation

public struct Throwing<O: ThrowingOptic>: ThrowingOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	@inlinable
	public init(
		@ThrowingOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func get(_ whole: O.Whole) throws -> O.Part {
		try optic.get(whole)
	}
	
	public func update(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) throws -> O.NewPart
	) throws -> O.NewWhole {
		try optic.update(whole, f)
	}
	
	public func set(
		_ whole: O.Whole,
		to newPart: O.NewPart
	) throws -> O.NewWhole {
		try optic.set(whole, to: newPart)
	}
}
