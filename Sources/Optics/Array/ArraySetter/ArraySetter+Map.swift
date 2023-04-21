import Foundation

public struct MapArraySetter0<S: ArraySetterOptic, Output>: ArraySetterOptic
where S.Part == (() -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updatingAll(whole) { part in
			{
				let output = part()
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapArraySetter1<S: ArraySetterOptic, Input, Output>: ArraySetterOptic
where S.Part == ((Input) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updatingAll(whole) { part in
			{ input in
				let output = part(input)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapArraySetter2<S: ArraySetterOptic, Input0, Input1, Output>: ArraySetterOptic
where S.Part == ((Input0, Input1) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updatingAll(whole) { part in
			{ input0, input1 in
				let output = part(input0, input1)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapArraySetter3<S: ArraySetterOptic, Input0, Input1, Input2, Output>: ArraySetterOptic
where S.Part == ((Input0, Input1, Input2) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updatingAll(whole) { part in
			{ input0, input1, input2 in
				let output = part(input0, input1, input2)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapArraySetter4<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Output>: ArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updatingAll(whole) { part in
			{ input0, input1, input2, input3 in
				let output = part(input0, input1, input2, input3)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapArraySetter5<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: ArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updatingAll(whole) { part in
			{ input0, input1, input2, input3, input4 in
				let output = part(input0, input1, input2, input3, input4)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapArraySetter6<S: ArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: ArraySetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) -> Output), S.NewPart == S.Part {
	public typealias Whole = S.Whole
	public typealias NewWhole = S.NewWhole
	public typealias Part = Output
	public typealias NewPart = Output
	
	let optic: S
	
	public init(optic: S) {
		self.optic = optic
	}
	
	public func updatingAll(_ whole: S.Whole, _ f: @escaping (Output) throws -> Output) rethrows -> S.NewWhole {
		self.optic.updatingAll(whole) { part in
			{ input0, input1, input2, input3, input4, input5 in
				let output = part(input0, input1, input2, input3, input4, input5)
				return (try? f(output)) ?? output
			}
		}
	}
}

extension ArraySetterOptic {
	public func map<Output>() -> MapArraySetter0<Self, Output> {
		.init(optic: self)
	}
	
	public func map<Input, Output>() -> MapArraySetter1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Output>() -> MapArraySetter2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Output>() -> MapArraySetter3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Output>() -> MapArraySetter4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Output>() -> MapArraySetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapArraySetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
		.init(optic: self)
	}
}
