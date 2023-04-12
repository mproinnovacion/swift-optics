import Foundation

public protocol Getter {
	associatedtype Whole
	associatedtype Part
	
	func `get`(_ whole: Whole) -> Part
}

public protocol Setter {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole
}

extension Setter {
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = try self.updating(whole) { part in
			var copy = part
			try f(&copy)
			return copy
		}
	}
}

public protocol LensOptic<Whole, Part, NewWhole, NewPart>: Getter, Setter {
	associatedtype _Body
	
	typealias Body = _Body

	@LensBuilder
	var body: Body { get }
}

extension LensOptic where Body == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: Body {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access a LensOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension LensOptic where Body: LensOptic, Body.Whole == Whole, Body.Part == Part, Body.NewWhole == NewWhole, Body.NewPart == NewPart {
	
	@inlinable
	public func get(_ whole: Whole) -> Part {
		self.body.get(whole)
	}
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try self.body.updating(whole, f)
	}
}

public typealias SimpleLensOptic<Whole, Part> = LensOptic<Whole, Part, Whole, Part>

extension LensOptic {
	@inlinable
	public func `set`(
		_ whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		update(&whole) { part in
			part = newValue
		}
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: Part
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.set(&copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		try self.update(&copy, f)
		return copy
	}
}

extension LensOptic {
	@inlinable
	public func each<Element, NewElement>() -> Each<Self, Element, NewElement>
	where Part == [Element], NewPart == [NewElement] {
		Each {
			self
		}
	}
}

extension KeyPath: Getter {
	@inlinable
	public func get(_ whole: Root) -> Value {
		whole[keyPath: self]
	}
}

extension WritableKeyPath: LensOptic {
	public typealias NewWhole = Root
	public typealias NewPart = Value
	
	@inlinable
	public func updating(
		_ whole: Root,
		_ f: @escaping (Value) throws -> Value
	) rethrows -> Root {
		var result = whole
		result[keyPath: self] = try f(result[keyPath: self])
		return result
	}
}

