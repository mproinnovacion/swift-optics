import Foundation

@resultBuilder
public enum LensOpticBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: LensOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> LensCombination<O0, O1> {
		LensCombination(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: LensOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> LensEachCombinator<O0, O1> {
		LensEachCombinator(lhs: o0, rhs: o1)
	}
	
	public static func buildExpression<O: LensOptic>(_ expression: O) -> O {
		expression
	}
}

extension LensOptic {
	public func combine<O: LensOptic>(with optic: O) -> LensCombination<Self, O>
	where O.Whole == Part
	{
		.init(lhs: self, rhs: optic)
	}
}

public struct LensCombination<LHS: LensOptic, RHS: LensOptic>: LensOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func get(_ whole: LHS.Whole) -> RHS.Part {
		rhs.get(lhs.get(whole))
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lhs.updating(whole) { lhsPart in
			try rhs.updating(lhsPart, f)
		}
	}
}

public struct LensEachCombinator<LHS: LensOptic, RHS: LensOptic>: LensOptic
where LHS.Part == [RHS.Whole], LHS.NewPart == [RHS.NewWhole] {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = [RHS.Part]
	public typealias NewPart = [RHS.NewPart]
	
	public func get(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.get(whole).map(rhs.get)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lhs.updating(whole) { rhsWholes in
			let rhsParts: [RHS.NewPart] = try f(rhsWholes.map(rhs.get))
			
			return zip(rhsWholes, rhsParts).map { whole, newPart in
				rhs.updating(whole, { _ in newPart })
			}
		}
	}
}
