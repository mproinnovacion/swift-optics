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
	public func mapAsyncThrows<Output, NewOutput>() -> SetterCombination<MapSetter<Self, ThrowingAsyncSetterFunc0<Output, NewOutput>.Whole, ThrowingAsyncSetterFunc0<Output, NewOutput>.NewWhole>, ThrowingAsyncSetterFunc0<Output, NewOutput>>
	where Part == (() async throws -> Output), NewPart == (() async throws -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				ThrowingAsyncFunc0(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: ThrowingAsyncSetterFunc0<Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsyncThrows<Input, Output, NewOutput>() -> SetterCombination<MapSetter<Self, ThrowingAsyncSetterFunc1<Input, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc1<Input, Output, NewOutput>.NewWhole>, ThrowingAsyncSetterFunc1<Input, Output, NewOutput>>
	where Part == ((Input) async throws -> Output), NewPart == ((Input) async throws -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				ThrowingAsyncFunc1(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: ThrowingAsyncSetterFunc1<Input, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsyncThrows<Input0, Input1, Output, NewOutput>() -> SetterCombination<MapSetter<Self, ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>.NewWhole>, ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>>
	where Part == ((Input0, Input1) async throws -> Output), NewPart == ((Input0, Input1) async throws -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				ThrowingAsyncFunc2(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsyncThrows<Input0, Input1, Input2, Output, NewOutput>() -> SetterCombination<MapSetter<Self, ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.NewWhole>, ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>>
	where Part == ((Input0, Input1, Input2) async throws -> Output), NewPart == ((Input0, Input1, Input2) async throws -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				ThrowingAsyncFunc3(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Output, NewOutput>() -> SetterCombination<MapSetter<Self, ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.NewWhole>, ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>>
	where Part == ((Input0, Input1, Input2, Input3) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3) async throws -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				ThrowingAsyncFunc4(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> SetterCombination<MapSetter<Self, ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.NewWhole>, ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>>
	where Part == ((Input0, Input1, Input2, Input3, Input4) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4) async throws -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				ThrowingAsyncFunc5(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> SetterCombination<MapSetter<Self, ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.NewWhole>, ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>>
	where Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async throws -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				ThrowingAsyncFunc6(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>()
		)
		
		return result
	}
}
