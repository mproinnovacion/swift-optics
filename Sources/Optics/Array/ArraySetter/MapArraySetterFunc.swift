import Foundation

public struct MapArraySetter0<S: ArraySetterOptic, Output, NewOutput>: ArraySetterOptic
where S.Part == (() -> Output), S.NewPart == (() -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Output) -> NewOutput
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{
				let output = part()
				return f(output)
			}
		}
	}
}

public struct MapArraySetter1<S: ArraySetterOptic, Input, Output, NewOutput>: ArraySetterOptic
where S.Part == ((Input) -> Output), S.NewPart == ((Input) -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Output) -> NewOutput
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input in
				let output = part(input)
				return f(output)
			}
		}
	}
}

public struct MapArraySetter2<S: ArraySetterOptic, Input0, Input1, Output, NewOutput>: ArraySetterOptic
where S.Part == ((Input0, Input1) -> Output), S.NewPart == ((Input0, Input1) -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Output) -> NewOutput
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1 in
				let output = part(input0, input1)
				return f(output)
			}
		}
	}
}

public struct MapArraySetter3<S: ArraySetterOptic, Input0, Input1, Input2, Output, NewOutput>: ArraySetterOptic
where S.Part == ((Input0, Input1, Input2) -> Output), S.NewPart == ((Input0, Input1, Input2) -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Output) -> NewOutput
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1, input2 in
				let output = part(input0, input1, input2)
				return f(output)
			}
		}
	}
}

public struct MapArraySetter4<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: ArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) -> Output), S.NewPart == ((Input0, Input1, Input2, Input3) -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Output) -> NewOutput
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1, input2, input3 in
				let output = part(input0, input1, input2, input3)
				return f(output)
			}
		}
	}
}

public struct MapArraySetter5<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: ArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) -> Output), S.NewPart == ((Input0, Input1, Input2, Input3, Input4) -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Output) -> NewOutput
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = part(input0, input1, input2, input3, input4)
				return f(output)
			}
		}
	}
}

public struct MapArraySetter6<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: ArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) -> Output), S.NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) -> NewOutput) {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = NewOutput
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Output) -> NewOutput
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = part(input0, input1, input2, input3, input4, input5)
				return f(output)
			}
		}
	}
}

extension ArraySetterOptic {
	public func mapFunc<Output, NewOutput>() -> MapArraySetter0<Self, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input, Output, NewOutput>() -> MapArraySetter1<Self, Input, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Output, NewOutput>() -> MapArraySetter2<Self, Input0, Input1, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Output, NewOutput>() -> MapArraySetter3<Self, Input0, Input1, Input2, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Output, NewOutput>() -> MapArraySetter4<Self, Input0, Input1, Input2, Input3, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> MapArraySetter5<Self, Input0, Input1, Input2, Input3, Input4, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> MapArraySetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput> {
		.init(optic: self)
	}
}
