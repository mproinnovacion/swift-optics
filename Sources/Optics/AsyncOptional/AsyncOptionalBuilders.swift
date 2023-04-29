import Foundation

@resultBuilder
public enum AsyncOptionalOpticBuilder {
	public static func buildOptional<O: AsyncOptionalOptic>(
		_ optic: O?
	) -> AsyncOptionalOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		AsyncOptionalOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftLensToOptional<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> LiftPrismToOptional<O> {
		.init(prism: optic)
	}
	
	public static func buildPartialBlock<O: AsyncOptionalOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: AsyncOptionalOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> AsyncCombineOptionals<O0, LiftOptionalToAsync<LiftLensToOptional<O1>>> {
		AsyncCombineOptionals(lhs: o0, rhs: .init(optic: .init(optic: o1)))
	}
	
	public static func buildPartialBlock<O0: AsyncOptionalOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> AsyncCombineOptionals<O0, LiftOptionalToAsync<LiftPrismToOptional<O1>>> {
		AsyncCombineOptionals(lhs: o0, rhs: .init(optic: .init(prism: o1)))
	}
	
	public static func buildPartialBlock<O0: AsyncOptionalOptic, O1: AsyncOptionalOptic>(accumulated o0: O0, next o1: O1) -> AsyncCombineOptionals<O0, O1> {
		AsyncCombineOptionals(lhs: o0, rhs: o1)
	}
}

public struct AsyncOptionalOpticFromOptional<Whole, Part, NewPart, O: AsyncOptionalOptic>: AsyncOptionalOptic
where Whole == O.Whole, Part == O.Part, NewPart == O.NewPart, O.NewWhole == O.Whole {
	let optic: O?
	
	public typealias NewWhole = O.NewWhole
	
	public init(optic: O?) {
		self.optic = optic
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await optic?.tryGet(whole)
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await optic?.tryUpdating(whole, f) ?? whole
	}
	
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) async -> NewWhole {
		await optic?.trySetting(whole, to: newValue) ?? whole
	}
}

public struct AsyncCombineOptionals<LHS: AsyncOptionalOptic, RHS: AsyncOptionalOptic>: AsyncOptionalOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public init(lhs: LHS, rhs: RHS) {
		self.lhs = lhs
		self.rhs = rhs
	}
	
	public func tryGet(_ whole: LHS.Whole) async -> RHS.Part? {
		guard let rhsWhole = await lhs.tryGet(whole) else {
			return nil
		}
			
		return await rhs.tryGet(rhsWhole)
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await lhs.tryUpdating(whole) { lhsPart in
			try await rhs.tryUpdating(lhsPart, f)
		}
	}
	
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) async -> NewWhole {
		await lhs.tryUpdating(whole) { part in
			await rhs.trySetting(part, to: newValue)
		}
	}
}
