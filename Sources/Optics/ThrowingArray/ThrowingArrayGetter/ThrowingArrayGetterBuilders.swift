import Foundation

@resultBuilder
public enum ThrowingArrayGetterOpticBuilder {
	public static func buildPartialBlock<O: ThrowingArrayGetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<R>(
		first f: @escaping () -> [R]
	) -> ThrowingArrayGetterFunc0<R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> [R]
	) -> ThrowingArrayGetterFunc1<O0, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> [R]
	) -> ThrowingArrayGetterFunc2<O0, O1, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> [R]
	) -> ThrowingArrayGetterFunc3<O0, O1, O2, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> [R]
	) -> ThrowingArrayGetterFunc4<O0, O1, O2, O3, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> [R]
	) -> ThrowingArrayGetterFunc5<O0, O1, O2, O3, O4, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> [R]
	) -> ThrowingArrayGetterFunc6<O0, O1, O2, O3, O4, O5, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayGetterOptic, O1: ThrowingArrayGetterOptic>(accumulated o0: O0, next o1: O1) -> ThrowingArrayGetterCombination<O0, O1> {
		ThrowingArrayGetterCombination(lhs: o0, rhs: o1)
	}
}

public struct ThrowingArrayGetterCombination<LHS: ThrowingArrayGetterOptic, RHS: ThrowingArrayGetterOptic>: ThrowingArrayGetterOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func getAll(_ whole: LHS.Whole) throws -> [RHS.Part] {
		let parts = try lhs.getAll(whole)
		return try parts.flatMap { part in
			try rhs.getAll(part)
		}
	}
}
