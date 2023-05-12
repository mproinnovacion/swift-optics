import Foundation

public struct LiftSetterToArray<O: SetterOptic>: ArraySetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: O.Whole,
		update f: @escaping (O.Part) -> O.NewPart
	) -> O.NewWhole {
		self.optic.updating(in: whole, update: f)
	}
}

public struct LiftOptionalSetterToArray<O: OptionalSetterOptic>: ArraySetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: O.Whole,
		update f: @escaping (O.Part) -> O.NewPart
	) -> O.NewWhole {
		self.optic.tryUpdating(in: whole, update: f)
	}
}
