import Foundation

public struct ThrowingAsyncFunc0<Output> {
	public let run: () async throws -> Output
	
	public init(run: @escaping () async throws -> Output) {
		self.run = run
	}
	
	func callAsFunction() async throws -> Output {
		try await self.run()
	}
}

public struct ThrowingAsyncFunc1<Input, Output> {
	public let run: (Input) async throws -> Output
	
	public init(run: @escaping (Input) async throws -> Output) {
		self.run = run
	}
	
	func callAsFunction(_ input: Input) async throws -> Output {
		try await self.run(input)
	}
}

public struct ThrowingAsyncFunc2<Input0, Input1, Output> {
	public let run: (Input0, Input1) async throws -> Output
	
	public init(run: @escaping (Input0, Input1) async throws -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1
	) async throws -> Output {
		try await self.run(input0, input1)
	}
}

public struct ThrowingAsyncFunc3<Input0, Input1, Input2, Output> {
	public let run: (Input0, Input1, Input2) async throws -> Output
	
	public init(run: @escaping (Input0, Input1, Input2) async throws -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1,
		_ input2: Input2
	) async throws -> Output {
		try await self.run(input0, input1, input2)
	}
}

public struct ThrowingAsyncFunc4<Input0, Input1, Input2, Input3, Output> {
	public let run: (Input0, Input1, Input2, Input3) async throws -> Output
	
	public init(run: @escaping (Input0, Input1, Input2, Input3) async throws -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1,
		_ input2: Input2,
		_ input3: Input3
	) async throws -> Output {
		try await self.run(input0, input1, input2, input3)
	}
}

public struct ThrowingAsyncFunc5<Input0, Input1, Input2, Input3, Input4, Output> {
	public let run: (Input0, Input1, Input2, Input3, Input4) async throws -> Output
	
	public init(run: @escaping (Input0, Input1, Input2, Input3, Input4) async throws -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1,
		_ input2: Input2,
		_ input3: Input3,
		_ input4: Input4
	) async throws -> Output {
		try await self.run(input0, input1, input2, input3, input4)
	}
}

public struct ThrowingAsyncFunc6<Input0, Input1, Input2, Input3, Input4, Input5, Output> {
	public let run: (Input0, Input1, Input2, Input3, Input4, Input5) async throws -> Output
	
	public init(run: @escaping (Input0, Input1, Input2, Input3, Input4, Input5) async throws -> Output) {
		self.run = run
	}
	
	func callAsFunction(
		_ input0: Input0,
		_ input1: Input1,
		_ input2: Input2,
		_ input3: Input3,
		_ input4: Input4,
		_ input5: Input5
	) async throws -> Output {
		try await self.run(input0, input1, input2, input3, input4, input5)
	}
}
