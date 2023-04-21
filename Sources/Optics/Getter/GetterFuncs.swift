import Foundation

public struct GetterFunc0<R>: GetterOptic {
	public typealias Whole = ()
	public typealias Part = R
	
	public let run: () -> R
	
	public init(run: @escaping () -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run()
	}
}

public struct GetterFunc1<O0, R>: GetterOptic {
	public typealias Whole = O0
	public typealias Part = R
	
	public let run: (O0) -> R
	
	public init(run: @escaping (O0) -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run(whole)
	}
}

public struct GetterFunc2<O0, O1, R>: GetterOptic {
	public typealias Whole = (O0, O1)
	public typealias Part = R
	
	public let run: (O0, O1) -> R
	
	public init(run: @escaping (O0, O1) -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run(whole.0, whole.1)
	}
}

public struct GetterFunc3<O0, O1, O2, R>: GetterOptic {
	public typealias Whole = (O0, O1, O2)
	public typealias Part = R
	
	public let run: (O0, O1, O2) -> R
	
	public init(run: @escaping (O0, O1, O2) -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run(whole.0, whole.1, whole.2)
	}
}

public struct GetterFunc4<O0, O1, O2, O3, R>: GetterOptic {
	public typealias Whole = (O0, O1, O2, O3)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3) -> R
	
	public init(run: @escaping (O0, O1, O2, O3) -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run(whole.0, whole.1, whole.2, whole.3)
	}
}

public struct GetterFunc5<O0, O1, O2, O3, O4, R>: GetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4) -> R
	
	public init(run: @escaping (O0, O1, O2, O3, O4) -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run(whole.0, whole.1, whole.2, whole.3, whole.4)
	}
}

public struct GetterFunc6<O0, O1, O2, O3, O4, O5, R>: GetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4, O5)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4, O5) -> R
	
	public init(run: @escaping (O0, O1, O2, O3, O4, O5) -> R) {
		self.run = run
	}
	
	public func get(_ whole: Whole) -> Part {
		self.run(whole.0, whole.1, whole.2, whole.3, whole.4, whole.5)
	}
}
