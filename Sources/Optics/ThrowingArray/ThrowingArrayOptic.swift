import Foundation

public protocol ThrowingArrayOptic<Whole, Part, NewWhole, NewPart>: ThrowingArrayGetterOptic, ThrowingArraySetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	associatedtype _Body
	
	typealias Body = _Body
	
	@ThrowingArrayOpticBuilder
	var body: Body { get }
}

extension ThrowingArrayOptic where Body == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: Body {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access a ThrowingArrayOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension ThrowingArrayOptic where Body: ThrowingArrayOptic, Body.Whole == Whole, Body.Part == Part, Body.NewWhole == NewWhole, Body.NewPart == NewPart {
	@inlinable
	public func getAll(_ whole: Whole) throws -> [Part] {
		try self.body.getAll(whole)
	}
	
	@inlinable
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.body.updatingAll(in: whole, update: f)
	}
	
	@inlinable
	public func settingAll(
		in whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole {
		try self.body.updatingAll(in: whole) { _ in
			newPart
		}
	}
}

public typealias SimpleThrowingArrayOptic<Whole, Part> = ThrowingArrayOptic<Whole, Part, Whole, Part>

public struct ThrowingArrayRawOptic<Whole, Part, NewWhole, NewPart>: ThrowingArrayOptic {
	public let _getAll: (Whole) throws -> [Part]
	public let _updatingAll: (Whole, @escaping (Part) throws -> NewPart) throws -> NewWhole
	
	public init(
		getAll: @escaping (Whole) throws -> [Part],
		updatingAll: @escaping (Whole, @escaping (Part) throws -> NewPart) throws -> NewWhole
	) {
		self._getAll = getAll
		self._updatingAll = updatingAll
	}
	
	@inlinable
	public func getAll(_ whole: Whole) throws -> [Part] {
		try _getAll(whole)
	}

	@inlinable
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try _updatingAll(whole, f)
	}
}

extension ArrayOptic where NewPart == Part {
	public func throwing() -> LiftArrayToThrowingArray<Self> {
		.init(optic: self)
	}
}

public struct ThrowingArrayProvidedWholeOptic<O: ThrowingArrayOptic>: ThrowingArrayOptic {
	public typealias Whole = Void
	public typealias Part = O.Part
	public typealias NewWhole = O.NewWhole
	public typealias NewPart = O.NewPart

	public let optic: O
	public let whole: O.Whole

	public init(
		optic: O,
		whole: O.Whole
	) {
		self.optic = optic
		self.whole = whole
	}

	public func getAll(_ whole: Void) throws -> [O.Part] {
		try self.optic.getAll(self.whole)
	}
	
	public func updatingAll(
		in void: Whole,
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try optic.updatingAll(in: self.whole, update: f)
	}
}

extension ThrowingArrayOptic {
	public func provide(
		_ whole: Whole
	) -> ThrowingArrayProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ThrowingArrayOptic where Whole == Void {
	public func getAll() throws -> [Part] {
		try self.getAll(())
	}
	
	public func updatingAll(
		update f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.updatingAll(in: (), update: f)
	}

	public func settingAll(
		to newValue: NewPart
	) throws -> NewWhole {
		try self.settingAll(in: (), to: newValue)
	}
}
