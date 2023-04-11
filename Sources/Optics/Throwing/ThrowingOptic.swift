import Foundation

public enum ThrowingError: Error {
	case noData
}

public protocol ThrowingOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	associatedtype _Body
	
	typealias Body = _Body
		
	func get(_ whole: Whole) throws -> Part
	
	func update(_ whole: Whole, _ f: @escaping (Part) throws -> NewPart) throws -> NewWhole
	
	func set(_ whole: Whole, to: NewPart) throws -> NewWhole
	
	
	@ThrowingOpticBuilder
	var body: Body { get }
}

extension ThrowingOptic where Body == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: Body {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access a ThrowingOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension ThrowingOptic where Body: ThrowingOptic, Body.Whole == Whole, Body.Part == Part, Body.NewWhole == NewWhole, Body.NewPart == NewPart {
	@inlinable
	public func get(_ whole: Whole) throws -> Part {
		try self.body.get(whole)
	}
	
	@inlinable
	public func update(
		_ whole: Whole,
		_ f: @escaping (Part) -> NewPart
	) throws -> NewWhole {
		try self.body.update(whole, f)
	}
	
	@inlinable
	public func set(
		_ whole: Whole,
		to newPart: NewPart
	) throws -> NewWhole {
		try self.body.set(whole, to: newPart)
	}
}

public typealias SimpleThrowingOptic<Whole, Part> = ThrowingOptic<Whole, Part, Whole, Part>

extension ThrowingOptic {
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) -> Void
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		whole = try self.update(whole, { part in
			var copy = part
			f(&copy)
			return copy
		})
	}
	
	@inlinable
	public func update(
		_ whole: Whole,
		_ f: @escaping (inout Part) -> Void
	) throws -> Whole
	where Part == NewPart, Whole == NewWhole {
		try self.update(whole) { part in
			var result = part
			f(&result)
			return result
		}
	}
	
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (Part) -> NewPart
	) throws -> Void
	where Part == NewPart, Whole == NewWhole {
		try self.update(&whole) { part in
			part = f(part)
		}
	}
	
	@inlinable
	public func set(
		_ whole: inout Whole,
		to newPart: NewPart
	) throws where Part == NewPart, Whole == NewWhole {
		whole = try self.set(whole, to: newPart)
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> Whole where Part == NewPart, Whole == NewWhole {
		var copy = whole
		try self.set(&copy, to: newValue)
		return copy
	}
}

public struct ThrowingRawOptic<Whole, Part, NewWhole, NewPart>: ThrowingOptic {
	public let _get: (Whole) throws -> Part
	public let _update: (Whole, @escaping (Part) throws -> NewPart) throws -> NewWhole
	public let _set: (Whole, NewPart) throws -> NewWhole
	
	public init(
		get: @escaping (Whole) throws -> Part,
		update: @escaping (Whole, @escaping (Part) throws -> NewPart) throws -> NewWhole,
		set: @escaping (Whole, NewPart) throws -> NewWhole
	) {
		self._get = get
		self._update = update
		self._set = set
	}
	
	@inlinable
	public func get(_ whole: Whole) throws -> Part {
		try _get(whole)
	}

	@inlinable
	public func update(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) throws -> NewWhole {
		try _update(whole, f)
	}
	
	@inlinable
	public func set(
		_ whole: Whole,
		to newValue: NewPart
	) throws -> NewWhole {
		try _set(whole, newValue)
	}
}

extension OptionalOptic {
	public func throwing() -> ThrowingRawOptic<Whole, Part, NewWhole, NewPart>
	where NewPart == Part {
		ThrowingRawOptic { whole in
			guard let part = self.tryGet(whole) else {
				throw(ThrowingError.noData)
			}
			
			return part
		} update: { whole, update in
			tryUpdate(whole) { part in
				(try? update(part)) ?? part
			}
		} set: { whole, newPart in
			trySet(whole, to: newPart)
		}
	}
}
