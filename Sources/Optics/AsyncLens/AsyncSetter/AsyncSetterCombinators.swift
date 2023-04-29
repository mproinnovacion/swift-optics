import Foundation

public struct AyncSetter<O: AsyncSetterOptic>: AsyncSetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let setter: O
	
	@inlinable
	public init(
		@AsyncSetterOpticBuilder with build: () -> O
	) {
		self.setter = build()
	}
	
	public func updating(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) async throws -> O.NewPart
	) async rethrows -> O.NewWhole {
		try await setter.updating(whole, f)
	}
}
