import Foundation

public struct AsyncZip<L: AsyncLensOptic>: AsyncLensOptic {
	public typealias Whole = L.Whole
	public typealias NewWhole = L.NewWhole
	public typealias Part = L.Part
	public typealias NewPart = L.NewPart
	
	public let lens: L

	@inlinable
	public init(
		@AsyncZipLensBuilder with build: () -> L
	) {
		self.lens = build()
	}
	
	public func get(_ whole: Whole) async -> Part {
		await lens.get(whole)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await lens.updating(whole, f)
	}
}

@resultBuilder
public enum AsyncZipLensBuilder {
	public static func buildPartialBlock<O: AsyncLensOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: AsyncLensOptic, O1: AsyncLensOptic>(accumulated o0: O0, next o1: O1) -> ZipCombination<O0, O1> {
		ZipCombination(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: AsyncLensOptic, O1: AsyncLensOptic, O2: LensOptic>(accumulated o0: O0, next: AsyncZipCombination<O1, O2>) -> AsyncZipCombination3<O0, O1, O2> {
		AsyncZipCombination3(o0: o0, o1: next.lhs, o2: next.rhs)
	}
	
	public static func buildExpression<O: AsyncLensOptic>(_ expression: O) -> O {
		expression
	}
}

public struct AsyncZipCombination<LHS: AsyncLensOptic, RHS: AsyncLensOptic>: AsyncLensOptic
where LHS.Whole == RHS.Whole, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = (LHS.Part, RHS.Part)
	public typealias NewPart = (LHS.NewPart, RHS.NewPart)
	
	public func get(_ whole: Whole) async -> Part {
		await (
			lhs.get(whole),
			rhs.get(whole)
		)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		let lhsPart = await lhs.get(whole)
		let rhsPart = await rhs.get(whole)
		
		let updated = try await lhs.updating(whole) { lhsPart in
			try await f((lhsPart, rhsPart)).0
		}
				
		return try await rhs.updating(updated) { rhsPart in
			try await f((lhsPart, rhsPart)).1
		}
	}
}

public struct AsyncZipCombination3<O0: AsyncLensOptic, O1: AsyncLensOptic, O2: AsyncLensOptic>: AsyncLensOptic
where O0.Whole == O1.Whole, O0.NewWhole == O1.NewWhole, O0.NewWhole == O0.Whole, O0.Whole == O2.Whole, O2.NewWhole == O2.Whole {
	let o0: O0
	let o1: O1
	let o2: O2
	
	public typealias Whole = O0.Whole
	public typealias NewWhole = O0.NewWhole
	public typealias Part = (O0.Part, O1.Part, O2.Part)
	public typealias NewPart = (O0.NewPart, O1.NewPart, O2.NewPart)
	
	public func get(_ whole: Whole) async -> Part {
		await (
			o0.get(whole),
			o1.get(whole),
			o2.get(whole)
		)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		let o0Part = await o0.get(whole)
		let o1Part = await o1.get(whole)
		let o2Part = await o2.get(whole)
		
		var updated = try await o0.updating(whole) { o0Part in
			try await f((o0Part, o1Part, o2Part)).0
		}
				
		updated = try await o1.updating(updated) { o1Part in
			try await f((o0Part, o1Part, o2Part)).1
		}
		
		updated = try await o2.updating(updated) { o2Part in
			try await f((o0Part, o1Part, o2Part)).2
		}
		
		return updated
	}
}
