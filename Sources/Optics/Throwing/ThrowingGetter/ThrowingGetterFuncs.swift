import Foundation

public struct ThrowingGetterFunc0<R>: ThrowingGetterOptic {
	public typealias Whole = ()
	public typealias Part = R?
	
	public let run: () throws -> R
	
	public init(run: @escaping () throws -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) throws -> Part {
		try self.run()
	}
}

public struct ThrowingGetterFunc1<O0, R>: ThrowingGetterOptic {
	public typealias Whole = O0
	public typealias Part = R
	
	public let run: (O0) throws -> R
	
	public init(run: @escaping (O0) throws -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) throws -> Part {
		try self.run(whole)
	}
}

public struct ThrowingGetterFunc2<O0, O1, R>: ThrowingGetterOptic {
	public typealias Whole = (O0, O1)
	public typealias Part = R
	
	public let run: (O0, O1) throws -> R
	
	public init(run: @escaping (O0, O1) throws -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) throws -> Part {
		try self.run(whole.0, whole.1)
	}
}

public struct ThrowingGetterFunc3<O0, O1, O2, R>: ThrowingGetterOptic {
	public typealias Whole = (O0, O1, O2)
	public typealias Part = R
	
	public let run: (O0, O1, O2) throws -> R
	
	public init(run: @escaping (O0, O1, O2) throws -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) throws -> Part {
		try self.run(whole.0, whole.1, whole.2)
	}
}

public struct ThrowingGetterFunc4<O0, O1, O2, O3, R>: ThrowingGetterOptic {
	public typealias Whole = (O0, O1, O2, O3)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3) throws -> R
	
	public init(run: @escaping (O0, O1, O2, O3) throws -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) throws -> Part {
		try self.run(whole.0, whole.1, whole.2, whole.3)
	}
}

public struct ThrowingGetterFunc5<O0, O1, O2, O3, O4, R>: ThrowingGetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4) throws -> R
	
	public init(run: @escaping (O0, O1, O2, O3, O4) throws -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) throws -> Part {
		try self.run(whole.0, whole.1, whole.2, whole.3, whole.4)
	}
}

public struct ThrowingGetterFunc6<O0, O1, O2, O3, O4, O5, R>: ThrowingGetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4, O5)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4, O5) throws -> R
	
	public init(run: @escaping (O0, O1, O2, O3, O4, O5) throws -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) throws -> Part {
		try self.run(whole.0, whole.1, whole.2, whole.3, whole.4, whole.5)
	}
}
