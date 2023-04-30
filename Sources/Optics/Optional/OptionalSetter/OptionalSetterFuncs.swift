import Foundation

public struct OptionalSetterFunc0<R, NewPart>: OptionalSetterOptic {
	public typealias Whole = () -> R
	public typealias Part = R
	public typealias NewWhole = () -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{
			f(whole())
		}
	}
}

public struct OptionalSetterFunc1<Input, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input) -> R
	public typealias Part = R
	public typealias NewWhole = (Input) -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input in
			f(whole(input))
		}
	}
}

public struct OptionalSetterFunc2<Input0, Input1, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1) -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1) -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1 in
			f(whole(input0, input1))
		}
	}
}

public struct OptionalSetterFunc3<Input0, Input1, Input2, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2) -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2) -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2 in
			f(whole(input0, input1, input2))
		}
	}
}

public struct OptionalSetterFunc4<Input0, Input1, Input2, Input3, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3) -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3) -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3 in
			f(whole(input0, input1, input2, input3))
		}
	}
}

public struct OptionalSetterFunc5<Input0, Input1, Input2, Input3, Input4, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4) -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4) -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4 in
			f(whole(input0, input1, input2, input3, input4))
		}
	}
}

public struct OptionalSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, R, NewPart>: OptionalSetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4, Input5) -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4, Input5) -> NewPart
	
	public init() {
	}
	
	public func tryUpdating(
		_ whole: @escaping Whole,
		_ f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4, input5 in
			f(whole(input0, input1, input2, input3, input4, input5))
		}
	}
}
