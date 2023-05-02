import Foundation

public struct MapAsyncSetter0<S: SetterOptic, Output, NewOutput>: SetterOptic
where S.Part == (() async -> Output), S.NewPart == (() async -> NewOutput) {
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
				let output = await part()
				return f(output)
			}
		}
	}
}

public struct MapAsyncSetter1<S: SetterOptic, Input, Output, NewOutput>: SetterOptic
where S.Part == ((Input) async -> Output), S.NewPart == ((Input) async -> NewOutput) {
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
				let output = await part(input)
				return f(output)
			}
		}
	}
}

public struct MapAsyncSetter2<S: SetterOptic, Input0, Input1, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1) async -> Output), S.NewPart == ((Input0, Input1) async -> NewOutput) {
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
				let output = await part(input0, input1)
				return f(output)
			}
		}
	}
}

public struct MapAsyncSetter3<S: SetterOptic, Input0, Input1, Input2, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2) async -> Output), S.NewPart == ((Input0, Input1, Input2) async -> NewOutput) {
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
				let output = await part(input0, input1, input2)
				return f(output)
			}
		}
	}
}

public struct MapAsyncSetter4<S: SetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) async -> Output), S.NewPart == ((Input0, Input1, Input2, Input3) async -> NewOutput) {
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
				let output = await part(input0, input1, input2, input3)
				return f(output)
			}
		}
	}
}

public struct MapAsyncSetter5<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), S.NewPart == ((Input0, Input1, Input2, Input3, Input4) async -> NewOutput) {
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
				let output = await part(input0, input1, input2, input3, input4)
				return f(output)
			}
		}
	}
}

public struct MapAsyncSetter6<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), S.NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> NewOutput) {
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
				let output = await part(input0, input1, input2, input3, input4, input5)
				return f(output)
			}
		}
	}
}

extension SetterOptic {
	public func mapAsync<Output, NewOutput>() -> MapAsyncSetter0<Self, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapAsync<Input, Output, NewOutput>() -> MapAsyncSetter1<Self, Input, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Output, NewOutput>() -> MapAsyncSetter2<Self, Input0, Input1, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Output, NewOutput>() -> MapAsyncSetter3<Self, Input0, Input1, Input2, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Output, NewOutput>() -> MapAsyncSetter4<Self, Input0, Input1, Input2, Input3, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> MapAsyncSetter5<Self, Input0, Input1, Input2, Input3, Input4, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> MapAsyncSetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput> {
		.init(optic: self)
	}
}
