import Foundation

public struct OptionalSetter<O: OptionalSetterOptic>: OptionalSetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let setter: O
	
	@inlinable
	public init(
		@OptionalSetterOpticBuilder with build: () -> O
	) {
		self.setter = build()
	}
	
	public func tryUpdating(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) -> O.NewPart
	) -> O.NewWhole {
		setter.tryUpdating(whole, f)
	}
	
	public func trySetting(_ whole: O.Whole, to newPart: O.NewPart) -> O.NewWhole {
		setter.trySetting(whole, to: newPart)
	}
}
