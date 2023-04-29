import Foundation

public struct AsyncOptionalGetter<O: AsyncOptionalGetterOptic>: AsyncOptionalGetterOptic {
	public typealias Whole = O.Whole
	public typealias Part = O.Part
	
	public let optic: O
	
	@inlinable
	public init(
		@AsyncOptionalGetterOpticBuilder with build: () -> O
	) {
		self.optic = build()
	}
	
	public func tryGet(_ whole: O.Whole) async -> O.Part? {
		await self.optic.tryGet(whole)
	}
}
