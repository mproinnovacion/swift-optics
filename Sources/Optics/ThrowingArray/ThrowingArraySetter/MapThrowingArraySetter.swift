import Foundation

public struct MapThrowingArraySetter0<S: ThrowingArraySetterOptic, Output>: ThrowingArraySetterOptic
where S.Part == (() -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output
	) throws -> S.NewWhole {
		try self.optic.updatingAll(whole) { part in
			{
				let output = part()
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingArraySetter1<S: ThrowingArraySetterOptic, Input, Output>: ThrowingArraySetterOptic
where S.Part == ((Input) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output
	) throws -> S.NewWhole {
		try self.optic.updatingAll(whole) { part in
			{ input in
				let output = part(input)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingArraySetter2<S: ThrowingArraySetterOptic, Input0, Input1, Output>: ThrowingArraySetterOptic
where S.Part == ((Input0, Input1) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updatingAll(whole) { part in
			{ input0, input1 in
				let output = part(input0, input1)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingArraySetter3<S: ThrowingArraySetterOptic, Input0, Input1, Input2, Output>: ThrowingArraySetterOptic
where S.Part == ((Input0, Input1, Input2) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updatingAll(whole) { part in
			{ input0, input1, input2 in
				let output = part(input0, input1, input2)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingArraySetter4<S: ThrowingArraySetterOptic, Input0, Input1, Input2, Input3, Output>: ThrowingArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updatingAll(whole) { part in
			{ input0, input1, input2, input3 in
				let output = part(input0, input1, input2, input3)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingArraySetter5<S: ThrowingArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: ThrowingArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updatingAll(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = part(input0, input1, input2, input3, input4)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingArraySetter6<S: ThrowingArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: ThrowingArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updatingAll(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = part(input0, input1, input2, input3, input4, input5)
				return (try? f(output)) ?? output
			}
		}
	}
}

extension ThrowingArraySetterOptic {
	public func map<Output>() -> MapThrowingArraySetter0<Self, Output> {
		.init(optic: self)
	}
	
	public func map<Input, Output>() -> MapThrowingArraySetter1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Output>() -> MapThrowingArraySetter2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Output>() -> MapThrowingArraySetter3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Output>() -> MapThrowingArraySetter4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Output>() -> MapThrowingArraySetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapThrowingArraySetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
		.init(optic: self)
	}
}
