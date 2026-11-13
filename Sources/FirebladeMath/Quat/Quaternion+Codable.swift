extension Quaternion: Codable {
    /// Encodes the quaternion as a flat array of 4 values [x, y, z, w].
    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }

    /// Decodes the quaternion from a flat array of 4 values [x, y, z, w].
    /// - Throws: `DecodingError.dataCorrupted` if the array does not hold exactly 4 values.
    @inlinable
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode([Value].self)
        guard values.count == 4 else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Quaternion needs exactly 4 values, got \(values.count)")
        }
        self.init(values[0], values[1], values[2], values[3])
    }
}
