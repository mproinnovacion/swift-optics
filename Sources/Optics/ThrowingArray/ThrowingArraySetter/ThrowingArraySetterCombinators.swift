import Foundation

public struct ThrowingArraySetter<O: ThrowingArraySetterOptic>: ThrowingArraySetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let setter: O
	
	@inlinable
	public init(
		@ThrowingArraySetterOpticBuilder with build: () -> O
	) {
		self.setter = build()
	}
	
	public func updatingAll(
		in whole: O.Whole,
		update f: @escaping (O.Part) throws -> O.NewPart
	) throws -> O.NewWhole {
		try setter.updatingAll(in: whole, update: f)
	}
}
