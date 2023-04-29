import Foundation

@resultBuilder
public enum AsyncGetterOpticBuilder {
	public static func buildPartialBlock<O: GetterOptic>(first optic: O) -> LiftGetterToAsync<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: AsyncGetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: AsyncGetterOptic, O1: GetterOptic>(accumulated o0: O0, next o1: O1) -> AsyncGetterCombination<O0, LiftGetterToAsync<O1>> {
		AsyncGetterCombination(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: AsyncGetterOptic, O1: AsyncGetterOptic>(accumulated o0: O0, next o1: O1) -> AsyncGetterCombination<O0, O1> {
		AsyncGetterCombination(lhs: o0, rhs: o1)
	}
}

public struct AsyncGetterCombination<LHS: AsyncGetterOptic, RHS: AsyncGetterOptic>: AsyncGetterOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func get(_ whole: LHS.Whole) async -> RHS.Part {
		await rhs.get(lhs.get(whole))
	}
}
