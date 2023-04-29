import Foundation

public struct LiftOptionalToAsync<O: OptionalOptic>: AsyncOptionalOptic
where O.NewWhole == O.Whole {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	@inlinable
	public func tryGet(_ whole: Whole) async -> Part? {
		optic.tryGet(whole)
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		guard let part = optic.tryGet(whole) else {
			return whole
		}
		
		let newPart = try await f(part)
		return optic.trySetting(whole, to: newPart)
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) async -> NewWhole {
		optic.trySetting(whole, to: newValue)
	}
}
