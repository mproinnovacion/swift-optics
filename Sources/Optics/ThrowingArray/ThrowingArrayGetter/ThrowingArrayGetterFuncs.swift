import Foundation

public struct ThrowingArrayGetterFunc0<R>: ThrowingArrayGetterOptic {
	public typealias Whole = ()
	public typealias Part = R
	
	public let run: () throws -> [R]
	
	public init(run: @escaping () throws -> [R]) {
		self.run = run
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		try self.run()
	}
}

public struct ThrowingArrayGetterFunc1<O0, R>: ThrowingArrayGetterOptic {
	public typealias Whole = O0
	public typealias Part = R
	
	public let run: (O0) throws -> [R]
	
	public init(run: @escaping (O0) throws -> [R]) {
		self.run = run
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		try self.run(whole)
	}
}

public struct ThrowingArrayGetterFunc2<O0, O1, R>: ThrowingArrayGetterOptic {
	public typealias Whole = (O0, O1)
	public typealias Part = R
	
	public let run: (O0, O1) throws -> [R]
	
	public init(run: @escaping (O0, O1) throws -> [R]) {
		self.run = run
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		try self.run(whole.0, whole.1)
	}
}

public struct ThrowingArrayGetterFunc3<O0, O1, O2, R>: ThrowingArrayGetterOptic {
	public typealias Whole = (O0, O1, O2)
	public typealias Part = R
	
	public let run: (O0, O1, O2) throws -> [R]
	
	public init(run: @escaping (O0, O1, O2) throws -> [R]) {
		self.run = run
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		try self.run(whole.0, whole.1, whole.2)
	}
}

public struct ThrowingArrayGetterFunc4<O0, O1, O2, O3, R>: ThrowingArrayGetterOptic {
	public typealias Whole = (O0, O1, O2, O3)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3) throws -> [R]
	
	public init(run: @escaping (O0, O1, O2, O3) throws -> [R]) {
		self.run = run
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		try self.run(whole.0, whole.1, whole.2, whole.3)
	}
}

public struct ThrowingArrayGetterFunc5<O0, O1, O2, O3, O4, R>: ThrowingArrayGetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4) throws -> [R]
	
	public init(run: @escaping (O0, O1, O2, O3, O4) throws -> [R]) {
		self.run = run
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		try self.run(whole.0, whole.1, whole.2, whole.3, whole.4)
	}
}

public struct ThrowingArrayGetterFunc6<O0, O1, O2, O3, O4, O5, R>: ThrowingArrayGetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4, O5)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4, O5) throws -> [R]
	
	public init(run: @escaping (O0, O1, O2, O3, O4, O5) throws -> [R]) {
		self.run = run
	}
	
	public func getAll(_ whole: Whole) throws -> [Part] {
		try self.run(whole.0, whole.1, whole.2, whole.3, whole.4, whole.5)
	}
}
