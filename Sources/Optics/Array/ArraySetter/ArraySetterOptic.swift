import Foundation

public protocol ArraySetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole
	
	func settingAll(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole
}

// MARK: Default settingAll implementation.
extension ArraySetterOptic {
	@inlinable
	public func settingAll(
		in whole: Whole,
		to newValue: NewPart
	) -> NewWhole {
		self.updatingAll(in: whole) { _ in newValue }
	}
}

public typealias SimpleArraySetterOptic<Whole, Part> = ArraySetterOptic<Whole, Part, Whole, Part>

// MARK: Mutating functions
extension ArraySetterOptic {
	@inlinable
	public func updateAll(
		in whole: inout Whole,
		update f: @escaping (inout Part) -> Void
	) -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = self.updatingAll(in: whole) { part in
			var copy = part
			f(&copy)
			return copy
		}
	}
	
	@inlinable
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (inout Part) -> Void
	) -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		self.updateAll(in: &copy, update: f)
		return copy
	}
	
	@inlinable
	public func setAll(
		in whole: inout Whole,
		to newValue: NewPart
	) where NewWhole == Whole, NewPart == Part {
		whole = settingAll(in: whole, to: newValue)
	}
}

extension ArraySetterOptic {
	@inlinable
	public func updater(
		update f: @escaping (Part) -> NewPart
	) -> (Whole) -> NewWhole {
		{ whole in
			self.updatingAll(in: whole, update: f)
		}
	}
}

public struct ArraySetterRawOptic<Whole, Part, NewWhole, NewPart>: ArraySetterOptic {
	public let _updatingAll: (Whole, @escaping (Part) -> NewPart) -> NewWhole
	
	public init(
		updatingAll: @escaping (
			Whole,
			@escaping (Part) -> NewPart
		) -> NewWhole
	) {
		self._updatingAll = updatingAll
	}
	
	public func updatingAll(
		in whole: Whole,
		update f: @escaping (Part) -> NewPart
	) -> NewWhole {
		_updatingAll(whole, f)
	}
}
