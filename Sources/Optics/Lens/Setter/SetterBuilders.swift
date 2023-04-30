import Foundation

@resultBuilder
public enum SetterOpticBuilder {
	public static func buildPartialBlock<O: SetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> SetterProvidedWholeOptic<SetterFunc0<R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> SetterProvidedWholeOptic<SetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: f)
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
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updating(whole) { lhsPart in
			rhs.updating(lhsPart, f)
		}
	}
}
