//import Foundation
//
//public struct MapAsyncThrowingSetter0<S: ThrowingSetterOptic, Output>: ThrowingSetterOptic
//where S.Part == AsyncFunc0<Output>, S.NewPart == S.Part {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = Output
//	
//	let optic: S
//	
//	public init(optic: S) {
//		self.optic = optic
//	}
//	
//	public func updating(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updating(whole) { part in
//			{
//				let output = await part()
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingSetter1<S: ThrowingSetterOptic, Input, Output>: ThrowingSetterOptic
//where S.Part == ((Input) async -> Output), S.NewPart == S.Part {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = Output
//	
//	let optic: S
//	
//	public init(optic: S) {
//		self.optic = optic
//	}
//	
//	public func updating(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updating(whole) { part in
//			{ input in
//				let output = await part(input)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingSetter2<S: ThrowingSetterOptic, Input0, Input1, Output>: ThrowingSetterOptic
//where S.Part == ((Input0, Input1) async -> Output), S.NewPart == S.Part {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = Output
//	
//	let optic: S
//	
//	public init(optic: S) {
//		self.optic = optic
//	}
//	
//	public func updating(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updating(whole) { part in
//			{ input0, input1 in
//				let output = await part(input0, input1)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingSetter3<S: ThrowingSetterOptic, Input0, Input1, Input2, Output>: ThrowingSetterOptic
//where S.Part == ((Input0, Input1, Input2) async -> Output), S.NewPart == S.Part {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = Output
//	
//	let optic: S
//	
//	public init(optic: S) {
//		self.optic = optic
//	}
//	
//	public func updating(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updating(whole) { part in
//			{ input0, input1, input2 in
//				let output = await part(input0, input1, input2)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingSetter4<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Output>: ThrowingSetterOptic
//where S.Part == ((Input0, Input1, Input2, Input3) async -> Output), S.NewPart == S.Part {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = Output
//	
//	let optic: S
//	
//	public init(optic: S) {
//		self.optic = optic
//	}
//	
//	public func updating(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updating(whole) { part in
//			{ input0, input1, input2, input3 in
//				let output = await part(input0, input1, input2, input3)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingSetter5<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: ThrowingSetterOptic
//where S.Part == ((Input0, Input1, Input2, Input3, Input4) async -> Output), S.NewPart == S.Part {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = Output
//	
//	let optic: S
//	
//	public init(optic: S) {
//		self.optic = optic
//	}
//	
//	public func updating(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updating(whole) { part in
//			{ input0, input1, input2, input3, input4 in
//				let output = await part(input0, input1, input2, input3, input4)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingSetter6<S: ThrowingSetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: ThrowingSetterOptic
//where S.Part == ((Input0, Input1, Input2, Input3, Input4, Input5) async -> Output), S.NewPart == S.Part {
//	public typealias Whole = S.Whole
//	public typealias NewWhole = S.NewWhole
//	public typealias Part = Output
//	public typealias NewPart = Output
//	
//	let optic: S
//	
//	public init(optic: S) {
//		self.optic = optic
//	}
//	
//	public func updating(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updating(whole) { part in
//			{ input0, input1, input2, input3, input4, input5 in
//				let output = await part(input0, input1, input2, input3, input4, input5)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//extension ThrowingSetterOptic {
//	public func mapAsync<Output>() -> MapAsyncThrowingSetter0<Self, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input, Output>() -> MapAsyncThrowingSetter1<Self, Input, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Output>() -> MapAsyncThrowingSetter2<Self, Input0, Input1, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Input2, Output>() -> MapAsyncThrowingSetter3<Self, Input0, Input1, Input2, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Input2, Input3, Output>() -> MapAsyncThrowingSetter4<Self, Input0, Input1, Input2, Input3, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output>() -> MapAsyncThrowingSetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapAsyncThrowingSetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
//		.init(optic: self)
//	}
//}
