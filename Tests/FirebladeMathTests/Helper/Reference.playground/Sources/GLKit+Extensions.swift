import GLKit

extension GLKMatrix4: CustomStringConvertible, CustomDebugStringConvertible {
    @inlinable public var elements: [Float] {
        var m = self.m
        return [Float](UnsafeMutableBufferPointer(start: &m.0, count: 16))
    }

    public var description: String {
        return debugDescription
    }

    public var debugDescription: String {
        return elements
            .enumerated()
            .map { i, v in
                if i % 4 == 0 {
                    return String(format: "\n%.6f", v)
                } else {
                    return String(format: "%.6f", v)
                }
        }
        .joined(separator: ",")
        .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
