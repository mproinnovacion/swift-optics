import Foundation

@resultBuilder
public enum ArrayGetterOpticBuilder {
	public static func buildPartialBlock<O: GetterOptic>(first optic: O) -> ArrayGetterLiftOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalGetterOptic>(first optic: O) -> ArrayGetterOptionalLiftOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArrayGetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<R>(
		first f: @escaping () -> [R]
	) -> ArrayGetterFunc0<R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> [R]
	) -> ArrayGetterFunc1<O0, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> [R]
	) -> ArrayGetterFunc2<O0, O1, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> [R]
	) -> ArrayGetterFunc3<O0, O1, O2, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> [R]
	) -> ArrayGetterFunc4<O0, O1, O2, O3, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> [R]
	) -> ArrayGetterFunc5<O0, O1, O2, O3, O4, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> [R]
	) -> ArrayGetterFunc6<O0, O1, O2, O3, O4, O5, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic, O1: GetterOptic>(accumulated o0: O0, next o1: O1) -> ArrayGetterCombination<O0, ArrayGetterLiftOptic<O1>> {
		ArrayGetterCombination(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic, O1: OptionalGetterOptic>(accumulated o0: O0, next o1: O1) -> ArrayGetterCombination<O0, ArrayGetterOptionalLiftOptic<O1>> {
		ArrayGetterCombination(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic, O1: ArrayGetterOptic>(accumulated o0: O0, next o1: O1) -> ArrayGetterCombination<O0, O1> {
		ArrayGetterCombination(lhs: o0, rhs: o1)
	}
}

public struct ArrayGetterLiftOptic<O: GetterOptic>: ArrayGetterOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public func getAll(_ whole: Whole) -> [Part] {
		[optic.get(whole)]
	}
}

public struct ArrayGetterOptionalLiftOptic<O: OptionalGetterOptic>: ArrayGetterOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public func getAll(_ whole: Whole) -> [Part] {
		[optic.tryGet(whole)].compactMap { $0 }
	}
}

public struct ArrayGetterCombination<LHS: ArrayGetterOptic, RHS: ArrayGetterOptic>: ArrayGetterOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole).flatMap(rhs.getAll)
	}
}
