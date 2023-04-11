import Foundation

@resultBuilder
public enum ThrowingOpticBuilder {
	public static func buildOptional<O: OptionalOptic>(
		_ optic: O?
	) -> ThrowingOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ThrowingOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> ThrowingLiftLensOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> ThrowingLiftPrismOptic<O> {
		.init(prism: optic)
	}
	
	public static func buildPartialBlock<O: ThrowingOptic>(first optic: O) -> ThrowingLiftOptionalOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowing<O0, ThrowingLiftLensOptic<O1>> {
		CombineThrowing(lhs: o0, rhs: ThrowingLiftLensOptic(optic: o1))
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowing<O0, ThrowingLiftPrismOptic<O1>> {
		CombineThrowing(lhs: o0, rhs: ThrowingLiftPrismOptic(prism: o1))
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowing<O0, O1> {
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

public struct ThrowingLiftLensOptic<O: LensOptic>: ThrowingOptic where O.Part == O.NewPart {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public init(optic: O) {
		self.lens = optic
	}
	
	public func get(_ whole: Whole) throws -> Part {
		lens.get(whole)
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		lens.updating(whole) { part in
			(try? f(part)) ?? part
		}
	}
	
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		try updating(whole) { _ in
			newValue
		}
	}
}

public struct ThrowingLiftPrismOptic<P: PrismOptic>: ThrowingOptic {
	public typealias Whole = P.Whole
	public typealias NewWhole = Whole
	public typealias Part = P.Part
	public typealias NewPart = Part
	
	public let prism: P
	
	public init(prism: P) {
		self.prism = prism
	}
	
	@inlinable
	public func get(_ whole: Whole) throws -> Part {
		guard let part = prism.extract(from: whole) else {
			throw(ThrowingError.noData)
		}
		
		return part
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart) throws -> NewWhole {
		guard var value = prism.extract(from: whole) else {
			throw(ThrowingError.noData)
		}
		
		value = try f(value)
		
		return prism.embed(value)
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		prism.embed(newValue)
	}
}

public struct ThrowingLiftOptionalOptic<O: OptionalOptic>: ThrowingOptic
where O.NewPart == O.Part {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	@inlinable
	public func get(_ whole: Whole) throws -> Part {
		guard let part = optic.tryGet(whole) else {
			throw(ThrowingError.noData)
		}
		
		return part
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		optic.tryUpdating(whole) { part in
			(try? f(part)) ?? part
		}
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		optic.trySetting(whole, to: newValue)
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
