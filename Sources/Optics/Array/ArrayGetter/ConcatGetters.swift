import Foundation

public struct ConcatGetters<Optics: ArrayGetterOptic>: ArrayGetterOptic {
	public typealias Whole = Optics.Whole
	public typealias Part = Optics.Part
	
	public let optic: Optics
	
	@inlinable
	public init(
		@ConcatGettersBuilder with build: () -> Optics
	) {
		self.optic = build()
	}
	
	public func getAll(_ whole: Optics.Whole) -> [Part] {
		self.optic.getAll(whole)
	}
}

@resultBuilder
public enum ConcatGettersBuilder {
	public static func buildPartialBlock<O: GetterOptic>(first optic: O) -> LiftGetterToArray<O> {
		LiftGetterToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> LiftPrismToArray<O> {
		LiftPrismToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalGetterOptic>(first optic: O) -> LiftOptionalGetterToArray<O> {
		LiftOptionalGetterToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArrayGetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic, O1: GetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayGetters<O0, LiftGetterToArray<O1>> {
		ConcatArrayGetters(
			lhs: o0,
			rhs: LiftGetterToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayGetters<O0, LiftPrismToArray<O1>> {
		ConcatArrayGetters(
			lhs: o0,
			rhs: LiftPrismToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayGetters<O0, LiftOptionalGetterToArray<O1>> {
		ConcatArrayGetters(
			lhs: o0,
			rhs: LiftOptionalGetterToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic, O1: ArrayGetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayGetters<O0, O1> {
		ConcatArrayGetters(lhs: o0, rhs: o1)
	}
}

public struct ConcatArrayGetters<LHS: ArrayGetterOptic, RHS: ArrayGetterOptic>: ArrayGetterOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = LHS.Part
	
	public func getAll(_ whole: LHS.Whole) -> [LHS.Part] {
		lhs.getAll(whole) + rhs.getAll(whole)
	}
}

