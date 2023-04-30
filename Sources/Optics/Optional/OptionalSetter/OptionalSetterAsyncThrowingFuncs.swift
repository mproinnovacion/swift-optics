import Foundation

public struct ThrowingAsyncOptionalSetterFunc0<R, NewPart>: OptionalSetterOptic {
	public typealias Whole = () async throws -> R
	public typealias Part = R
	public typealias NewWhole = () async throws -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{
			try await f(whole())
		}
	}
}

public struct ThrowingAsyncOptionalSetterFunc1<Input, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input) async throws -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input in
			try await f(whole(input))
		}
	}
}

public struct ThrowingAsyncOptionalSetterFunc2<Input0, Input1, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1) async throws -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1 in
			try await f(whole(input0, input1))
		}
	}
}

public struct ThrowingAsyncOptionalSetterFunc3<Input0, Input1, Input2, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2) async throws -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2 in
			try await f(whole(input0, input1, input2))
		}
	}
}

public struct ThrowingAsyncOptionalSetterFunc4<Input0, Input1, Input2, Input3, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3) async throws -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3 in
			try await f(whole(input0, input1, input2, input3))
		}
	}
}

public struct ThrowingAsyncOptionalSetterFunc5<Input0, Input1, Input2, Input3, Input4, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4) async throws -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4 in
			try await f(whole(input0, input1, input2, input3, input4))
		}
	}
}

public struct ThrowingAsyncOptionalSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4, Input5) async throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4, Input5) async throws -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4, input5 in
			try await f(whole(input0, input1, input2, input3, input4, input5))
		}
	}
}
