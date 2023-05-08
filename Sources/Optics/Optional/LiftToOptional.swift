import Foundation

public struct LiftLensToOptional<O: LensOptic>: OptionalOptic {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public init(optic: O) {
		self.lens = optic
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		lens.get(whole)
	}
	
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		lens.updating(whole, f)
	}
	
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		tryUpdating(whole) { _ in
			newValue
		}
	}
}

public struct LiftPrismToOptional<P: PrismOptic>: OptionalOptic {
	public typealias Whole = P.Whole
	public typealias NewWhole = Whole
	public typealias Part = P.Part
	public typealias NewPart = Part
	
	public let optic: P
	
	public init(optic: P) {
		self.optic = optic
	}
	
	@inlinable
	public func tryGet(_ whole: Whole) -> Part? {
		optic.extract(from: whole)
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		guard var value = optic.extract(from: whole) else {
			return whole
		}
		
		value = f(value)
		
		return optic.embed(value)
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		optic.embed(newValue)
	}
}
