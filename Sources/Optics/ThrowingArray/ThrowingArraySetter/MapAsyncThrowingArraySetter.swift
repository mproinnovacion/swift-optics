//import Foundation
//
//public typealias AsyncFunc0<Output> = (() async -> Output)
//
//public struct MapAsyncThrowingArraySetter0<S: ThrowingArraySetterOptic, Output>: ThrowingArraySetterOptic
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
//	public func updatingAll(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updatingAll(whole) { part in
//			{
//				let output = await part()
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingArraySetter1<S: ThrowingArraySetterOptic, Input, Output>: ThrowingArraySetterOptic
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
//	public func updatingAll(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updatingAll(whole) { part in
//			{ input in
//				let output = await part(input)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingArraySetter2<S: ThrowingArraySetterOptic, Input0, Input1, Output>: ThrowingArraySetterOptic
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
//	public func updatingAll(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updatingAll(whole) { part in
//			{ input0, input1 in
//				let output = await part(input0, input1)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingArraySetter3<S: ThrowingArraySetterOptic, Input0, Input1, Input2, Output>: ThrowingArraySetterOptic
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
//	public func updatingAll(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updatingAll(whole) { part in
//			{ input0, input1, input2 in
//				let output = await part(input0, input1, input2)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingArraySetter4<S: ThrowingArraySetterOptic, Input0, Input1, Input2, Input3, Output>: ThrowingArraySetterOptic
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
//	public func updatingAll(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updatingAll(whole) { part in
//			{ input0, input1, input2, input3 in
//				let output = await part(input0, input1, input2, input3)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingArraySetter5<S: ThrowingArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Output>: ThrowingArraySetterOptic
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
//	public func updatingAll(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updatingAll(whole) { part in
//			{ input0, input1, input2, input3, input4 in
//				let output = await part(input0, input1, input2, input3, input4)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//public struct MapAsyncThrowingArraySetter6<S: ThrowingArraySetterOptic, Input0, Input1, Input2, Input3, Input4, Input5, Output>: ThrowingArraySetterOptic
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
//	public func updatingAll(
//		_ whole: S.Whole,
//		_ f: @escaping (Output) throws -> Output
//	) throws -> S.NewWhole {
//		try self.optic.updatingAll(whole) { part in
//			{ input0, input1, input2, input3, input4, input5 in
//				let output = await part(input0, input1, input2, input3, input4, input5)
//				return (try? f(output)) ?? output
//			}
//		}
//	}
//}
//
//extension ThrowingArraySetterOptic {
//	public func mapAsync<Output>() -> MapAsyncThrowingArraySetter0<Self, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input, Output>() -> MapAsyncThrowingArraySetter1<Self, Input, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Output>() -> MapAsyncThrowingArraySetter2<Self, Input0, Input1, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Input2, Output>() -> MapAsyncThrowingArraySetter3<Self, Input0, Input1, Input2, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Input2, Input3, Output>() -> MapAsyncThrowingArraySetter4<Self, Input0, Input1, Input2, Input3, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Output>() -> MapAsyncThrowingArraySetter5<Self, Input0, Input1, Input2, Input3, Input4, Output> {
//		.init(optic: self)
//	}
//	
//	public func mapAsync<Input0, Input1, Input2, Input3, Input4, Input5, Output>() -> MapAsyncThrowingArraySetter6<Self, Input0, Input1, Input2, Input3, Input4, Input5, Output> {
//		.init(optic: self)
//	}
//}
