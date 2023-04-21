import Foundation

import Algebra

@resultBuilder
public enum ReduceOpticBuilder {
//	public static func buildOptional<O: ArrayOptic>(
//		_ optic: O?
//	) -> ReduceOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
//		ReduceOpticFromOptional(optic: optic)
//	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> ReduceLiftLensOptic<O> {
		.init(lens: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> ArrayOptionalLiftOptic<OptionalLiftPrismOptic<O>> {
		.init(optic: .init(prism: optic))
	}

	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayOptionalLiftOptic<O> {
		.init(optic: optic)
	}

	public static func buildPartialBlock<O: ReduceOptic>(first optic: O) -> O {
		optic
	}

	public static func buildPartialBlock<O0: ReduceOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineReduceOptics<O0, ReduceLiftLensOptic<O1>> {
		CombineReduceOptics(lhs: o0, rhs: .init(lens: o1))
	}

	public static func buildPartialBlock<O0: ReduceOptic, O1: ReduceOptic>(accumulated o0: O0, next o1: O1) -> CombineReduceOptics<O0, O1> {
		CombineReduceOptics(lhs: o0, rhs: o1)
	}

	public static func buildPartialBlock<O0: ReduceOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineReduceOptics<O0, ReduceLiftOptionalOptic<O1>> {
		CombineReduceOptics(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ReduceOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineReduceOptics<O0, ReduceLiftPrismOptic<O1>> {
		CombineReduceOptics(
			lhs: o0,
			rhs: .init(optic: o1)
		)
	}
}

//public struct ConcatReduceOptics<LHS: ReduceOptic, RHS: ReduceOptic>: ReduceOptic
//where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
//	let lhs: LHS
//	let rhs: RHS
//
//	public init(
//		lhs: LHS,
//		rhs: RHS
//	) {
//		self.lhs = lhs
//		self.rhs = rhs
//	}
//
//	public typealias Whole = LHS.Whole
//	public typealias Part = RHS.Part
//
//	public func reduced<Result>(
//		_ whole: LHS.Whole,
//		_ monoid: Monoid<Result>,
//		foldMap: @escaping (RHS.Part) -> Result
//	) -> Result {
//		monoid.combine(
//			lhs.reduced(whole, monoid, foldMap: foldMap),
//			rhs.reduced(whole, monoid, foldMap: foldMap)
//		)
//	}
//}

public struct CombineReduceOptics<LHS: ReduceOptic, RHS: ReduceOptic>: ReduceOptic
where LHS.Part == RHS.Whole {
	public let lhs: LHS
	public let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public init(lhs: LHS, rhs: RHS) {
		self.lhs = lhs
		self.rhs = rhs
	}
	
	public func reduced<Result>(
		_ whole: LHS.Whole,
		_ monoid: Algebra.Monoid<Result>,
		foldMap: (RHS.Part) -> Result
	) -> Result {
		lhs.reduced(whole, monoid) { rhsWhole in
			rhs.reduced(rhsWhole, monoid, foldMap: foldMap)
		}
	}
}

