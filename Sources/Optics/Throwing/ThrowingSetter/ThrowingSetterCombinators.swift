import Foundation

public struct ThrowingSetter<O: ThrowingSetterOptic>: ThrowingSetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let setter: O
	
	@inlinable
	public init(
		@ThrowingSetterOpticBuilder with build: () -> O
	) {
		self.setter = build()
	}
	
	public func updating(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) throws -> O.NewPart
	) throws -> O.NewWhole {
		try setter.updating(whole, f)
	}
	
	public func setting(_ whole: O.Whole, to newPart: O.NewPart) throws -> O.NewWhole {
		try setter.setting(whole, to: newPart)
	}
}
