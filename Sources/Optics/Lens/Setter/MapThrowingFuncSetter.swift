import Foundation

public struct MapThrowingSetterFunc0<S: SetterOptic, Output, NewOutput>: SetterOptic
where S.Part == (() throws -> Output), S.NewPart == (() throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{
				let output = try part()
				return f(output)
			}
		}
	}
}

public struct MapThrowingSetterFunc1<S: SetterOptic, Input, Output, NewOutput>: SetterOptic
where S.Part == ((Input) throws -> Output), S.NewPart == ((Input) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput

	let optic: S

	public init(optic: S) {
		self.optic = optic
	}

	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{ input in
				let output = try part(input)
				return f(output)
			}
		}
	}
}

public struct MapThrowingSetterFunc2<S: SetterOptic, Input0, Input1, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1) throws -> Output), S.NewPart == ((Input0, Input1) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput

	let optic: S

	public init(optic: S) {
		self.optic = optic
	}

	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1 in
				let output = try part(input0, input1)
				return f(output)
			}
		}
	}
}

public struct MapThrowingSetterFunc3<S: SetterOptic, Input0, Input1, Input2, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2) throws -> Output), S.NewPart == ((Input0, Input1, Input2) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput

	let optic: S

	public init(optic: S) {
		self.optic = optic
	}

	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2 in
				let output = try part(input0, input1, input2)
				return f(output)
			}
		}
	}
}

public struct MapThrowingSetterFunc4<S: SetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) throws -> Output), S.NewPart == ((Input0, Input1, Input2, Input3) throws -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput

	let optic: S

	public init(optic: S) {
		self.optic = optic
	}

	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2, input3 in
				let output = try part(input0, input1, input2, input3)
				return f(output)
			}
		}
	}
}

public struct MapThrowingSetterFunc5<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: SetterOptic
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

	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = try part(input0, input1, input2, input3, input4)
				return f(output)
			}
		}
	}
}

public struct MapThrowingSetterFunc6<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: SetterOptic
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

	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = try part(input0, input1, input2, input3, input4, input5)
				return f(output)
			}
		}
	}
}

extension SetterOptic {
	public func mapThrows<Output, NewOutput>() -> MapThrowingSetterFunc0<Self, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input, Output, NewOutput>() -> MapThrowingSetterFunc1<Self, Input, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapThrows<Input0, Input1, Output, NewOutput>() -> MapThrowingSetterFunc2<Self, Input0, Input1, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapThrows<Input0, Input1, Input2, Output, NewOutput>() -> MapThrowingSetterFunc3<Self, Input0, Input1, Input2, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapThrows<Input0, Input1, Input2, Input3, Output, NewOutput>() -> MapThrowingSetterFunc4<Self, Input0, Input1, Input2, Input3, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapThrows<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> MapThrowingSetterFunc5<Self, Input0, Input1, Input2, Input3, Input4, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapThrows<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> MapThrowingSetterFunc6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput> {
		.init(optic: self)
	}
}
