import Foundation

import Algebra

@resultBuilder
public enum FoldOpticBuilder {
//	public static func buildOptional<O: ArrayOptic>(
//		_ optic: O?
//	) -> FoldOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
//		FoldOpticFromOptional(optic: optic)
//	}
	
	public static func buildPartialBlock<O: LensOptic>(first optic: O) -> FoldLiftLensOptic<O> {
		.init(lens: optic)
	}
	
	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> ArrayOptionalLiftOptic<OptionalLiftPrismOptic<O>> {
		.init(optic: .init(prism: optic))
	}

	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayOptionalLiftOptic<O> {
		.init(optic: optic)
	}

	public static func buildPartialBlock<O: FoldOptic>(first optic: O) -> O {
		optic
	}

	public static func buildPartialBlock<O0: FoldOptic, O1: LensOptic>(accumulated o0: O0, next o1: O1) -> CombineFoldOptics<O0, FoldLiftLensOptic<O1>> {
		CombineFoldOptics(lhs: o0, rhs: .init(lens: o1))
	}

	public static func buildPartialBlock<O0: FoldOptic, O1: FoldOptic>(accumulated o0: O0, next o1: O1) -> CombineFoldOptics<O0, O1> {
		CombineFoldOptics(lhs: o0, rhs: o1)
	}

	public static func buildPartialBlock<O0: FoldOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineFoldOptics<O0, FoldLiftOptionalOptic<O1>> {
		CombineFoldOptics(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: FoldOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineFoldOptics<O0, FoldLiftPrismOptic<O1>> {
		CombineFoldOptics(
			lhs: o0,
			rhs: .init(optic: o1)
		)
	}
}

//public struct ConcatFoldOptics<LHS: FoldOptic, RHS: FoldOptic>: FoldOptic
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

public struct CombineFoldOptics<LHS: FoldOptic, RHS: FoldOptic>: FoldOptic
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

