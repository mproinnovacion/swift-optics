import Foundation

/// Concats ArrayOptic optics where the wholes and the parts match.
public struct ConcatSetters<Optics: ArraySetterOptic>: ArraySetterOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
	public let optic: Optics
	
	@inlinable
	public init(
		@ConcatSettersBuilder with build: () -> Optics
	) {
		self.optic = build()
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updatingAll(whole, f)
	}
}

@resultBuilder
public enum ConcatSettersBuilder {
	public static func buildPartialBlock<O: SetterOptic>(first optic: O) -> LiftSetterToArray<O> {
		LiftSetterToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalSetterOptic>(first optic: O) -> LiftOptionalSetterToArray<O> {
		LiftOptionalSetterToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArraySetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ArraySetterOptic, O1: SetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatArraySetters<O0, LiftSetterToArray<O1>> {
		ConcatArraySetters(
			lhs: o0,
			rhs: LiftSetterToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArraySetterOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ConcatArraySetters<O0, LiftOptionalSetterToArray<O1>> {
		ConcatArraySetters(
			lhs: o0,
			rhs: LiftOptionalSetterToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArraySetterOptic, O1: ArraySetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatArraySetters<O0, O1> {
		ConcatArraySetters(lhs: o0, rhs: o1)
	}
	
	public static func buildExpression<O: ArraySetterOptic>(_ expression: O) -> O {
		expression
	}
}

public struct ConcatArraySetters<LHS: ArraySetterOptic, RHS: ArraySetterOptic>: ArraySetterOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == RHS.NewPart, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = LHS.Part
	public typealias NewPart = LHS.NewPart
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var result = whole
		result = lhs.updatingAll(result, f)
		return rhs.updatingAll(result, f)
	}
}

