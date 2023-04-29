import Foundation

public struct AsyncGetter<O: AsyncGetterOptic>: AsyncGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@AsyncGetterOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func get(_ whole: O.Whole) async -> O.Part {
		await self.optic.get(whole)
	}
}
