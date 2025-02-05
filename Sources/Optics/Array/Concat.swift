import Foundation

/// Concats ArrayOptic optics where the wholes and the parts match.
public struct Concat<Optics: ArrayOptic>: ArrayOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
	public let optic: Optics
	
	@inlinable
	public init(
		@ConcatArrayOpticsBuilder with build: () -> Optics
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic.getAll(whole)
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(in: whole, update: f)
	}
	
	public func settingAll(
		in whole: Optics.Whole,
		to newValue: Optics.NewPart
	) -> Optics.NewWhole {
		optic.settingAll(in: whole, to: newValue)
	}
}

public struct ConcatArrayOptics<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == RHS.NewPart, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = LHS.Part
	public typealias NewPart = LHS.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		lhs.getAll(whole) + rhs.getAll(whole)
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var result = whole
		result = lhs.updatingAll(in: result, update: f)
		return rhs.updatingAll(in: result, update: f)
	}
}

@resultBuilder
public enum ConcatArrayOpticsBuilder {
	public static func buildOptional<O: ArrayOptic>(
		_ optic: O?
	) -> ArrayOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ArrayOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftLensToArray<O> {
		LiftLensToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> LiftPrismToArray<O> {
		LiftPrismToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> LiftOptionalToArray<O> {
		LiftOptionalToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArrayOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, LiftLensToArray<O1>> {
		ConcatArrayOptics(
			lhs: o0,
			rhs: LiftLensToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, LiftPrismToArray<O1>> {
		ConcatArrayOptics(
			lhs: o0,
			rhs: LiftPrismToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, LiftOptionalToArray<O1>> {
		ConcatArrayOptics(
			lhs: o0,
			rhs: LiftOptionalToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayOptics<O0, O1> {
		ConcatArrayOptics(lhs: o0, rhs: o1)
	}
	
	public static func buildExpression<O: LensOptic>(_ expression: O) -> LiftLensToArray<O> {
		.init(optic: expression)
	}
	
	public static func buildExpression<O: PrismOptic>(_ expression: O) -> LiftPrismToArray<O> {
		.init(optic: expression)
	}
	
	public static func buildExpression<O: OptionalOptic>(_ expression: O) -> LiftOptionalToArray<O> {
		.init(optic: expression)
	}
	
	public static func buildExpression<O: ArrayOptic>(_ expression: O) -> O {
		expression
	}
}
