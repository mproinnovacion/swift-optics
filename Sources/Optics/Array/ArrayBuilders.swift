import Foundation

@resultBuilder
public enum ArrayOpticBuilder {
	public static func buildOptional<O: ArrayOptic>(
		_ optic: O?
	) -> ArrayOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ArrayOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftLensToArray<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> LiftPrismToArray<O> {
		.init(optic: optic)
	}

	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> LiftOptionalToArray<O> {
		.init(optic: optic)
	}

	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}

	public static func buildPartialBlock<O0: ArrayOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptics<O0, LiftLensToArray<O1>> {
		CombineArrayOptics(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptics<O0, LiftPrismToArray<O1>> {
		CombineArrayOptics(
			lhs: o0,
			rhs: LiftPrismToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptics<O0, LiftOptionalToArray<O1>> {
		CombineArrayOptics(lhs: o0, rhs: .init(optic: o1))
	}

	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineArrayOptics<O0, O1> {
		CombineArrayOptics(lhs: o0, rhs: o1)
	}
}

public struct CombineArrayOptics<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
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

	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updatingAll(in: whole) { lhsPart in
			rhs.updatingAll(in: lhsPart, update: f)
		}
	}
}

@resultBuilder
public enum EachOpticBuilder {
	public static func buildOptional<O: ArrayOptic>(
		_ optic: O?
	) -> ArrayOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ArrayOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftLensToArray<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: LensOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<LiftLensToArray<O0>, O1> {
		ConcatArrayOptics(lhs: LiftLensToArray(optic: o0), rhs: o1)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, O1> {
		ConcatArrayOptics(lhs: o0, rhs: o1)
	}
}
