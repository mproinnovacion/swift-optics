import Foundation

@resultBuilder
public enum OptionalSetterOpticBuilder {
	public static func buildPartialBlock<O: OptionalSetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: OptionalSetterOptic, O1: OptionalSetterOptic>(accumulated o0: O0, next o1: O1) -> OptionalSetterCombination<O0, O1> {
		OptionalSetterCombination(lhs: o0, rhs: o1)
	}
}

public struct OptionalSetterCombination<LHS: OptionalSetterOptic, RHS: OptionalSetterOptic>: OptionalSetterOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.tryUpdating(whole) { lhsPart in
			rhs.tryUpdating(lhsPart, f)
		}
	}
}
