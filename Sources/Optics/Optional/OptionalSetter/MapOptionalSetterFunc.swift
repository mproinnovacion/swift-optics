import Foundation

public struct MapOptionalSetter0<S: OptionalSetterOptic, Output, NewOutput>: OptionalSetterOptic
where S.Part == (() -> Output), S.NewPart == (() -> NewOutput) {
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
				let output = part()
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetter1<S: OptionalSetterOptic, Input, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input) -> Output), S.NewPart == ((Input) -> NewOutput) {
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
				let output = part(input)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetter2<S: OptionalSetterOptic, Input0, Input1, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1) -> Output),
		S.NewPart == ((Input0, Input1) -> NewOutput) {
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
				let output = part(input0, input1)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetter3<S: OptionalSetterOptic, Input0, Input1, Input2, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2) -> Output),
		S.NewPart == ((Input0, Input1, Input2) -> NewOutput) {
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
				let output = part(input0, input1, input2)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetter4<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) -> Output),
		S.NewPart == ((Input0, Input1, Input2, Input3) -> NewOutput) {
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
				let output = part(input0, input1, input2, input3)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetter5<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) -> Output),
		S.NewPart == ((Input0, Input1, Input2, Input3, Input4) -> NewOutput) {
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
				let output = part(input0, input1, input2, input3, input4)
				return f(output)
			}
		}
	}
}

public struct MapOptionalSetter6<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) -> Output),
		S.NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) -> NewOutput) {
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
				let output = part(input0, input1, input2, input3, input4, input5)
				return f(output)
			}
		}
	}
}

extension OptionalSetterOptic {
	public func mapFunc<Output, NewOutput>() -> MapOptionalSetter0<Self, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input, Output, NewOutput>() -> MapOptionalSetter1<Self, Input, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Output, NewOutput>() -> MapOptionalSetter2<Self, Input0, Input1, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Output, NewOutput>() -> MapOptionalSetter3<Self, Input0, Input1, Input2, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Output, NewOutput>() -> MapOptionalSetter4<Self, Input0, Input1, Input2, Input3, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> MapOptionalSetter5<Self, Input0, Input1, Input2, Input3, Input4, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> MapOptionalSetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput> {
		.init(optic: self)
	}
}
