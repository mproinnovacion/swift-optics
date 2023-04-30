import Foundation

@resultBuilder
public enum OptionalSetterOpticBuilder {
	public static func buildPartialBlock<O: OptionalSetterOptic>(first optic: O) -> O {
		optic
	}
	
	// MARK: Funcs
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> OptionalSetterProvidedWholeOptic<OptionalSetterFunc0<R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> OptionalSetterProvidedWholeOptic<OptionalSetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> R
	) -> OptionalSetterProvidedWholeOptic<OptionalSetterFunc2<O0, O1, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) -> R
	) -> OptionalSetterProvidedWholeOptic<OptionalSetterFunc3<O0, O1, O2, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) -> R
	) -> OptionalSetterProvidedWholeOptic<OptionalSetterFunc4<O0, O1, O2, O3, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) -> R
	) -> OptionalSetterProvidedWholeOptic<OptionalSetterFunc5<O0, O1, O2, O3, O4, R, R>> {
		.init(optic: .init(), whole: f)
	}

	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) -> R
	) -> OptionalSetterProvidedWholeOptic<OptionalSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	// MARK: Async
	public static func buildPartialBlock<R>(
		first f: @escaping () async -> R
	) -> OptionalSetterProvidedWholeOptic<AsyncOptionalSetterFunc0<R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) async -> R
	) -> OptionalSetterProvidedWholeOptic<AsyncOptionalSetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async -> R
	) -> OptionalSetterProvidedWholeOptic<AsyncOptionalSetterFunc2<O0, O1, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async -> R
	) -> OptionalSetterProvidedWholeOptic<AsyncOptionalSetterFunc3<O0, O1, O2, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async -> R
	) -> OptionalSetterProvidedWholeOptic<AsyncOptionalSetterFunc4<O0, O1, O2, O3, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async -> R
	) -> OptionalSetterProvidedWholeOptic<AsyncOptionalSetterFunc5<O0, O1, O2, O3, O4, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async -> R
	) -> OptionalSetterProvidedWholeOptic<AsyncOptionalSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	// MARK: ThrowingFuncs
	public static func buildPartialBlock<R>(
		first f: @escaping () throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingOptionalSetterFunc0<R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingOptionalSetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingOptionalSetterFunc2<O0, O1, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingOptionalSetterFunc3<O0, O1, O2, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingOptionalSetterFunc4<O0, O1, O2, O3, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingOptionalSetterFunc5<O0, O1, O2, O3, O4, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingOptionalSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	// MARK: ThrowingAsyncFuncs
	public static func buildPartialBlock<R>(
		first f: @escaping () async throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingAsyncOptionalSetterFunc0<R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingAsyncOptionalSetterFunc1<O0, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingAsyncOptionalSetterFunc2<O0, O1, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, R>(
		first f: @escaping (O0, O1, O2) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingAsyncOptionalSetterFunc3<O0, O1, O2, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, R>(
		first f: @escaping (O0, O1, O2, O3) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingAsyncOptionalSetterFunc4<O0, O1, O2, O3, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
		first f: @escaping (O0, O1, O2, O3, O4) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingAsyncOptionalSetterFunc5<O0, O1, O2, O3, O4, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
		first f: @escaping (O0, O1, O2, O3, O4, O5) async throws -> R
	) -> OptionalSetterProvidedWholeOptic<ThrowingAsyncOptionalSetterFunc6<O0, O1, O2, O3, O4, O5, R, R>> {
		.init(optic: .init(), whole: f)
	}
	
	public static func buildPartialBlock<O0: OptionalSetterOptic, O1: OptionalSetterOptic>(accumulated o0: O0, next o1: O1) -> OptionalSetterCombination<O0, O1> {
		OptionalSetterCombination(lhs: o0, rhs: o1)
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
