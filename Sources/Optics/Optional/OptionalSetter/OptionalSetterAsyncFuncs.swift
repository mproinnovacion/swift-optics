import Foundation

public struct AsyncOptionalSetterFunc0<R, NewPart>: OptionalSetterOptic {
	public typealias Whole = () async -> R
	public typealias Part = R
	public typealias NewWhole = () async -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{
			await f(whole())
		}
	}
}

public struct AsyncOptionalSetterFunc1<Input, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input) async -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input in
			await f(whole(input))
		}
	}
}

public struct AsyncOptionalSetterFunc2<Input0, Input1, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1) async -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1 in
			await f(whole(input0, input1))
		}
	}
}

public struct AsyncOptionalSetterFunc3<Input0, Input1, Input2, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2) async -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2 in
			await f(whole(input0, input1, input2))
		}
	}
}

public struct AsyncOptionalSetterFunc4<Input0, Input1, Input2, Input3, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3) async -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3 in
			await f(whole(input0, input1, input2, input3))
		}
	}
}

public struct AsyncOptionalSetterFunc5<Input0, Input1, Input2, Input3, Input4, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4) async -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4 in
			await f(whole(input0, input1, input2, input3, input4))
		}
	}
}

public struct AsyncOptionalSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4, Input5) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4, Input5) async -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4, input5 in
			await f(whole(input0, input1, input2, input3, input4, input5))
		}
	}
}
