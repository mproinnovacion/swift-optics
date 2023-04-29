import Foundation

@resultBuilder
public enum OptionalGetterOpticBuilder {
	public static func buildPartialBlock<O: OptionalGetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O: GetterOptic>(
		first optic: O
	) -> LiftGetterToOptional<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> OptionalGetterFunc0<R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> OptionalGetterFunc1<O0, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> R
	) -> OptionalGetterFunc2<O0, O1, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> R
	) -> OptionalGetterFunc3<O0, O1, O2, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> R
	) -> OptionalGetterFunc4<O0, O1, O2, O3, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> R
	) -> OptionalGetterFunc5<O0, O1, O2, O3, O4, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> R
	) -> OptionalGetterFunc6<O0, O1, O2, O3, O4, O5, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0: OptionalGetterOptic, O1: GetterOptic>(accumulated o0: O0, next o1: O1) -> OptionalGetterCombination<O0, LiftGetterToOptional<O1>> {
		OptionalGetterCombination(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: OptionalGetterOptic, O1: OptionalGetterOptic>(accumulated o0: O0, next o1: O1) -> OptionalGetterCombination<O0, O1> {
		OptionalGetterCombination(lhs: o0, rhs: o1)
	}
}

public struct OptionalGetterCombination<LHS: OptionalGetterOptic, RHS: OptionalGetterOptic>: OptionalGetterOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.tryGet(whole).flatMap(rhs.tryGet)
	}
}
