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

extension ArrayOptic
where ArrayBody: ArrayOptic, ArrayBody.Whole == Whole, ArrayBody.Part == Part, ArrayBody.NewWhole == NewWhole, ArrayBody.NewPart == NewPart {
	
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
	
	public func settingAll(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		self.body.settingAll(in: whole, to: newValue)
	}
}

public struct EmptyArrayOptic<Whole, Part>: ArrayOptic {
	public typealias NewWhole = Whole
	public typealias NewPart = Part
	
	public func getAll(_ whole: Whole) -> [Part] {
		[]
	}
	
	public func updatingAll(in whole: Whole, update f: @escaping (Part) -> NewPart) -> NewWhole {
		whole
	}
	
	public func settingAll(in whole: Whole, to newValue: NewPart) -> NewWhole {
		whole
	}
}

extension ArrayOptic where NewWhole == Whole, NewPart == Part {
	public static func empty() -> EmptyArrayOptic<Whole, Part> {
		.init()
	}
}

public typealias SimpleArrayOptic<Whole, Part> = ArrayOptic<Whole, Part, Whole, Part>

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
	
	public func settingAll(
		in whole: Whole,
		to newValue: NewPart
	) -> O.NewWhole {
		guard let optic = self.optic else {
			return whole
		}
		
		return optic.settingAll(in: whole, to: newValue)
	}
}
