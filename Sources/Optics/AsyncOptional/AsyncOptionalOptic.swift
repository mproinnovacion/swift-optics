import Foundation

public protocol AsyncOptionalOptic<Whole, Part, NewWhole, NewPart>: AsyncOptionalGetterOptic, AsyncOptionalSetterOptic {
	associatedtype Whole
	associatedtype NewWhole
	associatedtype Part
	associatedtype NewPart
	
	associatedtype _AsyncOptionalBody
	
	typealias AsyncOptionalBody = _AsyncOptionalBody
	
	@AsyncOptionalOpticBuilder
	var body: AsyncOptionalBody { get }
}

extension AsyncOptionalOptic where AsyncOptionalBody == Never {
	/// A non-existent body.
	///
	/// > Warning: Do not invoke this property directly. It will trigger a fatal error at runtime.
	@_transparent
	public var body: AsyncOptionalBody {
		fatalError(
  """
  '\(Self.self)' has no body. …
  Do not access an AsyncOptionalOptic's 'body' property directly, as it may not exist.
  """
		)
	}
}

extension AsyncOptionalOptic where AsyncOptionalBody: AsyncOptionalOptic, AsyncOptionalBody.Whole == Whole, AsyncOptionalBody.Part == Part, AsyncOptionalBody.NewWhole == NewWhole, AsyncOptionalBody.NewPart == NewPart {
	@inlinable
	public func tryGet(_ whole: Whole) async -> Part? {
		await self.body.tryGet(whole)
	}
	
	@inlinable
	public func tryUpdating(
		_ whole: Whole,
		_ f: @escaping (Part) async throws -> NewPart
	) async rethrows -> NewWhole {
		try await self.body.tryUpdating(whole, f)
	}
	
	@inlinable
	public func trySetting(
		_ whole: Whole,
		to newPart: NewPart
	) async -> NewWhole {
		await self.body.trySetting(whole, to: newPart)
	}
}

public typealias SimpleAsyncOptionalOptic<Whole, Part> = AsyncOptionalOptic<Whole, Part, Whole, Part>
