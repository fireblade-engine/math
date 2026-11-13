extension Matrix2x2: Codable {
    /// Encodes the matrix as a flat array of 4 values in column-major order.
    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }

    /// Decodes the matrix from a flat array of 4 values in column-major order.
    /// - Throws: `DecodingError.dataCorrupted` if the array does not hold exactly 4 values.
    @inlinable
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode([Value].self)
        guard values.count == 4 else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Matrix2x2 needs exactly 4 values, got \(values.count)")
        }
        self.init(values)
    }
}

extension Matrix3x3: Codable {
    /// Encodes the matrix as a flat array of 9 values in column-major order.
    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }

    /// Decodes the matrix from a flat array of 9 values in column-major order.
    /// - Throws: `DecodingError.dataCorrupted` if the array does not hold exactly 9 values.
    @inlinable
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode([Value].self)
        guard values.count == 9 else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Matrix3x3 needs exactly 9 values, got \(values.count)")
        }
        self.init(values)
    }
}

extension Matrix4x4: Codable {
    /// Encodes the matrix as a flat array of 16 values in column-major order.
    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }

    /// Decodes the matrix from a flat array of 16 values in column-major order.
    /// - Throws: `DecodingError.dataCorrupted` if the array does not hold exactly 16 values.
    @inlinable
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode([Value].self)
        guard values.count == 16 else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Matrix4x4 needs exactly 16 values, got \(values.count)")
        }
        self.init(values)
    }
}
