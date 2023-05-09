import Foundation

@resultBuilder
public enum ThrowingArrayOpticBuilder {
	public static func buildOptional<O: OptionalOptic>(
		_ optic: O?
	) -> ThrowingArrayOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ThrowingArrayOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftArrayToThrowingArray<LiftLensToArray<O>> {
		.init(optic: .init(optic: optic))
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> LiftArrayToThrowingArray<LiftOptionalToArray<LiftPrismToOptional<O>>> {
		.init(optic: .init(optic: .init(optic: optic)))
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> LiftArrayToThrowingArray<LiftOptionalToArray<O>> {
		.init(optic: .init(optic: optic))
	}
	
	public static func buildPartialBlock<O: ThrowingOptic>(first optic: O) -> LiftThrowingToThrowingArray<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: ThrowingArrayOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, LiftArrayToThrowingArray<LiftLensToArray<O1>>> {
		CombineThrowingArray(lhs: o0, rhs: .init(optic: .init(optic: o1)))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, LiftArrayToThrowingArray<LiftOptionalToArray<LiftPrismToOptional<O1>>>> {
		CombineThrowingArray(lhs: o0, rhs: .init(optic: .init(optic: .init(optic: o1))))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, LiftArrayToThrowingArray<LiftOptionalToArray<O1>>> {
		CombineThrowingArray(lhs: o0, rhs: .init(optic: .init(optic: o1)))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, LiftArrayToThrowingArray<O1>> {
		CombineThrowingArray(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: ThrowingOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0,  LiftThrowingToThrowingArray<O1>> {
		CombineThrowingArray(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: ThrowingArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, O1> {
		CombineThrowingArray(lhs: o0, rhs: o1)
	}
}

public struct ThrowingArrayOpticFromOptional<Whole, Part, NewPart, O: ThrowingArrayOptic>: ThrowingArrayOptic
where Whole == O.Whole, Part == O.Part, NewPart == O.NewPart, O.NewWhole == O.Whole {
	let optic: O?
	
	public typealias NewWhole = O.NewWhole
	
	public init(optic: O?) {
		self.optic = optic
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		guard let optic = self.optic else {
			throw(ThrowingError.noData)
		}
		
		return try optic.getAll(whole)
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		guard let optic = self.optic else {
			throw(ThrowingError.noData)
		}
		
		return try optic.updatingAll(in: whole, update: f)
	}
}

public struct CombineThrowingArray<LHS: ThrowingArrayOptic, RHS: ThrowingArrayOptic>: ThrowingArrayOptic
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
	
	public func getAll(_ whole: LHS.Whole) throws -> [RHS.Part] {
		let parts = try lhs.getAll(whole)
		
		return try parts.flatMap { part in
			try rhs.getAll(part)
		}
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try lhs.updatingAll(in: whole) { lhsPart in
			try rhs.updatingAll(in: lhsPart, update: f)
		}
	}
}
