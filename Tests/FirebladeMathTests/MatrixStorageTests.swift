import Testing
@testable import FirebladeMath

@Suite struct MatrixStorageTests {
    @Test func storage2x2() {
        var m = Mat2x2f.identity
        #expect(m.startIndex == 0)
        #expect(m.endIndex == 4)
        #expect(m.index(after: 0) == 1)
        
        m.replaceSubrange(0..<2, with: [5.0, 6.0])
        #expect(m[0] == 5.0)
        #expect(m[1] == 6.0)

        var md = Mat2x2d.identity
        md.replaceSubrange(2..<4, with: [7.0, 8.0])
        #expect(md[2] == 7.0)
        #expect(md[3] == 8.0)
    }

    @Test func storage3x3() {
        var m = Mat3x3f.identity
        #expect(m.startIndex == 0)
        #expect(m.endIndex == 9)
        #expect(m.index(after: 4) == 5)
        
        m.replaceSubrange(0..<3, with: [1.0, 2.0, 3.0])
        #expect(m[0] == 1.0)
        #expect(m[1] == 2.0)
        #expect(m[2] == 3.0)

        var md = Mat3x3d.identity
        md.replaceSubrange(6..<9, with: [4.0, 5.0, 6.0])
        #expect(md[6] == 4.0)
        #expect(md[7] == 5.0)
        #expect(md[8] == 6.0)
    }

    @Test func storage4x4() {
        var m = Mat4x4f.identity
        #expect(m.startIndex == 0)
        #expect(m.endIndex == 16)
        #expect(m.index(after: 10) == 11)
        
        m.replaceSubrange(0..<4, with: [1.0, 2.0, 3.0, 4.0])
        #expect(m[0] == 1.0)
        #expect(m[1] == 2.0)
        #expect(m[2] == 3.0)
        #expect(m[3] == 4.0)

        var md = Mat4x4d.identity
        md.replaceSubrange(12..<16, with: [5.0, 6.0, 7.0, 8.0])
        #expect(md[12] == 5.0)
        #expect(md[13] == 6.0)
        #expect(md[14] == 7.0)
        #expect(md[15] == 8.0)
    }

    @Test func storageSubscripts() {
        // 2x2
        var m2f = Mat2x2f.identity
        for i in 0..<4 { m2f[i] = Float(i) }
        for i in 0..<4 { #expect(m2f[i] == Float(i)) }
        
        var m2d = Mat2x2d.identity
        for i in 0..<4 { m2d[i] = Double(i) }
        for i in 0..<4 { #expect(m2d[i] == Double(i)) }

        // 3x3
        var m3f = Mat3x3f.identity
        for i in 0..<9 { m3f[i] = Float(i) }
        for i in 0..<9 { #expect(m3f[i] == Float(i)) }

        var m3d = Mat3x3d.identity
        for i in 0..<9 { m3d[i] = Double(i) }
        for i in 0..<9 { #expect(m3d[i] == Double(i)) }

        // 4x4
        var m4f = Mat4x4f.identity
        for i in 0..<16 { m4f[i] = Float(i) }
        for i in 0..<16 { #expect(m4f[i] == Float(i)) }

        var m4d = Mat4x4d.identity
        for i in 0..<16 { m4d[i] = Double(i) }
        for i in 0..<16 { #expect(m4d[i] == Double(i)) }
    }

    @Test func storageColumns() {
        let m2 = Mat2x2f.identity
        #expect(m2.columns.0 == [1, 0])
        #expect(m2.columns.1 == [0, 1])

        let m3 = Mat3x3f.identity
        #expect(m3.columns.0 == [1, 0, 0])
        #expect(m3.columns.1 == [0, 1, 0])
        #expect(m3.columns.2 == [0, 0, 1])

        let m4 = Mat4x4f.identity
        #expect(m4.columns.0 == [1, 0, 0, 0])
        #expect(m4.columns.1 == [0, 1, 0, 0])
        #expect(m4.columns.2 == [0, 0, 1, 0])
        #expect(m4.columns.3 == [0, 0, 0, 1])
    }

    @Test func allSubscripts() {
        // Mat2x2f
        var m2f = Mat2x2f.identity
        for c in 0..<2 { for r in 0..<2 { m2f[c, r] = Float(c * 2 + r) } }
        for c in 0..<2 { for r in 0..<2 { #expect(m2f[c, r] == Float(c * 2 + r)) } }

        // Mat2x2d
        var m2d = Mat2x2d.identity
        for c in 0..<2 { for r in 0..<2 { m2d[c, r] = Double(c * 2 + r) } }
        for c in 0..<2 { for r in 0..<2 { #expect(m2d[c, r] == Double(c * 2 + r)) } }

        // Mat3x3f
        var m3f = Mat3x3f.identity
        for c in 0..<3 { for r in 0..<3 { m3f[c, r] = Float(c * 3 + r) } }
        for c in 0..<3 { for r in 0..<3 { #expect(m3f[c, r] == Float(c * 3 + r)) } }

        // Mat3x3d
        var m3d = Mat3x3d.identity
        for c in 0..<3 { for r in 0..<3 { m3d[c, r] = Double(c * 3 + r) } }
        for c in 0..<3 { for r in 0..<3 { #expect(m3d[c, r] == Double(c * 3 + r)) } }

        // Mat4x4f
        var m4f = Mat4x4f.identity
        for c in 0..<4 { for r in 0..<4 { m4f[c, r] = Float(c * 4 + r) } }
        for c in 0..<4 { for r in 0..<4 { #expect(m4f[c, r] == Float(c * 4 + r)) } }

        // Mat4x4d
        var m4d = Mat4x4d.identity
        for c in 0..<4 { for r in 0..<4 { m4d[c, r] = Double(c * 4 + r) } }
        for c in 0..<4 { for r in 0..<4 { #expect(m4d[c, r] == Double(c * 4 + r)) } }
    }
}
