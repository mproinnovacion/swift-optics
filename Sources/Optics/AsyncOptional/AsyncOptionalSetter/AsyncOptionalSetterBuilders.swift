import Foundation

@resultBuilder
public enum AsyncOptionalSetterOpticBuilder {
	public static func buildPartialBlock<O: AsyncOptionalSetterOptic>(
		first optic: O
	) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: OptionalSetterOptic, O1: AsyncOptionalSetterOptic>(
		accumulated o0: O0,
		next o1: O1
	) -> AsyncOptionalSetterCombination<O0, O1> {
		AsyncOptionalSetterCombination(lhs: o0, rhs: o1)
	}
}

public struct AsyncOptionalSetterCombination<LHS: AsyncOptionalSetterOptic, RHS: AsyncOptionalSetterOptic>: AsyncOptionalSetterOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await lhs.tryUpdating(whole) { lhsPart in
			try await rhs.tryUpdating(lhsPart, f)
		}
	}
}
