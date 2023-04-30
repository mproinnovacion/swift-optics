import Foundation

public protocol ThrowingArrayOptic<Whole, Part, NewWhole, NewPart>: ThrowingArrayGetterOptic, ThrowingArraySetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	associatedtype _Body
	
	typealias Body = _Body
		
	func getAll(_ whole: Whole) throws -> [Part]
	
	func updatingAll(_ whole: Whole, _ f: @escaping (Part) throws -> NewPart) throws -> NewWhole
	
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
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try self.body.updatingAll(whole, f)
	}
	
	@inlinable
	public func settingAll(
		_ whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole {
		try self.body.updatingAll(whole) { _ in
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
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try _updatingAll(whole, f)
	}
}

extension ArrayOptic where NewPart == Part {
	public func throwing() -> LiftArrayToThrowingArray<Self> {
		.init(optic: self)
	}
}
