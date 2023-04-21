import Foundation

import Algebra

/// Get all the elements as an array, update them one by one
public protocol ArrayOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	associatedtype _Body
	
	typealias Body = _Body
		
	func getAll(_ whole: Whole) -> [Part]
	
	func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole
	
	@ArrayOpticBuilder var body: Body { get }
}

extension ArrayOptic where Body == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: Body {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access an ArrayOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension ArrayOptic where Body: ArrayOptic, Body.Whole == Whole, Body.Part == Part, Body.NewWhole == NewWhole, Body.NewPart == NewPart {
	
	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		self.body.getAll(whole)
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try self.body.updatingAll(whole, f)
	}
}

public typealias SimpleArrayOptic<Whole, Part> = ArrayOptic<Whole, Part, Whole, Part>

extension ArrayOptic {
	@inlinable
	public func updateAll(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = try self.updatingAll(whole) { part in
			var copy = part
			try f(&copy)
			return copy
		}
	}
}

extension ArrayOptic where NewPart == Part, NewWhole == Whole {
	@inlinable
	public func setAll(_ whole: inout Whole, to part: Part) -> Void {
		self.updateAll(&whole) { value in
			value = part
		}
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Whole {
		try self.updatingAll(whole) { part in
			var copy = part
			try f(&copy)
			return copy
		}
	}

	@inlinable
	public func settingAll(_ whole: Whole, to part: Part) -> Whole {
		var copy = whole
		self.setAll(&copy, to: part)
		return copy
	}
}

public struct ArrayDefaultOptic<Element, NewElement>: ArrayOptic {
	public typealias Whole = Array<Element>
	public typealias NewWhole = Array<NewElement>
	public typealias Part = Element
	public typealias NewPart = NewElement

	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		whole
	}

	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try whole.map(f)
	}
}

public struct SetDefaultOptic<Element: Hashable, NewElement: Hashable>: ArrayOptic {
	public typealias Whole = Set<Element>
	public typealias NewWhole = Set<NewElement>
	public typealias Part = Element
	public typealias NewPart = NewElement

	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		Array(whole)
	}

	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		Set(try whole.map(f))
	}
}

public struct DictionaryValuesOptic<Key: Hashable, Value, NewValue>: ArrayOptic {
	public typealias Whole = Dictionary<Key, Value>
	public typealias NewWhole = Dictionary<Key, NewValue>
	public typealias Part = Value
	public typealias NewPart = NewValue

	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		Array(whole.values)
	}

	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try whole.mapValues(f)
	}
}

public struct ArrayOpticFromOptional<Whole, Part, NewPart, O: ArrayOptic>: ArrayOptic
where O.NewWhole == O.Whole, Whole == O.Whole, Part == O.Part, NewPart == O.NewPart {
	public typealias NewWhole = O.NewWhole
	
	public let optic: O?
	
	public init(optic: O?) {
		self.optic = optic
	}
	
	public func getAll(_ whole: Whole) -> [Part] {
		optic?.getAll(whole) ?? []
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		guard let optic = self.optic else {
			return whole
		}
		
		return try optic.updatingAll(whole, f)
	}
}

public struct ArrayLensLiftOptic<O: LensOptic>: ArrayOptic {
	let lens: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[lens.get(whole)]
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try lens.updating(whole, f)
	}
}

public struct ArrayOptionalLiftOptic<O: OptionalOptic>: ArrayOptic {
	let optic: O
	
	public typealias Whole = O.Whole
	public typealias NewWhole = O.NewWhole
	public typealias Part = O.Part
	public typealias NewPart = O.NewPart
	
	public func getAll(_ whole: Whole) -> [Part] {
		[optic.tryGet(whole)].compactMap { $0 }
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		try optic.tryUpdating(whole, f)
	}
}
