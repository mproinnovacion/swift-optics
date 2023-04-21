import Foundation

public struct MapOptionalSetter0<S: OptionalSetterOptic, Output>: OptionalSetterOptic
where S.Part == (() -> Output), S.NewPart == S.Part {
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
				let output = part()
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapOptionalSetter1<S: OptionalSetterOptic, Input, Output>: OptionalSetterOptic
where S.Part == ((Input) -> Output), S.NewPart == S.Part {
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
				let output = part(input)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapOptionalSetter2<S: OptionalSetterOptic, Input0, Input1, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapOptionalSetter3<S: OptionalSetterOptic, Input0, Input1, Input2, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1, input2)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapOptionalSetter4<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1, input2, input3)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapOptionalSetter5<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1, input2, input3, input4)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapOptionalSetter6<S: OptionalSetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: OptionalSetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1, input2, input3, input4, input5)
				return (try? f(output)) ?? output
			}
		}
	}
}

extension OptionalSetterOptic {
	public func map<Output>() -> MapOptionalSetter0<Self, Output> {
		.init(optic: self)
	}
	
	public func map<Input, Output>() -> MapOptionalSetter1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Output>() -> MapOptionalSetter2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Output>() -> MapOptionalSetter3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Output>() -> MapOptionalSetter4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Output>() -> MapOptionalSetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapOptionalSetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
		.init(optic: self)
	}
}
