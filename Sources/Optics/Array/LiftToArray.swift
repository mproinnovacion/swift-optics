import Foundation

public struct LiftLensToArray<O: LensOptic>: ArrayOptic {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[lens.get(whole)]
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(whole, f)
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
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updatingAll(whole, f)
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
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.tryUpdating(whole, f)
	}
}
