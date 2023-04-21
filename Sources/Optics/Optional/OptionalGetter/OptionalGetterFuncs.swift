import Foundation

public struct OptionalGetterFunc0<R>: OptionalGetterOptic {
	public typealias Whole = ()
	public typealias Part = R?
	
	public let run: () -> R?
	
	public init(run: @escaping () -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.run()
	}
}

public struct OptionalGetterFunc1<O0, R>: OptionalGetterOptic {
	public typealias Whole = O0
	public typealias Part = R
	
	public let run: (O0) -> R?
	
	public init(run: @escaping (O0) -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.run(whole)
	}
}

public struct OptionalGetterFunc2<O0, O1, R>: OptionalGetterOptic {
	public typealias Whole = (O0, O1)
	public typealias Part = R
	
	public let run: (O0, O1) -> R?
	
	public init(run: @escaping (O0, O1) -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.run(whole.0, whole.1)
	}
}

public struct OptionalGetterFunc3<O0, O1, O2, R>: OptionalGetterOptic {
	public typealias Whole = (O0, O1, O2)
	public typealias Part = R
	
	public let run: (O0, O1, O2) -> R?
	
	public init(run: @escaping (O0, O1, O2) -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.run(whole.0, whole.1, whole.2)
	}
}

public struct OptionalGetterFunc4<O0, O1, O2, O3, R>: OptionalGetterOptic {
	public typealias Whole = (O0, O1, O2, O3)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3) -> R?
	
	public init(run: @escaping (O0, O1, O2, O3) -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.run(whole.0, whole.1, whole.2, whole.3)
	}
}

public struct OptionalGetterFunc5<O0, O1, O2, O3, O4, R>: OptionalGetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4) -> R?
	
	public init(run: @escaping (O0, O1, O2, O3, O4) -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.run(whole.0, whole.1, whole.2, whole.3, whole.4)
	}
}

public struct OptionalGetterFunc6<O0, O1, O2, O3, O4, O5, R>: OptionalGetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4, O5)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4, O5) -> R?
	
	public init(run: @escaping (O0, O1, O2, O3, O4, O5) -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) -> Part? {
		self.run(whole.0, whole.1, whole.2, whole.3, whole.4, whole.5)
	}
}
