import Foundation

@resultBuilder
public enum ArraySetterOpticBuilder {
	public static func buildPartialBlock<O: SetterOptic>(first optic: O) -> LiftSetterToArray<O> {
		LiftSetterToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> LiftPrismToArray<O> {
		LiftPrismToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalSetterOptic>(first optic: O) -> LiftOptionalSetterToArray<O> {
		LiftOptionalSetterToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArraySetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ArraySetterOptic, O1: SetterOptic>(accumulated o0: O0, next o1: O1) -> ArraySetterCombination<O0, LiftSetterToArray<O1>> {
		ArraySetterCombination(lhs: o0, rhs: LiftSetterToArray(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ArraySetterOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> ArraySetterCombination<O0, LiftPrismToArray<O1>> {
		ArraySetterCombination(lhs: o0, rhs: LiftPrismToArray(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ArraySetterOptic, O1: OptionalSetterOptic>(accumulated o0: O0, next o1: O1) -> ArraySetterCombination<O0, LiftOptionalSetterToArray<O1>> {
		ArraySetterCombination(lhs: o0, rhs: LiftOptionalSetterToArray(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ArraySetterOptic, O1: ArraySetterOptic>(accumulated o0: O0, next o1: O1) -> ArraySetterCombination<O0, O1> {
		ArraySetterCombination(lhs: o0, rhs: o1)
	}
	
	// MARK: Funcs
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<SetterFunc0<R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<SetterFunc1<O0, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<SetterFunc2<O0, O1, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<SetterFunc3<O0, O1, O2, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<SetterFunc4<O0, O1, O2, O3, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<SetterFunc5<O0, O1, O2, O3, O4, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<SetterFunc6<O0, O1, O2, O3, O4, O5, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	// MARK: Async
	public static func buildPartialBlock<R>(
		first f: @escaping () async -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<AsyncSetterFunc0<R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) async -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<AsyncSetterFunc1<O0, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<AsyncSetterFunc2<O0, O1, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<AsyncSetterFunc3<O0, O1, O2, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<AsyncSetterFunc4<O0, O1, O2, O3, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<AsyncSetterFunc5<O0, O1, O2, O3, O4, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<AsyncSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	// MARK: ThrowingFuncs
	public static func buildPartialBlock<R>(
		first f: @escaping () throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingSetterFunc0<R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingSetterFunc1<O0, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingSetterFunc2<O0, O1, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingSetterFunc3<O0, O1, O2, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingSetterFunc4<O0, O1, O2, O3, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingSetterFunc5<O0, O1, O2, O3, O4, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	// MARK: ThrowingAsyncFuncs
	public static func buildPartialBlock<R>(
		first f: @escaping () async throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingAsyncSetterFunc0<R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) async throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingAsyncSetterFunc1<O0, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingAsyncSetterFunc2<O0, O1, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingAsyncSetterFunc3<O0, O1, O2, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingAsyncSetterFunc4<O0, O1, O2, O3, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingAsyncSetterFunc5<O0, O1, O2, O3, O4, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async throws -> R
	) -> ArraySetterProvidedWholeOptic<LiftSetterToArray<ThrowingAsyncSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
}

public struct ArraySetterCombination<LHS: ArraySetterOptic, RHS: ArraySetterOptic>: ArraySetterOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updatingAll(in: whole) { lhsPart in
			rhs.updatingAll(in: lhsPart, update: f)
		}
	}
	
	public func settingAll(
		in whole: LHS.Whole,
		to newValue: RHS.NewPart
	) -> LHS.NewWhole {
		lhs.updatingAll(in: whole) { part in
			rhs.settingAll(in: part, to: newValue)
		}
	}
}
