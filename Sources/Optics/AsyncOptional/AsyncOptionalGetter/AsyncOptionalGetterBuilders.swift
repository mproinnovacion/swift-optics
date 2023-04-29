import Foundation

@resultBuilder
public enum AsyncOptionalGetterOpticBuilder {
	public static func buildPartialBlock<O: AsyncOptionalGetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O: GetterOptic>(
		first optic: O
	) -> LiftOptionalGetterToAsync<LiftGetterToOptional<O>> {
		.init(optic: .init(optic: optic))
	}
	
	public static func buildPartialBlock<R>(
		first f: @escaping () async -> R?
	) -> AsyncOptionalGetterFunc0<R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> AsyncOptionalGetterFunc1<O0, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async -> R
	) -> AsyncOptionalGetterFunc2<O0, O1, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async -> R
	) -> AsyncOptionalGetterFunc3<O0, O1, O2, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async -> R
	) -> AsyncOptionalGetterFunc4<O0, O1, O2, O3, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async -> R
	) -> AsyncOptionalGetterFunc5<O0, O1, O2, O3, O4, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async -> R
	) -> AsyncOptionalGetterFunc6<O0, O1, O2, O3, O4, O5, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0: AsyncOptionalGetterOptic, O1: GetterOptic>(accumulated o0: O0, next o1: O1) async -> AsyncOptionalGetterCombination<O0, LiftOptionalGetterToAsync<LiftGetterToOptional<O1>>> {
		AsyncOptionalGetterCombination(lhs: o0, rhs: .init(optic: .init(optic: o1)))
	}
	
	public static func buildPartialBlock<O0: AsyncOptionalGetterOptic, O1: AsyncOptionalGetterOptic>(accumulated o0: O0, next o1: O1) async -> AsyncOptionalGetterCombination<O0, O1> {
		AsyncOptionalGetterCombination(lhs: o0, rhs: o1)
	}
}

public struct AsyncOptionalGetterCombination<LHS: AsyncOptionalGetterOptic, RHS: AsyncOptionalGetterOptic>: AsyncOptionalGetterOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func tryGet(_ whole: LHS.Whole) async -> RHS.Part? {
		guard let rhsWhole = await lhs.tryGet(whole) else {
			return nil
		}
			
		return await rhs.tryGet(rhsWhole)
	}
}
