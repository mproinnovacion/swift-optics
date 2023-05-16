import Foundation

public struct ThrowingSetterFunc0<R, NewPart>: SetterOptic {
	public typealias Whole = () throws -> R
	public typealias Part = R
	public typealias NewWhole = () throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		in whole: @escaping Whole,
		update f: @escaping (R) -> NewPart
	) -> NewWhole {
		{
			try f(whole())
		}
	}
}

public struct ThrowingSetterFunc1<Input, R, NewPart>: SetterOptic {
	public typealias Whole = (Input) throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input) throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		in whole: @escaping Whole,
		update f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input in
			try f(whole(input))
		}
	}
}

public struct ThrowingSetterFunc2<Input0, Input1, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1) throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1) throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		in whole: @escaping Whole,
		update f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1 in
			try f(whole(input0, input1))
		}
	}
}

public struct ThrowingSetterFunc3<Input0, Input1, Input2, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2) throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2) throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		in whole: @escaping Whole,
		update f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2 in
			try f(whole(input0, input1, input2))
		}
	}
}

public struct ThrowingSetterFunc4<Input0, Input1, Input2, Input3, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3) throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3) throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		in whole: @escaping Whole,
		update f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3 in
			try f(whole(input0, input1, input2, input3))
		}
	}
}

public struct ThrowingSetterFunc5<Input0, Input1, Input2, Input3, Input4, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4) throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4) throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		in whole: @escaping Whole,
		update f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4 in
			try f(whole(input0, input1, input2, input3, input4))
		}
	}
}

public struct ThrowingSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, R, NewPart>: SetterOptic {
	public typealias Whole = (Input0, Input1, Input2, Input3, Input4, Input5) throws -> R
	public typealias Part = R
	public typealias NewWhole = (Input0, Input1, Input2, Input3, Input4, Input5) throws -> NewPart
	
	public init() {
	}
	
	public func updating(
		in whole: @escaping Whole,
		update f: @escaping (R) -> NewPart
	) -> NewWhole {
		{ input0, input1, input2, input3, input4, input5 in
			try f(whole(input0, input1, input2, input3, input4, input5))
		}
	}
}
