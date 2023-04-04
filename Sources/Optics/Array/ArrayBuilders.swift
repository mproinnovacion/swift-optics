import Foundation

@resultBuilder
public enum ArrayOpticBuilder {
	public static func buildOptional<O: ArrayOptic>(
		_ optic: O?
	) -> ArrayOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ArrayOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> ArrayLensLiftOptic<O> {
		.init(lens: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> ArrayOptionalLiftOptic<OptionalLiftPrismOptic<O>> {
		.init(optic: .init(prism: optic))
	}

	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayOptionalLiftOptic<O> {
		.init(optic: optic)
	}

	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}

	public static func buildPartialBlock<O0: ArrayOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptic<O0, O1> {
		CombineArrayOptic(lhs: o0, rhs: o1)
	}

	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayArray<O0, O1> {
		CombineArrayArray(lhs: o0, rhs: o1)
	}

	public static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptional<O0, O1> {
		CombineArrayOptional(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptional<O0, OptionalLiftPrismOptic<O1>> {
		CombineArrayOptional(
			lhs: o0,
			rhs: OptionalLiftPrismOptic(prism: o1)
		)
	}
}

public struct CombineArrayOptic<LHS: ArrayOptic, RHS: LensOptic>: ArrayOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart

	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole).map(rhs.get)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updateAll(whole) { lhsPart in
			rhs.update(lhsPart, f)
		}
	}
}

public struct ConcatArrayOptics<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == RHS.NewPart, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS

	public init(
		lhs: LHS,
		rhs: RHS
	) {
		self.lhs = lhs
		self.rhs = rhs
	}

	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	public typealias NewWhole = RHS.NewWhole

	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole) + rhs.getAll(whole)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		let updated = lhs.updateAll(whole, f)
		return rhs.updateAll(updated, f)
	}
}

public struct CombineArrayOptional<LHS: ArrayOptic, RHS: OptionalOptic>: ArrayOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart

	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole).compactMap(rhs.tryGet)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updateAll(whole) { lhsPart in
			rhs.tryUpdate(lhsPart, f)
		}
	}
}

public struct CombineArrayArray<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart

	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole).flatMap(rhs.getAll)
	}

	public func updateAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updateAll(whole) { lhsPart in
			rhs.updateAll(lhsPart, f)
		}
	}
}

@resultBuilder
public enum EachOpticBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> ArrayLensLiftOptic<O> {
		.init(lens: optic)
	}
	
	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: LensOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<ArrayLensLiftOptic<O0>, O1> {
		ConcatArrayOptics(lhs: ArrayLensLiftOptic(lens: o0), rhs: o1)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, O1> {
		ConcatArrayOptics(lhs: o0, rhs: o1)
	}
}
