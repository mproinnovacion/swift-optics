import Foundation

@resultBuilder
public enum ThrowingGetterOpticBuilder {
	public static func buildPartialBlock<O: ThrowingGetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> ThrowingGetterFunc0<R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> ThrowingGetterFunc1<O0, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> R
	) -> ThrowingGetterFunc2<O0, O1, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> R
	) -> ThrowingGetterFunc3<O0, O1, O2, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> R
	) -> ThrowingGetterFunc4<O0, O1, O2, O3, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> R
	) -> ThrowingGetterFunc5<O0, O1, O2, O3, O4, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> R
	) -> ThrowingGetterFunc6<O0, O1, O2, O3, O4, O5, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0: ThrowingGetterOptic, O1: ThrowingGetterOptic>(accumulated o0: O0, next o1: O1) -> ThrowingGetterCombination<O0, O1> {
		ThrowingGetterCombination(lhs: o0, rhs: o1)
	}
}

public struct ThrowingArrayGetterLiftArrayOptic<O: ArrayGetterOptic>: ThrowingArrayGetterOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		optic.getAll(whole)
	}
}

public struct ThrowingArrayGetterLiftOptic<O: ThrowingGetterOptic>: ThrowingArrayGetterOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		[try optic.get(whole)]
	}
}

public struct ThrowingGetterCombination<LHS: ThrowingGetterOptic, RHS: ThrowingGetterOptic>: ThrowingGetterOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func get(_ whole: LHS.Whole) throws -> RHS.Part {
		let part = try lhs.get(whole)
		return try rhs.get(part)
	}
}
