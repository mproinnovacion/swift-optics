import Foundation

public struct AsyncSetterFunc0<Output, NewOutput>: SetterOptic {
	public typealias Whole = AsyncFunc0<Output>
	public typealias Part = Output
	public typealias NewWhole = AsyncFunc0<NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: {
			await f(whole())
		})
	}
}

public struct AsyncSetterFunc1<Input, Output, NewOutput>: SetterOptic {
	public typealias Whole = AsyncFunc1<Input, Output>
	public typealias Part = Output
	public typealias NewWhole = AsyncFunc1<Input, NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: { input in
			await f(whole(input))
		})
	}

}

public struct AsyncSetterFunc2<Input0, Input1, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1) async -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1 in
			await f(whole(input0, input1))
		}
	}
}

public struct AsyncSetterFunc3<Input0, Input1, Input2, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2) async -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2 in
			await f(whole(input0, input1, input2))
		}
	}
}

public struct AsyncSetterFunc4<Input0, Input1, Input2, Input3, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3) async -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3 in
			await f(whole(input0, input1, input2, input3))
		}
	}
}

public struct AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4) async -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4 in
			await f(whole(input0, input1, input2, input3, input4))
		}
	}
}

public struct AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4, Input5) async -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4, Input5) async -> NewPart
	
	public init() {
	}
	
	public func updating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4, input5 in
			await f(whole(input0, input1, input2, input3, input4, input5))
		}
	}
}
