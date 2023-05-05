import Foundation

extension Sequence {
	func mapAsync<T>(
		_ transform: (Element) async throws -> T
	) async rethrows -> [T] {
		var values = [T]()
		
		for element in self {
			try await values.append(transform(element))
		}
		
		return values
	}
}
