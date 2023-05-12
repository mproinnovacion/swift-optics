import Foundation

import Algebra

/// Get all the elements as an array, update them one by one
public protocol ArrayOptic<Whole, Part, NewWhole, NewPart>: ArrayGetterOptic, ArraySetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	associatedtype _ArrayBody
	
	typealias ArrayBody = _ArrayBody
	
	@ArrayOpticBuilder var body: ArrayBody { get }
}

extension ArrayOptic where ArrayBody == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: ArrayBody {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access an ArrayOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension ArrayOptic where ArrayBody: ArrayOptic, ArrayBody.Whole == Whole, ArrayBody.Part == Part, ArrayBody.NewWhole == NewWhole, ArrayBody.NewPart == NewPart {
	
	@inlinable
	public func getAll(_ whole: Whole) -> [Part] {
		self.body.getAll(whole)
	}
	
	@inlinable
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.body.updatingAll(in: whole, update: f)
	}
}

public typealias SimpleArrayOptic<Whole, Part> = ArrayOptic<Whole, Part, Whole, Part>

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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		whole.map(f)
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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		Set(whole.map(f))
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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		whole.mapValues(f)
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
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		guard let optic = self.optic else {
			return whole
		}
		
		return optic.updatingAll(in: whole, update: f)
	}
}

public struct ArrayProvidedWholeOptic<O: ArrayOptic>: ArrayOptic {
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
	
	public func getAll(_ whole: Void) -> [O.Part] {
		self.optic.getAll(self.whole)
	}
	
	public func updatingAll(
		in void: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		optic.updatingAll(in: self.whole, update: f)
	}
}

extension ArrayOptic {
	public func provide(
		_ whole: Whole
	) -> ArrayProvidedWholeOptic<Self> {
		.init(
			optic: self,
			whole: whole
		)
	}
}

extension ArrayOptic where Whole == Void {
	public func getAll() -> [Part] {
		self.getAll(())
	}
	
	public func updatingAll(
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		self.updatingAll(in: (), update: f)
	}
	
	public func settingAll(
		to newValue: NewPart
	) -> NewWhole {
		self.settingAll(in: (), to: newValue)
	}
}
