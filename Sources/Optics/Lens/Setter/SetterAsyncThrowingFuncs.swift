import Foundation

public struct ThrowingAsyncSetterFunc0<R, NewPart>: SetterOptic {
	public typealias Whole = () async throws -> R
	public typealias Part = R
	public typealias NewWhole = () async throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{
			try await f(whole())
		}
	}
}

public struct ThrowingAsyncSetterFunc1<Input, R, NewPart>: SetterOptic {
	public typealias Whole = (Input) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input) async throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input in
			try await f(whole(input))
		}
	}
}

public struct ThrowingAsyncSetterFunc2<Input0, Input1, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1) async throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1 in
			try await f(whole(input0, input1))
		}
	}
}

public struct ThrowingAsyncSetterFunc3<Input0, Input1, Input2, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2) async throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2 in
			try await f(whole(input0, input1, input2))
		}
	}
}

public struct ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3) async throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3 in
			try await f(whole(input0, input1, input2, input3))
		}
	}
}

public struct ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4) async throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4 in
			try await f(whole(input0, input1, input2, input3, input4))
		}
	}
}

public struct ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4, Input5) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4, Input5) async throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4, input5 in
			try await f(whole(input0, input1, input2, input3, input4, input5))
		}
	}
}
