import Foundation

import Algebra

@resultBuilder
public enum FoldThrowingBuilder<Whole, Part> {
	public static func buildPartialBlock<O: GetterOptic<Whole, Part>>(first optic: O) -> ThrowingArrayGetterLiftArrayOptic<ArrayGetterLiftOptic<O>> {
		.init(
			optic: .init(optic: optic)
		)
	}
	
	public static func buildPartialBlock<O: OptionalGetterOptic<Whole, Part>>(first optic: O) -> ThrowingArrayGetterLiftArrayOptic<ArrayGetterOptionalLiftOptic<O>> {
		.init(
			optic: .init(optic: optic)
		)
	}
	
	public static func buildPartialBlock<O: ArrayGetterOptic<Whole, Part>>(first optic: O) -> ThrowingArrayGetterLiftOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: ThrowingGetterOptic<Whole, Part>>(first optic: O) -> ThrowingArrayGetterLiftOptic<O> {
		.init(optic: optic)
	}
	
	public static func buildPartialBlock<O: ThrowingArrayGetterOptic<Whole, Part>>(first optic: O) -> O {
		optic
	}

	public static func buildPartialBlock<O0: ThrowingArrayGetterOptic, O1: ThrowingGetterOptic>(accumulated o0: O0, next o1: O1) -> ConcatThrowingArrayGetterOptics<O0, ThrowingArrayGetterLiftOptic<O1>> {
		ConcatThrowingArrayGetterOptics(lhs: o0, rhs: .init(optic: o1))
	}
	
	public static func buildPartialBlock<O0: ThrowingArrayGetterOptic<Whole, Part>, O1: ThrowingArrayGetterOptic<Whole, Part>>(
		accumulated o0: O0,
		next o1: O1
	) -> ConcatThrowingArrayGetterOptics<O0, O1> {
		ConcatThrowingArrayGetterOptics(lhs: o0, rhs: o1)
	}
}


public struct ConcatThrowingArrayGetterOptics<LHS: ThrowingArrayGetterOptic, RHS: ThrowingArrayGetterOptic>: ThrowingArrayGetterOptic
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
	
	public func getAll(_ whole: LHS.Whole) throws -> [RHS.Part] {
		let left = try lhs.getAll(whole)
		let right = try rhs.getAll(whole)
		return left + right
	}
}
