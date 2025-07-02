public enum CellShape: Int {
    case square = 0
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case empty

    static func from(_ value: Int) -> CellShape {
        return CellShape(rawValue: value % 6) ?? .square
    }
}

public enum IdenticonStyle: Int {
    case simple  // square-only
    case sharp  // includes triangles
    case dots  // circles
    case rounded  // quarter circles
}
