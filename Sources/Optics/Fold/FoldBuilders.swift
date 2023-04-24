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
