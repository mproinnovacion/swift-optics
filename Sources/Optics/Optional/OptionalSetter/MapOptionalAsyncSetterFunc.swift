import Foundation

extension OptionalSetterOptic {
	public func mapAsync<Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, AsyncSetterFunc0<Output, NewOutput>.Whole, AsyncSetterFunc0<Output, NewOutput>.NewWhole>, LiftSetterToOptional<AsyncSetterFunc0<Output, NewOutput>>>
	where Part == (() async -> Output), NewPart == (() async -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { f in
				AsyncFunc0(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: AsyncSetterFunc0<Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, AsyncSetterFunc1<Input, Output, NewOutput>.Whole, AsyncSetterFunc1<Input, Output, NewOutput>.NewWhole>, LiftSetterToOptional<AsyncSetterFunc1<Input, Output, NewOutput>>>
	where Part == ((Input) async -> Output), NewPart == ((Input) async -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { f in
				AsyncFunc1(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: AsyncSetterFunc1<Input, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, AsyncSetterFunc2<Input0, Input1, Output, NewOutput>.Whole, AsyncSetterFunc2<Input0, Input1, Output, NewOutput>.NewWhole>, LiftSetterToOptional<AsyncSetterFunc2<Input0, Input1, Output, NewOutput>>>
	where Part == ((Input0, Input1) async -> Output), NewPart == ((Input0, Input1) async -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				AsyncFunc2(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: AsyncSetterFunc2<Input0, Input1, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.Whole, AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>.NewWhole>, LiftSetterToOptional<AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2) async -> Output), NewPart == ((Input0, Input1, Input2) async -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				AsyncFunc3(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: AsyncSetterFunc3<Input0, Input1, Input2, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.Whole, AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>.NewWhole>, LiftSetterToOptional<AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3) async -> Output), NewPart == ((Input0, Input1, Input2, Input3) async -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				AsyncFunc4(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: AsyncSetterFunc4<Input0, Input1, Input2, Input3, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.Whole, AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>.NewWhole>, LiftSetterToOptional<AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4) async -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				AsyncFunc5(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: AsyncSetterFunc5<Input0, Input1, Input2, Input3, Input4, Output, NewOutput>())
		)
		
		return result
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>() -> OptionalSetterCombination<MapOptionalSetter<Self, AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.Whole, AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>.NewWhole>, LiftSetterToOptional<AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>>>
	where Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> NewOutput) {
		let result = OptionalSetterCombination(
			lhs: MapOptionalSetter(optic: self) { (f: Part) in
				AsyncFunc6(run: f)
			} to: { _, wrapped in
				wrapped.run
			},
			rhs: LiftSetterToOptional(optic: AsyncSetterFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>())
		)
		
		return result
	}
}
