import Foundation

public struct LiftLensToThrowing<O: LensOptic>: ThrowingOptic {
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
		try lens.updating(whole) { part in
			try f(part)
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

public struct LiftPrismToThrowing<P: PrismOptic>: ThrowingOptic {
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

public struct LiftOptionalToThrowing<O: OptionalOptic>: ThrowingOptic {
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
		try optic.tryUpdating(whole) { part in
			try f(part)
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
