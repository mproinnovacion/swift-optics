import Foundation

@resultBuilder
public enum SetterOpticBuilder {
	public static func buildPartialBlock<O: SetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: SetterOptic, O1: SetterOptic>(accumulated o0: O0, next o1: O1) -> SetterCombination<O0, O1> {
		SetterCombination(lhs: o0, rhs: o1)
	}
}

public struct SetterCombination<LHS: SetterOptic, RHS: SetterOptic>: SetterOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lhs.updating(whole) { lhsPart in
			try rhs.updating(lhsPart, f)
		}
	}
}

public struct SetterFunc1<O0, Part>: SetterOptic {
	public typealias Whole = (O0) throws -> Part
	public typealias NewWhole = Whole
	public typealias NewPart = Part

	public init() {}
	
	public func updating(
		_ whole: @escaping (O0) throws -> Part,
		_ f: @escaping (Part) throws -> Part
	) rethrows -> NewWhole {
		{ o0 in
			try f(whole(o0))
		}
	}
}

