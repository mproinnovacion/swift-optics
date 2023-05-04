import Foundation

extension SetterOptic {
	public func mapAsync<Output, NewOutput>() -> SetterCombination<MapSetter<Self, AsyncSetterFunc0<Output, NewOutput>.Whole, AsyncSetterFunc0<Output, NewOutput>.NewWhole>, AsyncSetterFunc0<Output, NewOutput>>
	where Part == (() async -> Output), NewPart == (() async -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				AsyncFunc0(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: AsyncSetterFunc0<Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsync<Input, Output, NewOutput>() -> SetterCombination<MapSetter<Self, AsyncSetterFunc1<Input, Output, NewOutput>.Whole, AsyncSetterFunc1<Input, Output, NewOutput>.NewWhole>, AsyncSetterFunc1<Input, Output, NewOutput>>
	where Part == ((Input) async -> Output), NewPart == ((Input) async -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { f in
				AsyncFunc1(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: AsyncSetterFunc1<Input, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Output, NewOutput>() -> SetterCombination<MapSetter<Self, AsyncSetterFunc2<Input0, Input1, Output, NewOutput>.Whole, AsyncSetterFunc2<Input0, Input1, Output, NewOutput>.NewWhole>, AsyncSetterFunc2<Input0, Input1, Output, NewOutput>>
	where Part == ((Input0, Input1) async -> Output), NewPart == ((Input0, Input1) async -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { (f: Part) in
				AsyncFunc2(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: AsyncSetterFunc2<Input0, Input1, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Output, NewOutput>() -> SetterCombination<MapSetter<Self, AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.Whole, AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.NewWhole>, AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>>
	where Part == ((Input0, Input1, Input2) async -> Output), NewPart == ((Input0, Input1, Input2) async -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { (f: Part) in
				AsyncFunc3(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Output, NewOutput>() -> SetterCombination<MapSetter<Self, AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.Whole, AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.NewWhole>, AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>>
	where Part == ((Input0, Input1, Input2, Input3) async -> Output), NewPart == ((Input0, Input1, Input2, Input3) async -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { (f: Part) in
				AsyncFunc4(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> SetterCombination<MapSetter<Self, AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.Whole, AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.NewWhole>, AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>>
	where Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4) async -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { (f: Part) in
				AsyncFunc5(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>()
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> SetterCombination<MapSetter<Self, AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.Whole, AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.NewWhole>, AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>>
	where Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> NewOutput) {
		let result = SetterCombination(
			lhs: MapSetter(optic: self) { (f: Part) in
				AsyncFunc6(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>()
		)
		
		return result
	}
}
