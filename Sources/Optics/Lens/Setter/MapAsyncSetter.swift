import Foundation

//public typealias AsyncFunc0<Output> = (() async -> Output)

public struct AsyncFunc0<Output> {
	public let run: () async -> Output
	
	public init(run: @escaping () async -> Output) {
		self.run = run
	}
	
	func callAsFunction() async -> Output {
		await self.run()
	}
}

public struct AsyncFunc1<Input, Output> {
	public let run: (Input) async -> Output
	
	public init(run: @escaping (Input) async -> Output) {
		self.run = run
	}
	
	func callAsFunction(_ input: Input) async -> Output {
		await self.run(input)
	}
}

public struct AsyncFunc2<Input0, Input1, Output> {
	public let run: (Input0, Input1) async -> Output
	
	public init(run: @escaping (Input0, Input1) async -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1
	) async -> Output {
		await self.run(input0, input1)
	}
}

public struct AsyncFunc3<Input0, Input1, Input2, Output> {
	public let run: (Input0, Input1, Input2) async -> Output
	
	public init(run: @escaping (Input0, Input1, Input2) async -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1,
		_ input2: Input2
	) async -> Output {
		await self.run(input0, input1, input2)
	}
}

public struct AsyncFunc4<Input0, Input1, Input2, Input3, Output> {
	public let run: (Input0, Input1, Input2, Input3) async -> Output
	
	public init(run: @escaping (Input0, Input1, Input2, Input3) async -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1,
		_ input2: Input2,
		_ input3: Input3
	) async -> Output {
		await self.run(input0, input1, input2, input3)
	}
}

public struct AsyncFunc5<Input0, Input1, Input2, Input3, Input4, Output> {
	public let run: (Input0, Input1, Input2, Input3, Input4) async -> Output
	
	public init(run: @escaping (Input0, Input1, Input2, Input3, Input4) async -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1,
		_ input2: Input2,
		_ input3: Input3,
		_ input4: Input4
	) async -> Output {
		await self.run(input0, input1, input2, input3, input4)
	}
}

public struct AsyncFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output> {
	public let run: (Input0, Input1, Input2, Input3, Input4, Input5) async -> Output
	
	public init(run: @escaping (Input0, Input1, Input2, Input3, Input4, Input5) async -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1,
		_ input2: Input2,
		_ input3: Input3,
		_ input4: Input4,
		_ input5: Input5
	) async -> Output {
		await self.run(input0, input1, input2, input3, input4, input5)
	}
}


//public struct MapAsyncSetter0<S: SetterOptic, Output, NewOutput>: SetterOptic
//where S.Part == (() async -> Output), S.NewPart == (() async -> NewOutput) {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = NewOutput
//
//	let optic: S
//
//	public init(optic: S) {
//		self.optic = optic
//	}
//
//	public func updating(
//		_ whole: Whole,
//		_ f: @escaping (Part) -> NewPart
//	) -> NewWhole {
//		self.optic.updating(whole) { (part: S.Part) -> S.NewPart in
//			{
//				let output = await part()
//				return f(output)
//			}
//		}
//	}
//}
//
//public struct MapAsyncSetter1<S: SetterOptic, Input, Output, NewOutput>: SetterOptic
//where S.Part == ((Input) async -> Output), S.NewPart == ((Input) async -> NewOutput) {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = NewOutput
//
//	let optic: S
//
//	public init(optic: S) {
//		self.optic = optic
//	}
//
//	public func updating(
//		_ whole: Whole,
//		_ f: @escaping (Part) -> NewPart
//	) -> NewWhole {
//		self.optic.updating(whole) { part in
//			{ input in
//				let output = await part(input)
//				return f(output)
//			}
//		}
//	}
//}
//
//public struct MapAsyncSetter2<S: SetterOptic, Input0, Input1, Output, NewOutput>: SetterOptic
//where S.Part == ((Input0, Input1) async -> Output), S.NewPart == ((Input0, Input1) async -> NewOutput) {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = NewOutput
//
//	let optic: S
//
//	public init(optic: S) {
//		self.optic = optic
//	}
//
//	public func updating(
//		_ whole: Whole,
//		_ f: @escaping (Part) -> NewPart
//	) -> NewWhole {
//		self.optic.updating(whole) { part in
//			{ input0, input1 in
//				let output = await part(input0, input1)
//				return f(output)
//			}
//		}
//	}
//}
//
//public struct MapAsyncSetter3<S: SetterOptic, Input0, Input1, Input2, Output, NewOutput>: SetterOptic
//where S.Part == ((Input0, Input1, Input2) async -> Output), S.NewPart == ((Input0, Input1, Input2) async -> NewOutput) {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = NewOutput
//
//	let optic: S
//
//	public init(optic: S) {
//		self.optic = optic
//	}
//
//	public func updating(
//		_ whole: Whole,
//		_ f: @escaping (Part) -> NewPart
//	) -> NewWhole {
//		self.optic.updating(whole) { part in
//			{ input0, input1, input2 in
//				let output = await part(input0, input1, input2)
//				return f(output)
//			}
//		}
//	}
//}
//
//public struct MapAsyncSetter4<S: SetterOptic, Input0, Input1, Input2, Input3, Output, NewOutput>: SetterOptic
//where S.Part == ((Input0, Input1, Input2, Input3) async -> Output), S.NewPart == ((Input0, Input1, Input2, Input3) async -> NewOutput) {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = NewOutput
//
//	let optic: S
//
//	public init(optic: S) {
//		self.optic = optic
//	}
//
//	public func updating(
//		_ whole: Whole,
//		_ f: @escaping (Part) -> NewPart
//	) -> NewWhole {
//		self.optic.updating(whole) { part in
//			{ input0, input1, input2, input3 in
//				let output = await part(input0, input1, input2, input3)
//				return f(output)
//			}
//		}
//	}
//}
//
//public struct MapAsyncSetter5<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Output, NewOutput>: SetterOptic
//where S.Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), S.NewPart == ((Input0, Input1, Input2, Input3, Input4) async -> NewOutput) {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = NewOutput
//
//	let optic: S
//
//	public init(optic: S) {
//		self.optic = optic
//	}
//
//	public func updating(
//		_ whole: Whole,
//		_ f: @escaping (Part) -> NewPart
//	) -> NewWhole {
//		self.optic.updating(whole) { part in
//			{ input0, input1, input2, input3, input4 in
//				let output = await part(input0, input1, input2, input3, input4)
//				return f(output)
//			}
//		}
//	}
//}
//
//public struct MapAsyncSetter6<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output, NewOutput>: SetterOptic
//where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), S.NewPart == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> NewOutput) {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = NewOutput
//
//	let optic: S
//
//	public init(optic: S) {
//		self.optic = optic
//	}
//
//	public func updating(
//		_ whole: Whole,
//		_ f: @escaping (Part) -> NewPart
//	) -> NewWhole {
//		self.optic.updating(whole) { part in
//			{ input0, input1, input2, input3, input4, input5 in
//				let output = await part(input0, input1, input2, input3, input4, input5)
//				return f(output)
//			}
//		}
//	}
//}
//
public typealias AsyncFunc0Alias<Output> = () async -> Output

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
