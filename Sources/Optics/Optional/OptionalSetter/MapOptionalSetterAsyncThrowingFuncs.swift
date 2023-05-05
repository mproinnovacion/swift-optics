import Foundation

extension OptionalSetterOptic {
	public func mapAsyncThrows<Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, ThrowingAsyncSetterFunc0<Output, NewOutput>.Whole, ThrowingAsyncSetterFunc0<Output, NewOutput>.NewWhole>, LiftSetterToOptional<ThrowingAsyncSetterFunc0<Output, NewOutput>>>
	where Part == (() async throws -> Output), NewPart == (() async throws -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { f in
				ThrowingAsyncFunc0(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: ThrowingAsyncSetterFunc0<Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, ThrowingAsyncSetterFunc1<Input, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc1<Input, Output, NewOutput>.NewWhole>, LiftSetterToOptional<ThrowingAsyncSetterFunc1<Input, Output, NewOutput>>>
	where Part == ((Input) async throws -> Output), NewPart == ((Input) async throws -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { f in
				ThrowingAsyncFunc1(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: ThrowingAsyncSetterFunc1<Input, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>.NewWhole>, LiftSetterToOptional<ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>>>
	where Part == ((Input0, Input1) async throws -> Output), NewPart == ((Input0, Input1) async throws -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc2(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: ThrowingAsyncSetterFunc2<Input0, Input1, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.NewWhole>, LiftSetterToOptional<ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2) async throws -> Output), NewPart == ((Input0, Input1, Input2) async throws -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc3(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: ThrowingAsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.NewWhole>, LiftSetterToOptional<ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3) async throws -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc4(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: ThrowingAsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.NewWhole>, LiftSetterToOptional<ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3, Input4) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4) async throws -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc5(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: ThrowingAsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>())
		)

		return result
	}

	public func mapAsyncThrows<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.Whole, ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.NewWhole>, LiftSetterToOptional<ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async throws -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async throws -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				ThrowingAsyncFunc6(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: ThrowingAsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>())
		)

		return result
	}
}
