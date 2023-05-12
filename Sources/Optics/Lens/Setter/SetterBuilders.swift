import Foundation

@resultBuilder
public enum SetterOpticBuilder {
	public static func buildPartialBlock<O: SetterOptic>(first optic: O) -> O {
		optic
	}
	
	// MARK: Funcs
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> SetterProvidedWholeOptic<SetterFunc0<R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> SetterProvidedWholeOptic<SetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> R
	) -> SetterProvidedWholeOptic<SetterFunc2<O0, O1, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> R
	) -> SetterProvidedWholeOptic<SetterFunc3<O0, O1, O2, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> R
	) -> SetterProvidedWholeOptic<SetterFunc4<O0, O1, O2, O3, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> R
	) -> SetterProvidedWholeOptic<SetterFunc5<O0, O1, O2, O3, O4, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> R
	) -> SetterProvidedWholeOptic<SetterFunc6<O0, O1, O2, O3, O4, O5, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	// MARK: Async
	public static func buildPartialBlock<R>(
		first f: @escaping () async -> R
	) -> SetterProvidedWholeOptic<AsyncSetterFunc0<R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) async -> R
	) -> SetterProvidedWholeOptic<AsyncSetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async -> R
	) -> SetterProvidedWholeOptic<AsyncSetterFunc2<O0, O1, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async -> R
	) -> SetterProvidedWholeOptic<AsyncSetterFunc3<O0, O1, O2, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async -> R
	) -> SetterProvidedWholeOptic<AsyncSetterFunc4<O0, O1, O2, O3, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async -> R
	) -> SetterProvidedWholeOptic<AsyncSetterFunc5<O0, O1, O2, O3, O4, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async -> R
	) -> SetterProvidedWholeOptic<AsyncSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	// MARK: ThrowingFuncs
	public static func buildPartialBlock<R>(
		first f: @escaping () throws -> R
	) -> SetterProvidedWholeOptic<ThrowingSetterFunc0<R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) throws -> R
	) -> SetterProvidedWholeOptic<ThrowingSetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) throws -> R
	) -> SetterProvidedWholeOptic<ThrowingSetterFunc2<O0, O1, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) throws -> R
	) -> SetterProvidedWholeOptic<ThrowingSetterFunc3<O0, O1, O2, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) throws -> R
	) -> SetterProvidedWholeOptic<ThrowingSetterFunc4<O0, O1, O2, O3, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) throws -> R
	) -> SetterProvidedWholeOptic<ThrowingSetterFunc5<O0, O1, O2, O3, O4, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) throws -> R
	) -> SetterProvidedWholeOptic<ThrowingSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	// MARK: ThrowingAsyncFuncs
	public static func buildPartialBlock<R>(
		first f: @escaping () async throws -> R
	) -> SetterProvidedWholeOptic<ThrowingAsyncSetterFunc0<R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) async throws -> R
	) -> SetterProvidedWholeOptic<ThrowingAsyncSetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async throws -> R
	) -> SetterProvidedWholeOptic<ThrowingAsyncSetterFunc2<O0, O1, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async throws -> R
	) -> SetterProvidedWholeOptic<ThrowingAsyncSetterFunc3<O0, O1, O2, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async throws -> R
	) -> SetterProvidedWholeOptic<ThrowingAsyncSetterFunc4<O0, O1, O2, O3, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async throws -> R
	) -> SetterProvidedWholeOptic<ThrowingAsyncSetterFunc5<O0, O1, O2, O3, O4, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async throws -> R
	) -> SetterProvidedWholeOptic<ThrowingAsyncSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>> {
		.init(optic: .init(), whole: .init(run: f))
	}
	
	public static func buildPartialBlock<O0: SetterOptic, O1: SetterOptic>(accumulated o0: O0, next o1: O1) -> SetterCombination<O0, O1> {
		SetterCombination(lhs: o0, rhs: o1)
	}
}

public struct SetterCombination<LHS: SetterOptic, RHS: SetterOptic>: SetterOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lhs.updating(in: whole) { lhsPart in
			rhs.updating(in: lhsPart, update: f)
		}
	}
}
