import Foundation

@resultBuilder
public enum ThrowingArraySetterOpticBuilder {
	public static func buildPartialBlock<O: ThrowingArraySetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ThrowingArraySetterOptic, O1: ThrowingArraySetterOptic>(accumulated o0: O0, next o1: O1) -> ThrowingArraySetterCombination<O0, O1> {
		ThrowingArraySetterCombination(lhs: o0, rhs: o1)
	}
}

public struct ThrowingArraySetterCombination<LHS: ThrowingArraySetterOptic, RHS: ThrowingArraySetterOptic>: ThrowingArraySetterOptic
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
	) throws -> NewWhole {
		try lhs.updatingAll(whole) { lhsPart in
			try rhs.updatingAll(lhsPart, f)
		}
	}
}
