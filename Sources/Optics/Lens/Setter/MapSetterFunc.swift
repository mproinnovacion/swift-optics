import Foundation

public struct MapSetterFunc0<S: SetterOptic, Output, NewOutput>: SetterOptic
where S.Part == (() -> Output), S.NewPart == (() -> NewOutput) {
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
				let output = part()
				return f(output)
			}
		}
	}
}

public struct MapSetterFunc1<S: SetterOptic, Input, Output, NewOutput>: SetterOptic
where S.Part == ((Input) -> Output), S.NewPart == ((Input) -> NewOutput) {
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
				let output = part(input)
				return f(output)
			}
		}
	}
}

public struct MapSetterFunc2<S: SetterOptic, Input0, Input1, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1) -> Output), S.NewPart == ((Input0, Input1) -> NewOutput) {
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
				let output = part(input0, input1)
				return f(output)
			}
		}
	}
}

public struct MapSetterFunc3<S: SetterOptic, Input0, Input1, Input2, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2) -> Output), S.NewPart == ((Input0, Input1, Input2) -> NewOutput) {
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
				let output = part(input0, input1, input2)
				return f(output)
			}
		}
	}
}

public struct MapSetterFunc4<S: SetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) -> Output), S.NewPart == ((Input0, Input1, Input2, Input3) -> NewOutput) {
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
				let output = part(input0, input1, input2, input3)
				return f(output)
			}
		}
	}
}

public struct MapSetterFunc5<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: SetterOptic
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
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = part(input0, input1, input2, input3, input4)
				return f(output)
			}
		}
	}
}

public struct MapSetterFunc6<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: SetterOptic
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
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = part(input0, input1, input2, input3, input4, input5)
				return f(output)
			}
		}
	}
}

extension SetterOptic {
	public func mapFunc<Output, NewOutput>() -> MapSetterFunc0<Self, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input, Output, NewOutput>() -> MapSetterFunc1<Self, Input, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Output, NewOutput>() -> MapSetterFunc2<Self, Input0, Input1, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Output, NewOutput>() -> MapSetterFunc3<Self, Input0, Input1, Input2, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Output, NewOutput>() -> MapSetterFunc4<Self, Input0, Input1, Input2, Input3, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> MapSetterFunc5<Self, Input0, Input1, Input2, Input3, Input4, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> MapSetterFunc6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput> {
		.init(optic: self)
	}
}
