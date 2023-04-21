import Foundation

public struct MapAsyncSetter0<S: SetterOptic, Output>: SetterOptic
where S.Part == (() async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updating(whole) { part in
			{
				let output = await part()
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncSetter1<S: SetterOptic, Input, Output>: SetterOptic
where S.Part == ((Input) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updating(whole) { part in
			{ input in
				let output = await part(input)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncSetter2<S: SetterOptic, Input0, Input1, Output>: SetterOptic
where S.Part == ((Input0, Input1) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1 in
				let output = await part(input0, input1)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncSetter3<S: SetterOptic, Input0, Input1, Input2, Output>: SetterOptic
where S.Part == ((Input0, Input1, Input2) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2 in
				let output = await part(input0, input1, input2)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncSetter4<S: SetterOptic, Input0, Input1, Input2, Input3, Output>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2, input3 in
				let output = await part(input0, input1, input2, input3)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncSetter5<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = await part(input0, input1, input2, input3, input4)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapAsyncSetter6<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = await part(input0, input1, input2, input3, input4, input5)
				return (try? f(output)) ?? output
			}
		}
	}
}

extension SetterOptic {
	public func mapAsync<Output>() -> MapAsyncSetter0<Self, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input, Output>() -> MapAsyncSetter1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Output>() -> MapAsyncSetter2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Output>() -> MapAsyncSetter3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Output>() -> MapAsyncSetter4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output>() -> MapAsyncSetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
	
	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapAsyncSetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
		.init(optic: self)
	}
}
