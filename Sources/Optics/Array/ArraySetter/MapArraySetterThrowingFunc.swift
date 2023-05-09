import Foundation

public struct MapArraySetterThrowingFunc0<S: ArraySetterOptic, Output, NewOutput>: ArraySetterOptic
where S.Part == (() throws -> Output), S.NewPart == (() throws -> NewOutput) {
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
		update f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{
				let output = try part()
				return f(output)
			}
		}
	}
}

public struct MapArraySetterThrowingFunc1<S: ArraySetterOptic, Input, Output, NewOutput>: ArraySetterOptic
where S.Part == ((Input) throws -> Output), S.NewPart == ((Input) throws -> NewOutput) {
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
		update f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input in
				let output = try part(input)
				return f(output)
			}
		}
	}
}

public struct MapArraySetterThrowingFunc2<S: ArraySetterOptic, Input0, Input1, Output, NewOutput>: ArraySetterOptic
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
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1 in
				let output = try part(input0, input1)
				return f(output)
			}
		}
	}
}

public struct MapArraySetterThrowingFunc3<S: ArraySetterOptic, Input0, Input1, Input2, Output, NewOutput>: ArraySetterOptic
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
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1, input2 in
				let output = try part(input0, input1, input2)
				return f(output)
			}
		}
	}
}

public struct MapArraySetterThrowingFunc4<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: ArraySetterOptic
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
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1, input2, input3 in
				let output = try part(input0, input1, input2, input3)
				return f(output)
			}
		}
	}
}

public struct MapArraySetterThrowingFunc5<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: ArraySetterOptic
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
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = try part(input0, input1, input2, input3, input4)
				return f(output)
			}
		}
	}
}

public struct MapArraySetterThrowingFunc6<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: ArraySetterOptic
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
	
	public func updatingAll(
		in whole: S.Whole,
		update f: @escaping (Part) -> NewPart
	) -> S.NewWhole {
		self.optic.updatingAll(in: whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = try part(input0, input1, input2, input3, input4, input5)
				return f(output)
			}
		}
	}
}

extension ArraySetterOptic {
	public func mapThrows<Output, NewOutput>() -> MapArraySetterThrowingFunc0<Self, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input, Output, NewOutput>() -> MapArraySetterThrowingFunc1<Self, Input, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Output, NewOutput>() -> MapArraySetterThrowingFunc2<Self, Input0, Input1, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Input2, Output, NewOutput>() -> MapArraySetterThrowingFunc3<Self, Input0, Input1, Input2, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Input2, Input3, Output, NewOutput>() -> MapArraySetterThrowingFunc4<Self, Input0, Input1, Input2, Input3, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> MapArraySetterThrowingFunc5<Self, Input0, Input1, Input2, Input3, Input4, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapThrows<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> MapArraySetterThrowingFunc6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput> {
		.init(optic: self)
	}
}
