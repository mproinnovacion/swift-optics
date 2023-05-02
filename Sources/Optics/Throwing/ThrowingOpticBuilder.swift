import Foundation

@resultBuilder
public enum ThrowingOpticBuilder {
	public static func buildOptional<O: OptionalOptic>(
		_ optic: O?
	) -> ThrowingOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ThrowingOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> LiftLensToThrowing<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> LiftOptionalToThrowing<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> LiftPrismToThrowing<O> {
		.init(prism: optic)
	}
	
	public static func buildPartialBlock<O: ThrowingOptic>(first optic: O) -> LiftOptionalToThrowing<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O0: ThrowingOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowing<O0, LiftLensToThrowing<O1>> {
		CombineThrowing(lhs: o0, rhs: LiftLensToThrowing(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowing<O0, LiftPrismToThrowing<O1>> {
		CombineThrowing(lhs: o0, rhs: LiftPrismToThrowing(prism: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowing<O0, O1> {
		CombineThrowing(lhs: o0, rhs: o1)
	}
}

public struct ThrowingOpticFromOptional<Whole, Part, NewPart, O: ThrowingOptic>: ThrowingOptic
where Whole == O.Whole, Part == O.Part, NewPart == O.NewPart, O.NewWhole == O.Whole {
	let optic: O?
	
	public typealias NewWhole = O.NewWhole
	
	public init(optic: O?) {
		self.optic = optic
	}
	
	public func get(_ whole: Whole) throws -> Part {
		guard let optic = self.optic else {
			throw(ThrowingError.noData)
		}
		
		return try optic.get(whole)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		guard let optic = self.optic else {
			throw(ThrowingError.noData)
		}
		
		return try optic.updating(whole, f)
	}
	
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		guard let optic = self.optic else {
			throw(ThrowingError.noData)
		}
		
		return try optic.setting(whole, to: newValue)
	}
}

public struct CombineThrowing<LHS: ThrowingOptic, RHS: ThrowingOptic>: ThrowingOptic
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
	
	public func get(_ whole: LHS.Whole) throws -> RHS.Part {
		let part = try lhs.get(whole)
		return try rhs.get(part)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try lhs.updating(whole) { lhsPart in
			try rhs.updating(lhsPart, f)
		}
	}
	
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		try lhs.updating(whole) { part in
			try rhs.setting(part, to: newValue)
		}
	}
}
