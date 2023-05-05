import Foundation

@resultBuilder
public enum ThrowingSetterOpticBuilder {
	public static func buildPartialBlock<O: ThrowingSetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ThrowingSetterOptic, O1: ThrowingSetterOptic>(accumulated o0: O0, next o1: O1) -> ThrowingSetterCombination<O0, O1> {
		ThrowingSetterCombination(lhs: o0, rhs: o1)
	}
}

public struct ThrowingSetterCombination<LHS: ThrowingSetterOptic, RHS: ThrowingSetterOptic>: ThrowingSetterOptic
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
	) throws -> NewWhole {
		try lhs.updating(whole) { lhsPart in
			try rhs.updating(lhsPart, f)
		}
	}
	
	public func setting(
		_ whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole {
		try lhs.updating(whole) { lhsPart in
			try rhs.setting(lhsPart, to: newPart)
		}
	}
}
