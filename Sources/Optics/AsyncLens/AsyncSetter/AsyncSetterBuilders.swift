import Foundation

@resultBuilder
public enum AsyncSetterOpticBuilder {
	public static func buildPartialBlock<O: AsyncSetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: AsyncSetterOptic, O1: AsyncSetterOptic>(accumulated o0: O0, next o1: O1) -> AsyncSetterCombination<O0, O1> {
		AsyncSetterCombination(lhs: o0, rhs: o1)
	}
}

public struct AsyncSetterCombination<LHS: AsyncSetterOptic, RHS: AsyncSetterOptic>: AsyncSetterOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await lhs.updating(whole) { lhsPart in
			try await rhs.updating(lhsPart, f)
		}
	}
}
