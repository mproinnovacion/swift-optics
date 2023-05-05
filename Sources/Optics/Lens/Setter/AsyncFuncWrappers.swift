import Foundation

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
