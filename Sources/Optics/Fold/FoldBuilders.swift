import Foundation

import Algebra

@resultBuilder
public enum FoldBuilder<Whole, Part> {
	public static func buildPartialBlock<O: GetterOptic<Whole, Part>>(first optic: O) -> ArrayGetterLiftOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: OptionalGetterOptic<Whole, Part>>(first optic: O) -> ArrayGetterOptionalLiftOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: ArrayGetterOptic<Whole, Part>>(first optic: O) -> O {
		optic
	}
//
//	public static func buildPartialBlock<R>(
//		first f: @escaping () -> [R]
//	) -> ArrayGetterFunc0<R> {
//		.init(run: f)
//	}
//
//	public static func buildPartialBlock<O0, R>(
//		first f: @escaping (O0) -> [R]
//	) -> ArrayGetterFunc1<O0, R> {
//		.init(run: f)
//	}
//
//	public static func buildPartialBlock<O0, O1, R>(
//		first f: @escaping (O0, O1) -> [R]
//	) -> ArrayGetterFunc2<O0, O1, R> {
//		.init(run: f)
//	}
//
//	public static func buildPartialBlock<O0, O1, O2, R>(
//		first f: @escaping (O0, O1, O2) -> [R]
//	) -> ArrayGetterFunc3<O0, O1, O2, R> {
//		.init(run: f)
//	}
//
//	public static func buildPartialBlock<O0, O1, O2, O3, R>(
//		first f: @escaping (O0, O1, O2, O3) -> [R]
//	) -> ArrayGetterFunc4<O0, O1, O2, O3, R> {
//		.init(run: f)
//	}
//
//	public static func buildPartialBlock<O0, O1, O2, O3, O4, R>(
//		first f: @escaping (O0, O1, O2, O3, O4) -> [R]
//	) -> ArrayGetterFunc5<O0, O1, O2, O3, O4, R> {
//		.init(run: f)
//	}
//
//	public static func buildPartialBlock<O0, O1, O2, O3, O4, O5, R>(
//		first f: @escaping (O0, O1, O2, O3, O4, O5) -> [R]
//	) -> ArrayGetterFunc6<O0, O1, O2, O3, O4, O5, R> {
//		.init(run: f)
//	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic, O1: GetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatArrayGetterOptics<O0, ArrayGetterLiftOptic<O1>> {
		ConcatArrayGetterOptics(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic<Whole, Part>, O1: OptionalGetterOptic<Whole, Part>>(
		accumulated o0: O0,
		next o1: O1
	) -> ConcatArrayGetterOptics<O0, ArrayGetterOptionalLiftOptic<O1>> {
		ConcatArrayGetterOptics(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ArrayGetterOptic<Whole, Part>, O1: ArrayGetterOptic<Whole, Part>>(
		accumulated o0: O0,
		next o1: O1
	) -> ConcatArrayGetterOptics<O0, O1> {
		ConcatArrayGetterOptics(lhs: o0, rhs: o1)
	}
}

//public struct ArrayGetterLiftOptic<O: GetterOptic>: ArrayGetterOptic {
//	let optic: O
//	
//	public typealias Whole = O.Whole
//	public typealias Part = O.Part
//	
//	public func getAll(_ whole: Whole) -> [Part] {
//		[optic.get(whole)]
//	}
//}
//
//public struct ArrayGetterOptionalLiftOptic<O: OptionalGetterOptic>: ArrayGetterOptic {
//	let optic: O
//	
//	public typealias Whole = O.Whole
//	public typealias Part = O.Part
//	
//	public func getAll(_ whole: Whole) -> [Part] {
//		[optic.tryGet(whole)].compactMap { $0 }
//	}
//}

public struct ConcatArrayGetterOptics<LHS: ArrayGetterOptic, RHS: ArrayGetterOptic>: ArrayGetterOptic
where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
	let lhs: LHS
	let rhs: RHS

	public init(
		lhs: LHS,
		rhs: RHS
	) {
		self.lhs = lhs
		self.rhs = rhs
	}

	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func getAll(_ whole: LHS.Whole) -> [RHS.Part] {
		lhs.getAll(whole) + rhs.getAll(whole)
	}
}


//@resultBuilder
//public enum FoldOpticBuilder<Whole, Part> {
////	public static func buildOptional<O: ArrayOptic>(
////		_ optic: O?
////	) -> FoldOpticFromOptional<O.Whole, O.Part, O.NewPart, O> {
////		FoldOpticFromOptional(optic: optic)
////	}
//	
//	public static func buildPartialBlock<O: GetterOptic<Whole, Part>>(first optic: O) -> [FoldLiftGetterOptic<O>] {
//		[.init(optic: optic)]
//	}
//	
////	public static func buildPartialBlock<O: PrismOptic>(first optic: O) -> [ArrayOptionalLiftOptic<OptionalLiftPrismOptic<O>>] {
////		.init(optic: .init(prism: optic))
////	}
////
////	public static func buildPartialBlock<O: OptionalOptic>(first optic: O) -> ArrayOptionalLiftOptic<O> {
////		.init(optic: optic)
////	}
//
//	public static func buildPartialBlock<O: FoldOptic<Whole, Part>>(first optic: O) -> [O] {
//		[optic]
//	}
//
//	public static func buildPartialBlock<O0: FoldOptic<Whole, Part>, O1: GetterOptic<Whole, Part>>(
//		accumulated o0: [O0],
//		next o1: O1
//	) ->  [any FoldOptic] { //CombineFoldOptics<O0, FoldLiftLensOptic<O1>> {
//		o0 + [FoldLiftGetterOptic(optic: o1)]
////		CombineFoldOptics(lhs: o0, rhs: .init(lens: o1))
//	}
//
//	public static func buildPartialBlock<O0: FoldOptic<Whole, Part>, O1: FoldOptic<Whole, Part>>(
//		accumulated o0: [O0], next o1: O1
//	) -> [any FoldOptic] {
//		o0 + [o1]
//	}
//	
////	public static func buildPartialBlock<O0: FoldOptic, O1: FoldOptic>(accumulated o0: O0, next o1: O1) -> CombineFoldOptics<O0, O1> {
////		CombineFoldOptics(lhs: o0, rhs: o1)
////	}
//
////	public static func buildPartialBlock<O0: FoldOptic, O1: OptionalOptic>(accumulated o0: O0, next o1: O1) -> CombineFoldOptics<O0, FoldLiftOptionalOptic<O1>> {
////		CombineFoldOptics(lhs: o0, rhs: .init(optic: o1))
////	}
////
////	public static func buildPartialBlock<O0: FoldOptic, O1: PrismOptic>(accumulated o0: O0, next o1: O1) -> CombineFoldOptics<O0, FoldLiftPrismOptic<O1>> {
////		CombineFoldOptics(
////			lhs: o0,
////			rhs: .init(optic: o1)
////		)
////	}
//}
//
////public struct ConcatFoldOptics<LHS: FoldOptic, RHS: FoldOptic>: FoldOptic
////where LHS.Whole == RHS.Whole, LHS.Part == RHS.Part {
////	let lhs: LHS
////	let rhs: RHS
////
////	public init(
////		lhs: LHS,
////		rhs: RHS
////	) {
////		self.lhs = lhs
////		self.rhs = rhs
////	}
////
////	public typealias Whole = LHS.Whole
////	public typealias Part = RHS.Part
////
////	public func reduced<Result>(
////		_ whole: LHS.Whole,
////		_ monoid: Monoid<Result>,
////		foldMap: @escaping (RHS.Part) -> Result
////	) -> Result {
////		monoid.combine(
////			lhs.reduced(whole, monoid, foldMap: foldMap),
////			rhs.reduced(whole, monoid, foldMap: foldMap)
////		)
////	}
////}
//
////public struct CombineFoldOptics<LHS: FoldOptic, RHS: FoldOptic>: FoldOptic
////where LHS.Part == RHS.Whole {
////	public let lhs: LHS
////	public let rhs: RHS
////	
////	public typealias Whole = LHS.Whole
////	public typealias Part = RHS.Part
////	
////	public init(lhs: LHS, rhs: RHS) {
////		self.lhs = lhs
////		self.rhs = rhs
////	}
////	
////	public func reduced<Result>(
////		_ whole: LHS.Whole,
////		_ monoid: Algebra.Monoid<Result>,
////		foldMap: (RHS.Part) -> Result
////	) -> Result {
////		lhs.reduced(whole, monoid) { rhsWhole in
////			rhs.reduced(rhsWhole, monoid, foldMap: foldMap)
////		}
////	}
////}
//
