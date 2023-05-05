import Foundation

import Foundation

/// Concats SetterOptic optics where the wholes and the parts match.
public struct ConcatSetters<Optics: SetterOptic>: SetterOptic {
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
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole, f)
	}
}

@resultBuilder
public enum ConcatSettersBuilder {
	public static func buildPartialBlock<O: SetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: SetterOptic, O1: SetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatSetterOptics<O0, O1> {
		ConcatSetterOptics(
			lhs: o0,
			rhs: o1
		)
	}
	
	public static func buildExpression<O: SetterOptic>(_ expression: O) -> O {
		expression
	}
}

public struct ConcatSetterOptics<LHS: SetterOptic, RHS: SetterOptic>: SetterOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == RHS.NewPart, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = LHS.Part
	public typealias NewPart = LHS.NewPart
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var result = whole
		result = lhs.updating(result, f)
		return rhs.updating(result, f)
	}
}



