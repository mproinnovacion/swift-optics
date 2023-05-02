import Foundation

public struct MapThrowingSetter0<S: ThrowingSetterOptic, Output>: ThrowingSetterOptic
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
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output
	) throws -> S.NewWhole {
		try self.optic.updating(whole) { part in
			{
				let output = part()
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetter1<S: ThrowingSetterOptic, Input, Output>: ThrowingSetterOptic
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
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output
	) throws -> S.NewWhole {
		try self.optic.updating(whole) { part in
			{ input in
				let output = part(input)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetter2<S: ThrowingSetterOptic, Input0, Input1, Output>: ThrowingSetterOptic
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
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updating(whole) { part in
			{ input0, input1 in
				let output = part(input0, input1)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetter3<S: ThrowingSetterOptic, Input0, Input1, Input2, Output>: ThrowingSetterOptic
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
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updating(whole) { part in
			{ input0, input1, input2 in
				let output = part(input0, input1, input2)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetter4<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Output>: ThrowingSetterOptic
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
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updating(whole) { part in
			{ input0, input1, input2, input3 in
				let output = part(input0, input1, input2, input3)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetter5<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: ThrowingSetterOptic
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
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = part(input0, input1, input2, input3, input4)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapThrowingSetter6<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: ThrowingSetterOptic
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
		_ whole: S.Whole,
		_ f: @escaping (Output) throws -> Output) throws -> S.NewWhole {
		try self.optic.updating(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = part(input0, input1, input2, input3, input4, input5)
				return (try? f(output)) ?? output
			}
		}
	}
}

extension ThrowingSetterOptic {
	public func map<Output>() -> MapThrowingSetter0<Self, Output> {
		.init(optic: self)
	}
	
	public func map<Input, Output>() -> MapThrowingSetter1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Output>() -> MapThrowingSetter2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Output>() -> MapThrowingSetter3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Output>() -> MapThrowingSetter4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Output>() -> MapThrowingSetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapThrowingSetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
		.init(optic: self)
	}
}
