import Foundation

/// Concats OptionalSetterOptic optics where the wholes and the parts match.
public struct ConcatOptionalSetters<Optics: OptionalSetterOptic>: OptionalSetterOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
	public let optic: Optics
	
	@inlinable
	public init(
		@ConcatOptionalSettersBuilder with build: () -> Optics
	) {
		self.optic = build()
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.tryUpdating(whole, f)
	}
}

@resultBuilder
public enum ConcatOptionalSettersBuilder {
	public static func buildPartialBlock<O: SetterOptic>(first optic: O) -> LiftSetterToOptional<O> {
		LiftSetterToOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalSetterOptic>(first optic: O) -> LiftOptionalSetterToArray<O> {
		LiftOptionalSetterToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalSetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: OptionalSetterOptic, O1: SetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatOptionalSetterOptics<O0, LiftSetterToOptional<O1>> {
		ConcatOptionalSetterOptics(
			lhs: o0,
			rhs: LiftSetterToOptional(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: OptionalSetterOptic, O1: OptionalSetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatOptionalSetterOptics<O0, O1> {
		ConcatOptionalSetterOptics(lhs: o0, rhs: o1)
	}
	
	public static func buildExpression<O: OptionalSetterOptic>(_ expression: O) -> O {
		expression
	}
}

public struct ConcatOptionalSetterOptics<LHS: OptionalSetterOptic, RHS: OptionalSetterOptic>: OptionalSetterOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == RHS.NewPart, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = LHS.Part
	public typealias NewPart = LHS.NewPart
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var result = whole
		result = lhs.tryUpdating(result, f)
		return rhs.tryUpdating(result, f)
	}
}


