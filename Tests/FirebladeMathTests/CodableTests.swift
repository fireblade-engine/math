import Testing
import Foundation
@testable import FirebladeMath

@Suite struct CodableTests {
    private func roundTrip<T: Codable & Equatable>(_ value: T) throws {
        let data = try JSONEncoder().encode(value)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        #expect(decoded == value)
    }

    private func encodedValues<T: Encodable, Scalar: Decodable>(_ value: T, as _: Scalar.Type) throws -> [Scalar] {
        try JSONDecoder().decode([Scalar].self, from: JSONEncoder().encode(value))
    }

    private func expectDataCorrupted<T: Decodable>(_: T.Type, json: String) {
        #expect {
            try JSONDecoder().decode(T.self, from: Data(json.utf8))
        } throws: { error in
            guard case DecodingError.dataCorrupted = error else {
                return false
            }
            return true
        }
    }

    private func expectKeyNotFound<T: Decodable>(_: T.Type, json: String) {
        #expect {
            try JSONDecoder().decode(T.self, from: Data(json.utf8))
        } throws: { error in
            guard case DecodingError.keyNotFound = error else {
                return false
            }
            return true
        }
    }

    // MARK: - Precision

    /// 16 values that are not exactly representable as short decimals or sit at the edges of the format.
    private func edgeValues<Scalar: BinaryFloatingPoint>(_: Scalar.Type) -> [Scalar] {
        [
            .pi, -.pi, .ulpOfOne, Scalar(1).nextUp,
            Scalar(1).nextDown, .leastNonzeroMagnitude, .leastNormalMagnitude, .greatestFiniteMagnitude,
            -.greatestFiniteMagnitude, -0.0, Scalar(1) / 3, Scalar(2) / 3,
            Scalar(0.1), Scalar(1e-7), Scalar(12_345.678), -.leastNonzeroMagnitude,
        ]
    }

    /// Encodes and decodes `value` and expects every component to come back bit for bit.
    /// Equal value and equal sign is bit-exact for non-NaN floats (it tells -0.0 from 0.0).
    private func expectLossless<T: Codable, Scalar: BinaryFloatingPoint>(
        _ value: T,
        values: [Scalar],
        decodedValues: (T) -> [Scalar]
    ) throws {
        let decoded = try JSONDecoder().decode(T.self, from: JSONEncoder().encode(value))
        let actual = decodedValues(decoded)
        #expect(actual == values)
        #expect(actual.map(\.sign) == values.map(\.sign))
    }

    @Test func matricesKeepFullPrecision() throws {
        let floats = edgeValues(Float.self)
        let doubles = edgeValues(Double.self)
        try expectLossless(Mat2x2f(Array(floats.prefix(4))), values: Array(floats.prefix(4))) { $0.elements }
        try expectLossless(Mat2x2d(Array(doubles.prefix(4))), values: Array(doubles.prefix(4))) { $0.elements }
        try expectLossless(Mat3x3f(Array(floats.suffix(9))), values: Array(floats.suffix(9))) { $0.elements }
        try expectLossless(Mat3x3d(Array(doubles.suffix(9))), values: Array(doubles.suffix(9))) { $0.elements }
        try expectLossless(Mat4x4f(floats), values: floats) { $0.elements }
        try expectLossless(Mat4x4d(doubles), values: doubles) { $0.elements }
    }

    @Test func quaternionsKeepFullPrecision() throws {
        let floats = Array(edgeValues(Float.self).suffix(4))
        let doubles = Array(edgeValues(Double.self).suffix(4))
        try expectLossless(Quat4f(floats[0], floats[1], floats[2], floats[3]), values: floats) { $0.elements }
        try expectLossless(Quat4d(doubles[0], doubles[1], doubles[2], doubles[3]), values: doubles) { $0.elements }
    }

    @Test func vectorsKeepFullPrecision() throws {
        let floats = edgeValues(Float.self)
        let doubles = edgeValues(Double.self)
        try expectLossless(Vec2f(floats[0], floats[1]), values: Array(floats[0..<2])) { [$0.x, $0.y] }
        try expectLossless(Vec2d(doubles[0], doubles[1]), values: Array(doubles[0..<2])) { [$0.x, $0.y] }
        try expectLossless(Vec3f(floats[2], floats[3], floats[4]), values: Array(floats[2..<5])) { [$0.x, $0.y, $0.z] }
        try expectLossless(Vec3d(doubles[2], doubles[3], doubles[4]), values: Array(doubles[2..<5])) { [$0.x, $0.y, $0.z] }
        try expectLossless(Vec4f(floats[5], floats[6], floats[7], floats[9]), values: [floats[5], floats[6], floats[7], floats[9]]) { [$0.x, $0.y, $0.z, $0.w] }
        try expectLossless(Vec4d(doubles[5], doubles[6], doubles[7], doubles[9]), values: [doubles[5], doubles[6], doubles[7], doubles[9]]) { [$0.x, $0.y, $0.z, $0.w] }
    }

    @Test func geometryKeepsFullPrecision() throws {
        let floats = edgeValues(Float.self)
        let doubles = edgeValues(Double.self)
        try expectLossless(Point<Float>(x: floats[0], y: floats[5]), values: [floats[0], floats[5]]) { [$0.x, $0.y] }
        try expectLossless(Size<Double>(width: doubles[10], height: doubles[9]), values: [doubles[10], doubles[9]]) { [$0.width, $0.height] }
        try expectLossless(Rect<Double>(x: doubles[0], y: doubles[4], width: doubles[12], height: doubles[7]),
                           values: [doubles[0], doubles[4], doubles[12], doubles[7]]) { [$0.x, $0.y, $0.width, $0.height] }
    }

    // MARK: - Matrices

    @Test func mat2x2RoundTrip() throws {
        try roundTrip(Mat2x2f([1, 2, 3, 4]))
        try roundTrip(Mat2x2d([1, 2, 3, 4]))
    }

    @Test func mat3x3RoundTrip() throws {
        try roundTrip(Mat3x3f((1...9).map(Float.init)))
        try roundTrip(Mat3x3d((1...9).map(Double.init)))
    }

    @Test func mat4x4RoundTrip() throws {
        try roundTrip(Mat4x4f((1...16).map(Float.init)))
        try roundTrip(Mat4x4d((1...16).map(Double.init)))
    }

    @Test func matricesEncodeFlatColumnMajor() throws {
        let mat2 = Mat2x2f(Vec2f(1, 2), Vec2f(3, 4))
        #expect(try encodedValues(mat2, as: Float.self) == [1, 2, 3, 4])

        let mat3 = Mat3x3d(Vec3d(1, 2, 3), Vec3d(4, 5, 6), Vec3d(7, 8, 9))
        #expect(try encodedValues(mat3, as: Double.self) == [1, 2, 3, 4, 5, 6, 7, 8, 9])

        let mat4 = Mat4x4f(Vec4f(1, 2, 3, 4), Vec4f(5, 6, 7, 8), Vec4f(9, 10, 11, 12), Vec4f(13, 14, 15, 16))
        #expect(try encodedValues(mat4, as: Float.self) == (1...16).map(Float.init))
    }

    @Test func mat2x2WrongCountThrows() {
        expectDataCorrupted(Mat2x2f.self, json: "[1,2,3]")
        expectDataCorrupted(Mat2x2d.self, json: "[1,2,3,4,5]")
    }

    @Test func mat3x3WrongCountThrows() {
        expectDataCorrupted(Mat3x3f.self, json: "[1,2,3,4,5,6,7,8]")
        expectDataCorrupted(Mat3x3d.self, json: "[1,2,3,4,5,6,7,8,9,10]")
    }

    @Test func mat4x4WrongCountThrows() {
        expectDataCorrupted(Mat4x4f.self, json: "[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]")
        expectDataCorrupted(Mat4x4d.self, json: "[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]")
    }

    // MARK: - Quaternions

    @Test func quaternionRoundTrip() throws {
        try roundTrip(Quat4f(1, 2, 3, 4))
        try roundTrip(Quat4d(1, 2, 3, 4))
    }

    @Test func quaternionEncodesXYZW() throws {
        #expect(try encodedValues(Quat4f(1, 2, 3, 4), as: Float.self) == [1, 2, 3, 4])
        #expect(try encodedValues(Quat4d(1, 2, 3, 4), as: Double.self) == [1, 2, 3, 4])
    }

    @Test func quaternionWrongCountThrows() {
        expectDataCorrupted(Quat4f.self, json: "[1,2,3]")
        expectDataCorrupted(Quat4d.self, json: "[1,2,3,4,5]")
    }

    // MARK: - Vectors

    @Test func vectorRoundTrip() throws {
        try roundTrip(Vec2f(1, 2))
        try roundTrip(Vec2d(1, 2))
        try roundTrip(Vec2i(1, 2))
        try roundTrip(Vec2u(1, 2))
        try roundTrip(Vec3f(1, 2, 3))
        try roundTrip(Vec3d(1, 2, 3))
        try roundTrip(Vec3i(1, 2, 3))
        try roundTrip(Vec3u(1, 2, 3))
        try roundTrip(Vec4f(1, 2, 3, 4))
        try roundTrip(Vec4d(1, 2, 3, 4))
        try roundTrip(Vec4i(1, 2, 3, 4))
        try roundTrip(Vec4u(1, 2, 3, 4))
    }

    @Test func vectorWrongCountThrows() {
        expectDataCorrupted(Vec2f.self, json: "[1]")
        expectDataCorrupted(Vec2d.self, json: "[1,2,3]")
        expectDataCorrupted(Vec2i.self, json: "[1]")
        expectDataCorrupted(Vec2u.self, json: "[1,2,3]")
        expectDataCorrupted(Vec3f.self, json: "[1,2]")
        expectDataCorrupted(Vec3d.self, json: "[1,2,3,4]")
        expectDataCorrupted(Vec3i.self, json: "[1,2]")
        expectDataCorrupted(Vec3u.self, json: "[1,2,3,4]")
        expectDataCorrupted(Vec4f.self, json: "[1,2,3]")
        expectDataCorrupted(Vec4d.self, json: "[1,2,3,4,5]")
        expectDataCorrupted(Vec4i.self, json: "[1,2,3]")
        expectDataCorrupted(Vec4u.self, json: "[1,2,3,4,5]")
    }

    // MARK: - Point, Size, Rect

    @Test func geometryRoundTrip() throws {
        try roundTrip(Point<Float>(x: 1, y: 2))
        try roundTrip(Size<Double>(width: 3, height: 4))
        try roundTrip(Rect<Int>(x: 1, y: 2, width: 3, height: 4))
    }

    /// Point, Size and Rect encode as keyed objects, so a missing component is a missing key.
    @Test func geometryMissingComponentThrows() {
        expectKeyNotFound(Point<Float>.self, json: #"{"x":1}"#)
        expectKeyNotFound(Size<Double>.self, json: #"{"width":3}"#)
        expectKeyNotFound(Rect<Int>.self, json: #"{"origin":{"x":1,"y":2}}"#)
    }
}
