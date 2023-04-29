import Foundation

public struct AsyncSetterMapAsync0<S: AsyncSetterOptic, Output>: AsyncSetterOptic
where S.Part == (() async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		_ whole: S.Whole,
		_ f: @escaping (Output) async throws -> Output
	) async rethrows -> S.NewWhole {
		await self.optic.updating(whole) { part in
			{
				let output = await part()
				return (try? await f(output)) ?? output
			}
		}
	}
}

public struct AsyncSetterMapAsync1<S: AsyncSetterOptic, Input, Output>: AsyncSetterOptic
where S.Part == ((Input) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		_ whole: S.Whole,
		_ f: @escaping (Output) async throws -> Output
	) async rethrows -> S.NewWhole {
		await self.optic.updating(whole) { part in
			{ input in
				let output = await part(input)
				return (try? await f(output)) ?? output
			}
		}
	}
}

public struct AsyncSetterMapAsync2<S: AsyncSetterOptic, Input0, Input1, Output>: AsyncSetterOptic
where S.Part == ((Input0, Input1) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		_ whole: S.Whole,
		_ f: @escaping (Output) async throws -> Output
	) async rethrows -> S.NewWhole {
		await self.optic.updating(whole) { part in
			{ input0, input1 in
				let output = await part(input0, input1)
				return (try? await f(output)) ?? output
			}
		}
	}
}

public struct AsyncSetterMapAsync3<S: AsyncSetterOptic, Input0, Input1, Input2, Output>: AsyncSetterOptic
where S.Part == ((Input0, Input1, Input2) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		_ whole: S.Whole,
		_ f: @escaping (Output) async throws -> Output
	) async rethrows -> S.NewWhole {
		await self.optic.updating(whole) { part in
			{ input0, input1, input2 in
				let output = await part(input0, input1, input2)
				return (try? await f(output)) ?? output
			}
		}
	}
}

public struct AsyncSetterMapAsync4<S: AsyncSetterOptic, Input0, Input1, Input2, Input3, Output>: AsyncSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		_ whole: S.Whole,
		_ f: @escaping (Output) async throws -> Output
	) async rethrows -> S.NewWhole {
		await self.optic.updating(whole) { part in
			{ input0, input1, input2, input3 in
				let output = await part(input0, input1, input2, input3)
				return (try? await f(output)) ?? output
			}
		}
	}
}

public struct AsyncSetterMapAsync5<S: AsyncSetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: AsyncSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		_ whole: S.Whole,
		_ f: @escaping (Output) async throws -> Output
	) async rethrows -> S.NewWhole {
		await self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = await part(input0, input1, input2, input3, input4)
				return (try? await f(output)) ?? output
			}
		}
	}
}

public struct AsyncSetterMapAsync6<S: AsyncSetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: AsyncSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		_ whole: S.Whole,
		_ f: @escaping (Output) async throws -> Output
	) async rethrows -> S.NewWhole {
		await self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = await part(input0, input1, input2, input3, input4, input5)
				return (try? await f(output)) ?? output
			}
		}
	}
}

extension AsyncSetterOptic {
	public func mapAsync<Output>() -> AsyncSetterMapAsync0<Self, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input, Output>() -> AsyncSetterMapAsync1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Output>() -> AsyncSetterMapAsync2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Output>() -> AsyncSetterMapAsync3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Output>() -> AsyncSetterMapAsync4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output>() -> AsyncSetterMapAsync5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> AsyncSetterMapAsync6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
		.init(optic: self)
	}
}
