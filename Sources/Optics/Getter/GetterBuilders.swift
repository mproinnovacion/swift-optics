import Foundation

@resultBuilder
public enum GetterOpticBuilder {
	public static func buildPartialBlock<O: GetterOptic>(first optic: O) -> O {
		optic
	}
	
	public static func buildPartialBlock<R>(
		first f: @escaping () -> R
	) -> GetterFunc0<R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, R>(
		first f: @escaping (O0) -> R
	) -> GetterFunc1<O0, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0, O1, R>(
		first f: @escaping (O0, O1) -> R
	) -> GetterFunc2<O0, O1, R> {
		.init(run: f)
	}
	
	public static func buildPartialBlock<O0: GetterOptic, O1: GetterOptic>(accumulated o0: O0, next o1: O1) -> GetterCombination<O0, O1> {
		GetterCombination(lhs: o0, rhs: o1)
	}
	
//	public static func buildExpression<O: Getter>(_ expression: O) -> O {
//		expression
//	}
//	
//	public static func buildExpression<R>(
//		first f: @escaping () -> R
//	) -> GetterFunc0<R> {
//		.init(run: f)
//	}
}

public struct GetterCombination<LHS: GetterOptic, RHS: GetterOptic>: GetterOptic
where LHS.Part == RHS.Whole {
	let lhs: LHS
	let rhs: RHS
	
	public typealias Whole = LHS.Whole
	public typealias Part = RHS.Part
	
	public func get(_ whole: LHS.Whole) -> RHS.Part {
		rhs.get(lhs.get(whole))
	}
}

public struct GetterFunc0<R>: GetterOptic {
	public typealias Whole = ()
	public typealias Part = R
	
	public let run: () -> R
	
	public init(run: @escaping () -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run()
	}
}

public struct GetterFunc1<O0, R>: GetterOptic {
	public typealias Whole = O0
	public typealias Part = R
	
	public let run: (O0) -> R
	
	public init(run: @escaping (O0) -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run(whole)
	}
}

public struct GetterFunc2<O0, O1, R>: GetterOptic {
	public typealias Whole = (O0, O1)
	public typealias Part = R
	
	public let run: (O0, O1) -> R
	
	public init(run: @escaping (O0, O1) -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run(whole.0, whole.1)
	}
}
