import Foundation

@resultBuilder
public enum GetterOpticBuilder {
	public static func buildPartialBlock<O: GetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> GetterFunc0<R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> GetterFunc1<O0, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> R
	) -> GetterFunc2<O0, O1, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> R
	) -> GetterFunc3<O0, O1, O2, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> R
	) -> GetterFunc4<O0, O1, O2, O3, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> R
	) -> GetterFunc5<O0, O1, O2, O3, O4, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> R
	) -> GetterFunc6<O0, O1, O2, O3, O4, O5, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0: GetterOptic, O1: GetterOptic>(accumulated o0: O0, next o1: O1) -> GetterCombination<O0, O1> {
		GetterCombination(lhs: o0, rhs: o1)
	}
}

public struct GetterCombination<LHS: GetterOptic, RHS: GetterOptic>: GetterOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func get(_ whole: LHS.Whole) -> RHS.Part {
		rhs.get(lhs.get(whole))
	}
}
