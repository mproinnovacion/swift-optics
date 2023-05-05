import Foundation

@resultBuilder
public enum OptionalSetterOpticBuilder {
	public static func buildPartialBlock<O: SetterOptic>(first optic: O) -> LiftSetterToOptional<O> {
		LiftSetterToOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalSetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: OptionalSetterOptic, O1: SetterOptic>(accumulated o0: O0, next o1: O1) -> OptionalSetterCombination<O0, LiftSetterToOptional<O1>> {
		OptionalSetterCombination(lhs: o0, rhs: LiftSetterToOptional(optic: o1))
	}
	
	public static func buildPartialBlock<O0: OptionalSetterOptic, O1: OptionalSetterOptic>(accumulated o0: O0, next o1: O1) -> OptionalSetterCombination<O0, O1> {
		OptionalSetterCombination(lhs: o0, rhs: o1)
	}
	
	// MARK: Funcs
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<SetterFunc0<R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<SetterFunc1<O0, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<SetterFunc2<O0, O1, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<SetterFunc3<O0, O1, O2, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<SetterFunc4<O0, O1, O2, O3, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<SetterFunc5<O0, O1, O2, O3, O4, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<SetterFunc6<O0, O1, O2, O3, O4, O5, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	// MARK: Async
	public static func buildPartialBlock<R>(
		first f: @escaping () async -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<AsyncSetterFunc0<R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) async -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<AsyncSetterFunc1<O0, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<AsyncSetterFunc2<O0, O1, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<AsyncSetterFunc3<O0, O1, O2, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<AsyncSetterFunc4<O0, O1, O2, O3, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<AsyncSetterFunc5<O0, O1, O2, O3, O4, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<AsyncSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	// MARK: ThrowingFuncs
	public static func buildPartialBlock<R>(
		first f: @escaping () throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingSetterFunc0<R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingSetterFunc1<O0, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingSetterFunc2<O0, O1, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingSetterFunc3<O0, O1, O2, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingSetterFunc4<O0, O1, O2, O3, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingSetterFunc5<O0, O1, O2, O3, O4, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>>> {
		.init(optic: .init(optic: .init()), whole: f)
	}
	
	// MARK: ThrowingAsyncFuncs
	public static func buildPartialBlock<R>(
		first f: @escaping () async throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingAsyncSetterFunc0<R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingAsyncSetterFunc1<O0, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingAsyncSetterFunc2<O0, O1, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingAsyncSetterFunc3<O0, O1, O2, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingAsyncSetterFunc4<O0, O1, O2, O3, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingAsyncSetterFunc5<O0, O1, O2, O3, O4, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<LiftSetterToOptional<ThrowingAsyncSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>>> {
		.init(optic: .init(optic: .init()), whole: .init(run: f))
	}
}

public struct OptionalSetterCombination<LHS: OptionalSetterOptic, RHS: OptionalSetterOptic>: OptionalSetterOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.tryUpdating(whole) { lhsPart in
			rhs.tryUpdating(lhsPart, f)
		}
	}
}
