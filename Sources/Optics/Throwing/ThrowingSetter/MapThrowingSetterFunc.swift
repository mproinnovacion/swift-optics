import Foundation

public struct MapThrowingSetterFunc0<S: ThrowingSetterOptic, Output>: ThrowingSetterOptic
where S.Part == (() -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		in whole: S.Whole,
		update f: @escaping (Output) throws -> Output
	) throws -> S.NewWhole {
		try self.optic.updating(in: whole) { part in
			{
				let output = part()
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetterFunc1<S: ThrowingSetterOptic, Input, Output>: ThrowingSetterOptic
where S.Part == ((Input) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		in whole: S.Whole,
		update f: @escaping (Output) throws -> Output
	) throws -> S.NewWhole {
		try self.optic.updating(in: whole) { part in
			{ input in
				let output = part(input)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetterFunc2<S: ThrowingSetterOptic, Input0, Input1, Output>: ThrowingSetterOptic
where S.Part == ((Input0, Input1) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		in whole: S.Whole,
		update f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
			try self.optic.updating(in: whole) { part in
			{ input0, input1 in
				let output = part(input0, input1)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetterFunc3<S: ThrowingSetterOptic, Input0, Input1, Input2, Output>: ThrowingSetterOptic
where S.Part == ((Input0, Input1, Input2) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		in whole: S.Whole,
		update f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
			try self.optic.updating(in: whole) { part in
			{ input0, input1, input2 in
				let output = part(input0, input1, input2)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetterFunc4<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Output>: ThrowingSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		in whole: S.Whole,
		update f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
			try self.optic.updating(in: whole) { part in
			{ input0, input1, input2, input3 in
				let output = part(input0, input1, input2, input3)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetterFunc5<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: ThrowingSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		in whole: S.Whole,
		update f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
			try self.optic.updating(in: whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = part(input0, input1, input2, input3, input4)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetterFunc6<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: ThrowingSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updating(
		in whole: S.Whole,
		update f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
			try self.optic.updating(in: whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = part(input0, input1, input2, input3, input4, input5)
				return (try? f(output)) ?? output
			}
		}
	}
}

extension ThrowingSetterOptic {
	public func mapFunc<Output>() -> MapThrowingSetterFunc0<Self, Output> {
		.init(optic: self)
	}
	
	public func mapFunc<Input, Output>() -> MapThrowingSetterFunc1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Output>() -> MapThrowingSetterFunc2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Output>() -> MapThrowingSetterFunc3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Output>() -> MapThrowingSetterFunc4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Input4, Output>() -> MapThrowingSetterFunc5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
	
	public func mapFunc<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapThrowingSetterFunc6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
		.init(optic: self)
	}
}
