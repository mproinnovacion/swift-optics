import Foundation

public struct MapOptionalSetterThrowingFunc0<S: OptionalSetterOptic, Output, NewOutput>: OptionalSetterOptic
where S.Part == (() throws -> Output), S.NewPart == (() throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(
		_ whole: S.Whole,
		_ f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{
				let output = try part()
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetterThrowingFunc1<S: OptionalSetterOptic, Input, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input) throws -> Output), S.NewPart == ((Input) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(
		_ whole: S.Whole,
		_ f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input in
				let output = try part(input)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetterThrowingFunc2<S: OptionalSetterOptic, Input0, Input1, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1) throws -> Output),
		S.NewPart == ((Input0, Input1) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(
		_ whole: S.Whole,
		_ f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1 in
				let output = try part(input0, input1)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetterThrowingFunc3<S: OptionalSetterOptic, Input0, Input1, Input2, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2) throws -> Output),
		S.NewPart == ((Input0, Input1, Input2) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(
		_ whole: S.Whole,
		_ f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1, input2 in
				let output = try part(input0, input1, input2)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetterThrowingFunc4<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) throws -> Output),
		S.NewPart == ((Input0, Input1, Input2, Input3) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(
		_ whole: S.Whole,
		_ f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1, input2, input3 in
				let output = try part(input0, input1, input2, input3)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetterThrowingFunc5<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) throws -> Output),
		S.NewPart == ((Input0, Input1, Input2, Input3, Input4) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(
		_ whole: S.Whole,
		_ f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = try part(input0, input1, input2, input3, input4)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetterThrowingFunc6<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) throws -> Output),
		S.NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(
		_ whole: S.Whole,
		_ f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = try part(input0, input1, input2, input3, input4, input5)
				return f(output)
			}
		}
	}
}

extension OptionalSetterOptic {
	public func mapThrows<Output, NewOutput>() -> MapOptionalSetterThrowingFunc0<Self, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input, Output, NewOutput>() -> MapOptionalSetterThrowingFunc1<Self, Input, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Output, NewOutput>() -> MapOptionalSetterThrowingFunc2<Self, Input0, Input1, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Input2, Output, NewOutput>() -> MapOptionalSetterThrowingFunc3<Self, Input0, Input1, Input2, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Input2, Input3, Output, NewOutput>() -> MapOptionalSetterThrowingFunc4<Self, Input0, Input1, Input2, Input3, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> MapOptionalSetterThrowingFunc5<Self, Input0, Input1, Input2, Input3, Input4, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> MapOptionalSetterThrowingFunc6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput> {
		.init(optic: self)
	}
}
