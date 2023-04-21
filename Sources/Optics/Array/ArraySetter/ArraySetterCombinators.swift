import Foundation

public struct ArraySetter<O: ArraySetterOptic>: ArraySetterOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let setter: O
	
	@inlinable
	public init(
		@ArraySetterOpticBuilder with build: () -> O
	) {
		self.setter = build()
	}
	
	public func updatingAll(
		_ whole: O.Whole,
		_ f: @escaping (O.Part) throws -> O.NewPart
	) rethrows -> O.NewWhole {
		try setter.updatingAll(whole, f)
	}
}
