import Foundation

@resultBuilder
public enum ArraySetterOpticBuilder {
	public static func buildPartialBlock<O: ArraySetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ArraySetterOptic, O1: ArraySetterOptic>(accumulated o0: O0, next o1: O1) -> ArraySetterCombination<O0, O1> {
		ArraySetterCombination(lhs: o0, rhs: o1)
	}
}

public struct ArraySetterCombination<LHS: ArraySetterOptic, RHS: ArraySetterOptic>: ArraySetterOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lhs.updatingAll(whole) { lhsPart in
			try rhs.updatingAll(lhsPart, f)
		}
	}
}
