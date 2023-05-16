import Foundation

public struct LiftLensToArray<O: LensOptic>: ArrayOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart

	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		[optic.get(whole)]
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updating(in: whole, update: f)
	}
}

extension LensOptic {
	public func array() -> LiftLensToArray<Self> {
		.init(optic: self)
	}
}

public struct LiftPrismToArray<O: PrismOptic>: ArrayOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	public typealias NewWhole = O.Whole
	public typealias NewPart = O.Part
	
	public let optic: LiftOptionalToArray<LiftPrismToOptional<O>>
	
	public init(optic: O) {
		self.optic = .init(optic: .init(optic: optic))
	}
	
	public func getAll(_ whole: O.Whole) -> [O.Part] {
		self.optic.getAll(whole)
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updatingAll(in: whole, update: f)
	}
}

extension PrismOptic {
	public func array() -> LiftPrismToArray<Self> {
		.init(optic: self)
	}
}

public struct LiftOptionalToArray<O: OptionalOptic>: ArrayOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[optic.tryGet(whole)].compactMap { $0 }
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(in: whole, update: f)
	}
	
	public func settingAll(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		optic.trySetting(in: whole, to: newValue)
	}
}

extension OptionalOptic {
	public func array() -> LiftOptionalToArray<Self> {
		.init(optic: self)
	}
}
