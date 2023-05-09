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
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		let part = lens.get(whole)
		let newPart = try f(part)
		return lens.setting(in: whole, to: newPart)
	}
	
	public func setting(
		in whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		try updating(in: whole) { _ in
			newValue
		}
	}
}

public struct LiftPrismToThrowing<P: PrismOptic>: ThrowingOptic {
	public typealias Whole = P.Whole
	public typealias NewWhole = Whole
	public typealias Part = P.Part
	public typealias NewPart = Part
	
	public let optic: P
	
	public init(optic: P) {
		self.optic = optic
	}
	
	@inlinable
	public func get(_ whole: Whole) throws -> Part {
		guard let part = optic.extract(from: whole) else {
			throw(ThrowingError.noData)
		}
		
		return part
	}
	
	@inlinable
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart) throws -> NewWhole {
		guard var value = optic.extract(from: whole) else {
			throw(ThrowingError.noData)
		}
		
		value = try f(value)
		
		return optic.embed(value)
	}
	
	@inlinable
	public func setting(
		in whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		optic.embed(newValue)
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
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		guard let part = optic.tryGet(whole) else {
			throw(ThrowingError.noData)
		}
		
		let newPart = try f(part)
		
		return optic.trySetting(in: whole, to: newPart)
	}
	
	@inlinable
	public func setting(
		in whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		optic.trySetting(in: whole, to: newValue)
	}
}
