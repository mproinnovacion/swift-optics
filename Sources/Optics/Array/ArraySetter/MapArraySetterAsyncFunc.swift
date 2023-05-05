import Foundation

extension ArraySetterOptic {
	public func mapAsync<Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, AsyncSetterFunc0<Output, NewOutput>.Whole, AsyncSetterFunc0<Output, NewOutput>.NewWhole>, LiftSetterToArray<AsyncSetterFunc0<Output, NewOutput>>>
	where Part == (() async -> Output), NewPart == (() async -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { f in
				AsyncFunc0(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: AsyncSetterFunc0<Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, AsyncSetterFunc1<Input, Output, NewOutput>.Whole, AsyncSetterFunc1<Input, Output, NewOutput>.NewWhole>, LiftSetterToArray<AsyncSetterFunc1<Input, Output, NewOutput>>>
	where Part == ((Input) async -> Output), NewPart == ((Input) async -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { f in
				AsyncFunc1(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: AsyncSetterFunc1<Input, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, AsyncSetterFunc2<Input0, Input1, Output, NewOutput>.Whole, AsyncSetterFunc2<Input0, Input1, Output, NewOutput>.NewWhole>, LiftSetterToArray<AsyncSetterFunc2<Input0, Input1, Output, NewOutput>>>
	where Part == ((Input0, Input1) async -> Output), NewPart == ((Input0, Input1) async -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				AsyncFunc2(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: AsyncSetterFunc2<Input0, Input1, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.Whole, AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.NewWhole>, LiftSetterToArray<AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2) async -> Output), NewPart == ((Input0, Input1, Input2) async -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				AsyncFunc3(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.Whole, AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.NewWhole>, LiftSetterToArray<AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3) async -> Output), NewPart == ((Input0, Input1, Input2, Input3) async -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				AsyncFunc4(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.Whole, AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.NewWhole>, LiftSetterToArray<AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4) async -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				AsyncFunc5(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> ArraySetterCombination<MapArraySetter<Self, AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.Whole, AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.NewWhole>, LiftSetterToArray<AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> NewOutput) {
		let result = ArraySetterCombination(
			lhs: MapArraySetter(optic: self) { (f: Part) in
				AsyncFunc6(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToArray(optic: AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>())
		)
		
		return result
	}
}
