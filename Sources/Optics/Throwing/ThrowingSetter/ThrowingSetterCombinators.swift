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
		in whole: O.Whole,
		update f: @escaping (O.Part) throws -> O.NewPart
	) throws -> O.NewWhole {
		try setter.updating(in: whole, update: f)
	}
	
	public func setting(in whole: O.Whole, to newPart: O.NewPart) throws -> O.NewWhole {
		try setter.setting(in: whole, to: newPart)
	}
}
