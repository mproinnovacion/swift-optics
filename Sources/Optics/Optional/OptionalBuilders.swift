import Foundation

@resultBuilder
public enum OptionalOpticBuilder {
	public static func buildOptional<O: OptionalOptic>(
		_ optic: O?
	) -> OptionalOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		OptionalOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftLensToOptional<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> LiftPrismToOptional<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionals<O0, LiftLensToOptional<O1>> {
		CombineOptionals(lhs: o0, rhs: LiftLensToOptional(optic: o1))
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionals<O0, LiftPrismToOptional<O1>> {
		CombineOptionals(lhs: o0, rhs: LiftPrismToOptional(optic: o1))
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineOptionals<O0, O1> {
		CombineOptionals(lhs: o0, rhs: o1)
	}
}

public struct OptionalOpticFromOptional<Whole, Part, NewPart, O: OptionalOptic>: OptionalOptic
where Whole == O.Whole, Part == O.Part, NewPart == O.NewPart, O.NewWhole == O.Whole {
	let optic: O?
	
	public typealias NewWhole = O.NewWhole
	
	public init(optic: O?) {
		self.optic = optic
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		optic?.tryGet(whole)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic?.tryUpdating(in: whole, update: f) ?? whole
	}
	
	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		optic?.trySetting(in: whole, to: newValue) ?? whole
	}
}

public struct CombineLensOptional<LHS: LensOptic, RHS: OptionalOptic>: OptionalOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public init(lhs: LHS, rhs: RHS) {
		self.lhs = lhs
		self.rhs = rhs
	}
	
	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		rhs.tryGet(lhs.get(whole))
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updating(in: whole) { lhsPart in
			rhs.tryUpdating(in: lhsPart, update: f)
		}
	}
	
	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		lhs.updating(in: whole) { lhsPart in
			rhs.trySetting(in: lhsPart, to: newValue)
		}
	}
}

public struct CombineOptionals<LHS: OptionalOptic, RHS: OptionalOptic>: OptionalOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public init(lhs: LHS, rhs: RHS) {
		self.lhs = lhs
		self.rhs = rhs
	}
	
	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.tryGet(whole).flatMap(rhs.tryGet)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.tryUpdating(in: whole) { lhsPart in
			rhs.tryUpdating(in: lhsPart, update: f)
		}
	}
	
	public func trySetting(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		lhs.tryUpdating(in: whole) { part in
			rhs.trySetting(in: part, to: newValue)
		}
	}
}
