import Foundation

public protocol ArraySetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole
}

extension ArraySetterOptic {
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

public typealias SimpleArraySetterOptic<Whole, Part> = ArraySetterOptic<Whole, Part, Whole, Part>

extension ArraySetterOptic {
	@inlinable
	public func setAll(
		_ whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		updateAll(&whole) { part in
			part = newValue
		}
	}
	
	@inlinable
	public func settingAll(
		_ whole: Whole,
		to newValue: Part
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.setAll(&copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (inout Part) throws -> Void
	) rethrows -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		try self.updateAll(&copy, f)
		return copy
	}
}

public struct ArraySetterRawOptic<Whole, Part, NewWhole, NewPart>: ArraySetterOptic {
	public let _updatingAll: (Whole, @escaping (Part) throws -> NewPart) -> NewWhole
	
	public init(
		updatingAll: @escaping (Whole, @escaping (Part) throws -> NewPart) -> NewWhole
	) {
		self._updatingAll = updatingAll
	}
	
	public func updatingAll(
		_ whole: Whole,
		_ f: @escaping (Part) throws -> NewPart
	) rethrows -> NewWhole {
		_updatingAll(whole, f)
	}
}
