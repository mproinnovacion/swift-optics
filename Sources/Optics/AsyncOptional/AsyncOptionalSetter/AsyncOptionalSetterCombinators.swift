import Foundation

public struct AsyncOptionalSetter<O: AsyncOptionalSetterOptic>: AsyncOptionalSetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let setter: O
	
	@inlinable
	public init(
		@AsyncOptionalSetterOpticBuilder with build: () -> O
	) {
		self.setter = build()
	}
	
	public func tryUpdating(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) async throws -> O.NewPart
	) async rethrows -> O.NewWhole {
		try await setter.tryUpdating(whole, f)
	}
	
	public func trySetting(_ whole: O.Whole, to newPart: O.NewPart) async -> O.NewWhole {
		await setter.trySetting(whole, to: newPart)
	}
}
