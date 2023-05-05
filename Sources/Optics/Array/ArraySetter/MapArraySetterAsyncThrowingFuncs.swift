import Foundation

extension ArraySetterOptic {
	public func mapAsyncThrows<Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, ThrowingAsyncSetterFunc0<Output, NewOutput>.Whole, ThrowingAsyncSetterFunc0<Output, NewOutput>.NewWhole>, LiftSetterToArray<ThrowingAsyncSetterFunc0<Output, NewOutput>>>
	where Part == (() async throws -> Output), NewPart == (() async throws -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { f in
				ThrowingAsyncFunc0(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: ThrowingAsyncSetterFunc0<Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, ThrowingAsyncSetterFunc1<Input, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc1<Input, Output, NewOutput>.NewWhole>, LiftSetterToArray<ThrowingAsyncSetterFunc1<Input, Output, NewOutput>>>
	where Part == ((Input) async throws -> Output), NewPart == ((Input) async throws -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { f in
				ThrowingAsyncFunc1(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: ThrowingAsyncSetterFunc1<Input, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>.NewWhole>, LiftSetterToArray<ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>>>
	where Part == ((Input0, Input1) async throws -> Output), NewPart == ((Input0, Input1) async throws -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc2(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.NewWhole>, LiftSetterToArray<ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2) async throws -> Output), NewPart == ((Input0, Input1, Input2) async throws -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc3(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.NewWhole>, LiftSetterToArray<ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3) async throws -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc4(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.NewWhole>, LiftSetterToArray<ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3, Input4) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4) async throws -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc5(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.NewWhole>, LiftSetterToArray<ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async throws -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc6(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>())
		)

		return result
	}
}
