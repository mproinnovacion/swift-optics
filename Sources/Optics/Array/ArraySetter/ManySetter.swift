import Foundation

public struct ManySetter<O: ArraySetterOptic>: ArraySetterOptic {
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
		in whole: O.Whole,
		update f: @escaping (O.Part) -> O.NewPart
	) -> O.NewWhole {
		setter.updatingAll(in: whole, update: f)
	}
}
