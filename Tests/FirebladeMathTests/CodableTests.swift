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
