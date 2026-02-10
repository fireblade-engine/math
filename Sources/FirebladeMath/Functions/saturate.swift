/// Returns x, where 0.0 ≤ x ≤ 1.0
public func saturate<Value: BinaryFloatingPoint>(_ x: Value) -> Value {
    clamp(x, min: 0.0, max: 1.0)
}
