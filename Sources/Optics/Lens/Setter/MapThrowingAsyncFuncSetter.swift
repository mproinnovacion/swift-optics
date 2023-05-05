import Foundation

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
