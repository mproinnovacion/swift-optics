import Foundation

/// Concats ArrayOptic optics where the wholes and the parts match.
public struct Concat<Optics: ArrayOptic>: ArrayOptic {
	public typealias Whole = Optics.Whole
	public typealias NewWhole = Optics.NewWhole
	public typealias Part = Optics.Part
	public typealias NewPart = Optics.NewPart
	
	public let lens: Optics
	
	@inlinable
	public init(
		@ConcatLensesBuilderOf<Optics> with build: () -> Optics
	) {
		self.lens = build()
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		lens.getAll(whole)
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lens.updatingAll(whole, f)
	}
}

public struct ConcatLenses<LHS: ArrayOptic, RHS: ArrayOptic>: ArrayOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == RHS.NewPart, LHS.NewWhole == RHS.NewWhole, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias NewWhole = LHS.NewWhole
	public typealias Part = LHS.Part
	public typealias NewPart = LHS.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		lhs.getAll(whole) + rhs.getAll(whole)
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		var result = whole
		result = try lhs.updatingAll(result, f)
		return try rhs.updatingAll(result, f)
	}
}

@resultBuilder
public enum ConcatLensesBuilder<Whole, Part, NewWhole, NewPart> {
	public static func buildOptional<O: ArrayOptic<Whole, Part, NewWhole, NewPart>>(
		_ optic: O?
	) -> ArrayOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ArrayOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftLensToArray<O> {
		LiftLensToArray(lens: optic)
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> LiftOptionalToArray<O> {
		LiftOptionalToArray(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArrayOptic<Whole, Part, NewWhole, NewPart>>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ArrayOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, LiftLensToArray<O1>> {
		ConcatLenses(
			lhs: o0,
			rhs: LiftLensToArray(lens: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic<Whole, Part, NewWhole, NewPart>, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, LiftOptionalToArray<O1>> {
		ConcatLenses(
			lhs: o0,
			rhs: LiftOptionalToArray(optic: o1)
		)
	}
	
	public static func buildPartialBlock<O0: ArrayOptic<Whole, Part, NewWhole, NewPart>, O1: ArrayOptic<Whole, Part, NewWhole, NewPart>>(accumulated o0: O0, next o1: O1) -> ConcatLenses<O0, O1> {
		ConcatLenses(lhs: o0, rhs: o1)
	}
	
	public static func buildExpression<O: ArrayOptic<Whole, Part, NewWhole, NewPart>>(_ expression: O) -> O {
		expression
	}
}

public typealias ConcatLensesBuilderOf<O: ArrayOptic> = ConcatLensesBuilder<O.Whole, O.Part, O.NewWhole, O.NewPart>
