import Foundation

public struct AnyOf<P: OptionalOptic>: OptionalOptic {
	public typealias Whole = P.Whole
	public typealias NewWhole = P.NewWhole
	public typealias Part = P.Part
	public typealias NewPart = P.NewPart
	
	public let optics: P
	
	@inlinable
	public init(
		@AnyOfBuilder with build: () -> P
	) {
		self.optics = build()
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.optics.tryGet(whole)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optics.tryUpdating(in: whole, update: f)
	}
	
	public func trySetting(
		in whole: Whole,
		updateo newValue: NewPart
	) -> NewWhole {
		optics.trySetting(in: whole, to: newValue)
	}
}

@resultBuilder
public enum AnyOfBuilder {
	public static func buildOptional<O: PrismOptic>(
		_ optic: O?
	) -> OptionalOpticFromPrismOptional<O.Whole, O.Part, O> {
		.init(optic: optic)
	}
	
	public static func buildOptional<O: OptionalOptic>(
		_ optic: O?
	) -> OptionalOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<O0: PrismOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> AnyOfPrisms<O0, O1>
	where O0.Whole == O1.Whole, O0.Part == O1.Part {
		AnyOfPrisms(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> AnyOfOptionalPrism<O0, O1>
	where O0.Whole == O1.Whole, O0.Part == O1.Part {
		AnyOfOptionalPrism(lhs: o0, rhs: o1)
	}
	
	public static func buildPartialBlock<O0: PrismOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> AnyOfOptionals<OptionalOpticFromPrismOptional<O0.Whole, O0.Part, O0>, O1>
	where O0.Whole == O1.Whole, O0.Part == O1.Part {
		AnyOfOptionals(
			lhs: OptionalOpticFromPrismOptional(optic: o0),
			rhs: o1
		)
	}
	
	public static func buildPartialBlock<O0: OptionalOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> AnyOfOptionals<O0, O1>
	where O0.Whole == O1.Whole, O0.Part == O1.Part {
		AnyOfOptionals(lhs: o0, rhs: o1)
	}
}

public struct AnyOfPrisms<LHS: PrismOptic, RHS: PrismOptic>: OptionalOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = Whole
	public typealias Part = RHS.Part
	public typealias NewPart = Part

	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.extract(from: whole) ?? rhs.extract(from: whole)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var result = whole
		
		lhs.tryUpdate(in: &result) { part in
			part = f(part)
		}
		rhs.tryUpdate(in: &result) { part in
			part = f(part)
		}
		
		return result
	}

	public func trySetting(
		_ whole: LHS.Whole,
		to newValue: RHS.Part
	) -> LHS.Whole {
		var copy = whole
		lhs.trySet(in: &copy, to: newValue)
		rhs.trySet(in: &copy, to: newValue)
		return copy
	}
}

public struct AnyOfOptionals<LHS: OptionalOptic, RHS: OptionalOptic>: OptionalOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewWhole == LHS.Whole, LHS.NewPart == LHS.Part, RHS.NewWhole == RHS.Whole, RHS.NewPart == RHS.Part {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = Whole
	public typealias Part = RHS.Part
	public typealias NewPart = Part

	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.tryGet(whole) ?? rhs.tryGet(whole)
	}
	
	public func tryUpdating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		var result = whole
		
		result = lhs.tryUpdating(in: result) { part in
			f(part)
		}
		
		result = rhs.tryUpdating(in: result) { part in
			f(part)
		}
		
		return result
	}

	public func trySetting(
		in whole: LHS.Whole,
		to newValue: RHS.Part
	) -> LHS.Whole {
		var copy = whole
		lhs.trySet(in: &copy, to: newValue)
		rhs.trySet(in: &copy, to: newValue)
		return copy
	}
}

public struct AnyOfOptionalPrism<LHS: OptionalOptic, RHS: PrismOptic>: OptionalOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part, LHS.NewPart == LHS.Part, LHS.NewWhole == LHS.Whole {
	let lhs: LHS
	let rhs: RHS

	public typealias Whole = LHS.Whole
	public typealias NewWhole = Whole
	public typealias Part = RHS.Part
	public typealias NewPart = Part

	public func tryGet(_ whole: LHS.Whole) -> RHS.Part? {
		lhs.tryGet(whole) ?? rhs.extract(from: whole)
	}
	
	public func tryUpdating(
		in whole: LHS.Whole,
		update f: @escaping (RHS.Part) -> RHS.Part
	) -> NewWhole {
		var result = whole
		lhs.tryUpdate(in: &result) { part in
			part = f(part)
		}
		rhs.tryUpdate(in: &result) { part in
			part = f(part)
		}
		return result
	}
	
	public func trySetting(in whole: LHS.Whole, to newValue: RHS.Part) -> LHS.NewWhole {
		var copy = whole
		lhs.trySet(in: &copy, to: newValue)
		rhs.trySet(in: &copy, to: newValue)
		return copy
	}
}
