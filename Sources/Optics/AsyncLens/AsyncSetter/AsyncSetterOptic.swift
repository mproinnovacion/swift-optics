import Foundation

public protocol AsyncSetterOptic<Whole, Part, NewWhole, NewPart> {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole
}

extension AsyncSetterOptic {
	public func setting(
		_ whole: Whole,
		to newValue: NewPart
	) async -> NewWhole {
		await self.updating(whole, { _ in newValue })
	}
}

extension AsyncSetterOptic {
	@inlinable
	public func update(
		_ whole: inout Whole,
		_ f: @escaping (inout Part) async throws -> Void
	) async rethrows -> Void
	where NewWhole == Whole, NewPart == Part {
		whole = try await self.updating(whole) { part in
			var copy = part
			try await f(&copy)
			return copy
		}
	}
}

public typealias SimpleAsyncSetterOptic<Whole, Part> = AsyncSetterOptic<Whole, Part, Whole, Part>

extension AsyncSetterOptic {
	@inlinable
	public func `set`(
		_ whole: inout Whole,
		to newValue: NewPart
	) async where NewWhole == Whole, NewPart == Part {
		await update(&whole) { part in
			part = newValue
		}
	}
	
	@inlinable
	public func setting(
		_ whole: Whole,
		to newValue: Part
	) async -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		await self.set(&copy, to: newValue)
		return copy
	}
	
	@inlinable
	public func updating(
		_ whole: Whole,
		_ f: @escaping (inout Part) async throws -> Void
	) async rethrows -> Whole
	where NewWhole == Whole, NewPart == Part {
		var copy = whole
		try await self.update(&copy, f)
		return copy
	}
}

public struct AsyncSetterRawOptic<Whole, Part, NewWhole, NewPart>: AsyncSetterOptic {
	public let _updating: (Whole, @escaping (Part) async throws -> NewPart) async -> NewWhole
	
	public init(
		updating: @escaping (Whole, @escaping (Part) async throws -> NewPart) async -> NewWhole
	) {
		self._updating = updating
	}
	
	public func updating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		await _updating(whole, f)
	}
}
