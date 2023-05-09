import Foundation

public struct LiftSetterToOptional<O: SetterOptic>: OptionalSetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func tryUpdating(
		in whole: O.Whole,
		update f: @escaping (O.Part) -> O.NewPart
	) -> O.NewWhole {
		self.optic.updating(in: whole, update: f)
	}
	
	public func trySetting(in whole: O.Whole, to newPart: O.NewPart) -> O.NewWhole {
		self.optic.setting(in: whole, to: newPart)
	}
}

public typealias LiftPrismToOptionalSetter = LiftPrismToOptional
