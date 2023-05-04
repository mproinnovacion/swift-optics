import Foundation

public struct MapThrowingAsyncSetterFunc0<S: SetterOptic, Output, NewOutput>: SetterOptic
where S.Part == (() async throws -> Output), S.NewPart == (() async throws -> NewOutput) {
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
				let output = try await part()
				return f(output)
			}
		}
	}
}

public struct MapThrowingAsyncSetterFunc1<S: SetterOptic, Input, Output, NewOutput>: SetterOptic
where S.Part == ((Input) async throws -> Output), S.NewPart == ((Input) async throws -> NewOutput) {
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
				let output = try await part(input)
				return f(output)
			}
		}
	}
}

public struct MapThrowingAsyncSetterFunc2<S: SetterOptic, Input0, Input1, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1) async throws -> Output), S.NewPart == ((Input0, Input1) async throws -> NewOutput) {
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
				let output = try await part(input0, input1)
				return f(output)
			}
		}
	}
}

public struct MapThrowingAsyncSetterFunc3<S: SetterOptic, Input0, Input1, Input2, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2) async throws -> Output), S.NewPart == ((Input0, Input1, Input2) async throws -> NewOutput) {
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
				let output = try await part(input0, input1, input2)
				return f(output)
			}
		}
	}
}

public struct MapThrowingAsyncSetterFunc4<S: SetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) async throws -> Output), S.NewPart == ((Input0, Input1, Input2, Input3) async throws -> NewOutput) {
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
				let output = try await part(input0, input1, input2, input3)
				return f(output)
			}
		}
	}
}

public struct MapThrowingAsyncSetterFunc5<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) async throws -> Output),
		S.NewPart == ((Input0, Input1, Input2, Input3, Input4) async throws -> NewOutput) {
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
				let output = try await part(input0, input1, input2, input3, input4)
				return f(output)
			}
		}
	}
}

public struct MapThrowingAsyncSetterFunc6<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async throws -> Output),
		S.NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async throws -> NewOutput) {
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
				let output = try await part(input0, input1, input2, input3, input4, input5)
				return f(output)
			}
		}
	}
}

extension SetterOptic {
	public func mapAsyncThrows<Output, NewOutput>() -> MapThrowingAsyncSetterFunc0<Self, Output, NewOutput> {
		.init(optic: self)
	}
	
	public func mapAsyncThrows<Input, Output, NewOutput>() -> MapThrowingAsyncSetterFunc1<Self, Input, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapAsyncThrows<Input0, Input1, Output, NewOutput>() -> MapThrowingAsyncSetterFunc2<Self, Input0, Input1, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Output, NewOutput>() -> MapThrowingAsyncSetterFunc3<Self, Input0, Input1, Input2, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Output, NewOutput>() -> MapThrowingAsyncSetterFunc4<Self, Input0, Input1, Input2, Input3, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> MapThrowingAsyncSetterFunc5<Self, Input0, Input1, Input2, Input3, Input4, Output, NewOutput> {
		.init(optic: self)
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> MapThrowingAsyncSetterFunc6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput> {
		.init(optic: self)
	}
}
