import Foundation

@resultBuilder
public enum AsyncLensOpticBuilder {
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftLensToAsync<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: AsyncLensOptic>(first optic: O) -> O {
		optic
	}
		
	public static func buildPartialBlock<O0: AsyncLensOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> AsyncLensCombination<O0, LiftLensToAsync<O1>> {
		AsyncLensCombination(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: AsyncLensOptic, O1: AsyncLensOptic>(accumulated o0: O0, next o1: O1) -> AsyncLensCombination<O0, O1> {
		AsyncLensCombination(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: AsyncLensOptic, O1: AsyncLensOptic>(accumulated o0: O0, next o1: O1) -> AsyncLensEachCombinator<O0, O1> {
		AsyncLensEachCombinator(lhs: o0, rhs: o1)
	}
	
	public static func buildExpression<O: AsyncLensOptic>(_ expression: O) -> O {
		expression
	}
}

extension AsyncLensOptic {
	public func combine<O: AsyncLensOptic>(with optic: O) -> AsyncLensCombination<Self, O>
	where O.Whole == Part
	{
		.init(lhs: self, rhs: optic)
	}
}

public struct AsyncLensCombination<LHS: AsyncLensOptic, RHS: AsyncLensOptic>: AsyncLensOptic
where LHS.Part == RHS.Whole, LHS.NewPart == RHS.NewWhole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = RHS.Part
	public typealias NewPart = RHS.NewPart
	
	public func get(_ whole: LHS.Whole) async -> RHS.Part {
		await rhs.get(lhs.get(whole))
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await lhs.updating(whole) { lhsPart in
			try await rhs.updating(lhsPart, f)
		}
	}
}

public struct AsyncLensEachCombinator<LHS: AsyncLensOptic, RHS: AsyncLensOptic>: AsyncLensOptic
where LHS.Part == [RHS.Whole], LHS.NewPart == [RHS.NewWhole] {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = [RHS.Part]
	public typealias NewPart = [RHS.NewPart]
	
	public func get(_ whole: LHS.Whole) async -> [RHS.Part] {
		await lhs.get(whole).mapAsync { item in
			await rhs.get(item)
		}
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await lhs.updating(whole) { rhsWholes in
			let rhsParts = try await f(rhsWholes.mapAsync { await rhs.get($0) })
			
			return await zip(rhsWholes, rhsParts).mapAsync { whole, newPart in
				await rhs.updating(whole, { _ in newPart })
			}
		}
	}
}
