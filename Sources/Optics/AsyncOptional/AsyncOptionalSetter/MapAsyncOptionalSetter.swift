import Foundation

public struct MapAsyncOptionalSetter0<S: OptionalSetterOptic, Output>: OptionalSetterOptic
where S.Part == (() async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{
				let output = await part()
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncOptionalSetter1<S: OptionalSetterOptic, Input, Output>: OptionalSetterOptic
where S.Part == ((Input) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input in
				let output = await part(input)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncOptionalSetter2<S: OptionalSetterOptic, Input0, Input1, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1 in
				let output = await part(input0, input1)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncOptionalSetter3<S: OptionalSetterOptic, Input0, Input1, Input2, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1, input2 in
				let output = await part(input0, input1, input2)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncOptionalSetter4<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1, input2, input3 in
				let output = await part(input0, input1, input2, input3)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncOptionalSetter5<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = await part(input0, input1, input2, input3, input4)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncOptionalSetter6<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func tryUpdating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.tryUpdating(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = await part(input0, input1, input2, input3, input4, input5)
				return (try? f(output)) ?? output
			}
		}
	}
}

extension OptionalSetterOptic {
	public func mapAsync<Output>() -> MapAsyncOptionalSetter0<Self, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input, Output>() -> MapAsyncOptionalSetter1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Output>() -> MapAsyncOptionalSetter2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Output>() -> MapAsyncOptionalSetter3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Output>() -> MapAsyncOptionalSetter4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output>() -> MapAsyncOptionalSetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapAsyncOptionalSetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
		.init(optic: self)
	}
}
