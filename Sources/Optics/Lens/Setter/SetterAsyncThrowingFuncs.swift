import Foundation

public struct ThrowingAsyncSetterFunc0<Output, NewOutput>: SetterOptic {
	public typealias Whole = ThrowingAsyncFunc0<Output>
	public typealias Part = Output
	public typealias NewWhole = ThrowingAsyncFunc0<NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: {
			try await f(whole())
		})
	}
}

public struct ThrowingAsyncSetterFunc1<Input, Output, NewOutput>: SetterOptic {
	public typealias Whole = ThrowingAsyncFunc1<Input, Output>
	public typealias Part = Output
	public typealias NewWhole = ThrowingAsyncFunc1<Input, NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: { input in
			try await f(whole(input))
		})
	}
}

public struct ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>: SetterOptic {
	public typealias Whole = ThrowingAsyncFunc2<Input0, Input1, Output>
	public typealias Part = Output
	public typealias NewWhole = ThrowingAsyncFunc2<Input0, Input1, NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: { input0, input1 in
			try await f(whole(input0, input1))
		})
	}
}

public struct ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>: SetterOptic {
	public typealias Whole = ThrowingAsyncFunc3<Input0, Input1, Input2, Output>
	public typealias Part = Output
	public typealias NewWhole = ThrowingAsyncFunc3<Input0, Input1, Input2, NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: { input0, input1, input2 in
			try await f(whole(input0, input1, input2))
		})
	}
}

public struct ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>: SetterOptic {
	public typealias Whole = ThrowingAsyncFunc4<Input0, Input1, Input2, Input3, Output>
	public typealias Part = Output
	public typealias NewWhole = ThrowingAsyncFunc4<Input0, Input1, Input2, Input3, NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: { input0, input1, input2, input3 in
			try await f(whole(input0, input1, input2, input3))
		})
	}
}

public struct ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: SetterOptic {
	public typealias Whole = ThrowingAsyncFunc5<Input0, Input1, Input2, Input3, Input4, Output>
	public typealias Part = Output
	public typealias NewWhole = ThrowingAsyncFunc5<Input0, Input1, Input2, Input3, Input4, NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: { input0, input1, input2, input3, input4 in
			try await f(whole(input0, input1, input2, input3, input4))
		})
	}
}

public struct ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: SetterOptic {
	public typealias Whole = ThrowingAsyncFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output>
	public typealias Part = Output
	public typealias NewWhole = ThrowingAsyncFunc6<Input0, Input1, Input2, Input3, Input4, Input5, NewOutput>
	public typealias NewPart = NewOutput
	
	public init() {
	}
	
	public func updating(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		.init(run: { input0, input1, input2, input3, input4, input5 in
			try await f(whole(input0, input1, input2, input3, input4, input5))
		})
	}
}
