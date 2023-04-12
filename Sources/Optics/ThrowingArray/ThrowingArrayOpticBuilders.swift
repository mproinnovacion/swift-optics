import Foundation

@resultBuilder
public enum ThrowingArrayOpticBuilder {
	public static func buildOptional<O: OptionalOptic>(
		_ optic: O?
	) -> ThrowingArrayOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		ThrowingArrayOpticFromOptional(optic: optic)
	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> ThrowingArrayLiftLensOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> ThrowingArrayLiftPrismOptic<O> {
		.init(prism: optic)
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ThrowingArrayLiftOptionalOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: ThrowingOptic>(first optic: O) -> ThrowingArrayLiftThrowingOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: ThrowingArrayOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, ThrowingArrayLiftLensOptic<O1>> {
		CombineThrowingArray(lhs: o0, rhs: ThrowingArrayLiftLensOptic(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, ThrowingArrayLiftPrismOptic<O1>> {
		CombineThrowingArray(lhs: o0, rhs: ThrowingArrayLiftPrismOptic(prism: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, ThrowingArrayLiftOptionalOptic<O1>> {
		CombineThrowingArray(lhs: o0, rhs: ThrowingArrayLiftOptionalOptic(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: ArrayOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0, ThrowingArrayLiftArrayOptic<O1>> {
		CombineThrowingArray(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayOptic, O1: ThrowingOptic>(accumulated o0: O0, next o1: O1) -> CombineThrowingArray<O0,  ThrowingArrayLiftThrowingOptic<O1>> {
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
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		guard let optic = self.optic else {
			throw(ThrowingError.noData)
		}
		
		return try optic.updatingAll(whole, f)
	}
}

public struct ThrowingArrayLiftLensOptic<O: LensOptic>: ThrowingArrayOptic where O.Part == O.NewPart {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public init(optic: O) {
		self.lens = optic
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		[lens.get(whole)]
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		lens.updating(whole) { part in
			(try? f(part)) ?? part
		}
	}
}

public struct ThrowingArrayLiftPrismOptic<P: PrismOptic>: ThrowingArrayOptic {
	public typealias Whole = P.Whole
	public typealias NewWhole = Whole
	public typealias Part = P.Part
	public typealias NewPart = Part
	
	public let prism: P
	
	public init(prism: P) {
		self.prism = prism
	}
	
	@inlinable
	public func getAll(_ whole: Whole) throws -> [Part] {
		[prism.extract(from: whole)].compactMap { $0 }
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart) throws -> NewWhole {
		guard var value = prism.extract(from: whole) else {
			throw(ThrowingError.noData)
		}
		
		value = try f(value)
		
		return prism.embed(value)
	}
}

public struct ThrowingArrayLiftOptionalOptic<O: OptionalOptic>: ThrowingArrayOptic
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
	public func getAll(_ whole: Whole) throws -> [Part] {
		[optic.tryGet(whole)].compactMap { $0 }
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		optic.tryUpdating(whole) { part in
			(try? f(part)) ?? part
		}
	}
}

public struct ThrowingArrayLiftThrowingOptic<O: ThrowingOptic>: ThrowingArrayOptic
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
	public func getAll(_ whole: Whole) throws -> [Part] {
		[try optic.get(whole)]
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updating(whole, f)
	}
}

public struct ThrowingArrayLiftArrayOptic<O: ArrayOptic>: ThrowingArrayOptic {
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public let optic: O
	
	public init(optic: O) {
		self.optic = optic
	}
	
	@inlinable
	public func getAll(_ whole: Whole) throws -> [Part] {
		optic.getAll(whole)
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updatingAll(whole) { part in
			try f(part)
		}
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
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try lhs.updatingAll(whole) { lhsPart in
			try rhs.updatingAll(lhsPart, f)
		}
	}
}
