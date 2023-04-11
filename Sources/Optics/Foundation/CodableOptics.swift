import Foundation

extension Decodable where Self: Encodable {
	public static var defaultEncoder: JSONEncoder {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		encoder.dateEncodingStrategy = .secondsSince1970
		return encoder
	}
	
	public static var defaultDecoder: JSONDecoder {
		let encoder = JSONDecoder()
		encoder.dateDecodingStrategy = .secondsSince1970
		return encoder
	}
	
	public static func codableOptic(
		decoder: JSONDecoder = defaultDecoder,
		encoder: JSONEncoder = defaultEncoder
	) -> some SimpleThrowingOptic<Data, Self> {
		ThrowingRawOptic { data in
			try decoder.decode(Self.self, from: data)
		} update: { data, update in
			let object = try decoder.decode(Self.self, from: data)
			
			let updated = try update(object)
			
			return try encoder.encode(updated)
		} set: { data, newObject in
			try encoder.encode(newObject)
		}
	}
}
