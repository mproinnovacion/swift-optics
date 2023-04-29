import Foundation

public struct AsyncOptionalGetterFunc0<R>: AsyncOptionalGetterOptic {
	public typealias Whole = ()
	public typealias Part = R?
	
	public let run: () async -> R?
	
	public init(run: @escaping () async -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await self.run()
	}
}

public struct AsyncOptionalGetterFunc1<O0, R>: AsyncOptionalGetterOptic {
	public typealias Whole = O0
	public typealias Part = R
	
	public let run: (O0) async -> R?
	
	public init(run: @escaping (O0) async -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await self.run(whole)
	}
}

public struct AsyncOptionalGetterFunc2<O0, O1, R>: AsyncOptionalGetterOptic {
	public typealias Whole = (O0, O1)
	public typealias Part = R
	
	public let run: (O0, O1) async -> R?
	
	public init(run: @escaping (O0, O1) async -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await self.run(whole.0, whole.1)
	}
}

public struct AsyncOptionalGetterFunc3<O0, O1, O2, R>: AsyncOptionalGetterOptic {
	public typealias Whole = (O0, O1, O2)
	public typealias Part = R
	
	public let run: (O0, O1, O2) async -> R?
	
	public init(run: @escaping (O0, O1, O2) async -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await self.run(whole.0, whole.1, whole.2)
	}
}

public struct AsyncOptionalGetterFunc4<O0, O1, O2, O3, R>: AsyncOptionalGetterOptic {
	public typealias Whole = (O0, O1, O2, O3)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3) async -> R?
	
	public init(run: @escaping (O0, O1, O2, O3) async -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await self.run(whole.0, whole.1, whole.2, whole.3)
	}
}

public struct AsyncOptionalGetterFunc5<O0, O1, O2, O3, O4, R>: AsyncOptionalGetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4) async -> R?
	
	public init(run: @escaping (O0, O1, O2, O3, O4) async -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await self.run(whole.0, whole.1, whole.2, whole.3, whole.4)
	}
}

public struct AsyncOptionalGetterFunc6<O0, O1, O2, O3, O4, O5, R>: AsyncOptionalGetterOptic {
	public typealias Whole = (O0, O1, O2, O3, O4, O5)
	public typealias Part = R
	
	public let run: (O0, O1, O2, O3, O4, O5) async -> R?
	
	public init(run: @escaping (O0, O1, O2, O3, O4, O5) async -> R?) {
		self.run = run
	}
	
	public func tryGet(_ whole: Whole) async -> Part? {
		await self.run(whole.0, whole.1, whole.2, whole.3, whole.4, whole.5)
	}
}
