import Foundation

public struct MapSetter0<S: SetterOptic, Output>: SetterOptic
where S.Part == (() -> Output), S.NewPart == S.Part {
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
				let output = part()
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapSetter1<S: SetterOptic, Input, Output>: SetterOptic
where S.Part == ((Input) -> Output), S.NewPart == S.Part {
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
				let output = part(input)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapSetter2<S: SetterOptic, Input0, Input1, Output>: SetterOptic
where S.Part == ((Input0, Input1) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapSetter3<S: SetterOptic, Input0, Input1, Input2, Output>: SetterOptic
where S.Part == ((Input0, Input1, Input2) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1, input2)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapSetter4<S: SetterOptic, Input0, Input1, Input2, Input3, Output>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1, input2, input3)
				return (try? f(output)) ?? output
			}
		}
	}
}

public struct MapSetter5<S: SetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: SetterOptic
where S.Part == ((Input0, Input1, Input2, Input3, Input4) -> Output), S.NewPart == S.Part {
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
				let output = part(input0, input1, input2, input3, input4)
				return (try? f(output)) ?? output
			}
		}
	}
}

extension SetterOptic {
	public func map<Output>() -> MapSetter0<Self, Output> {
		.init(optic: self)
	}
	
	public func map<Input, Output>() -> MapSetter1<Self, Input, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Output>() -> MapSetter2<Self, Input0, Input1, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Output>() -> MapSetter3<Self, Input0, Input1, Input2, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Output>() -> MapSetter4<Self, Input0, Input1, Input2, Input3, Output> {
		.init(optic: self)
	}
	
	public func map<Input0, Input1, Input2, Input3, Input4, Output>() -> MapSetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
		.init(optic: self)
	}
}
