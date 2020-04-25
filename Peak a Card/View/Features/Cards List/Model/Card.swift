import Foundation

struct Card: Codable, Identifiable, Hashable {

    enum Identifier: String, Codable, CaseIterable {
        case zero = "0"
        case half = "1/2"
        case one = "1"
        case two = "2"
        case three = "3"
        case five = "5"
        case eight = "8"
        case thirteen = "13"
        case twenty = "20"
        case fourty = "40"
        case hundred = "100"
        case infinity = "∞"
        case unknown = "?"
        case coffee = "☕️"

        init(from score: Float) {
            switch score {
            case 0.0: self = .zero
            case 0.5: self = .half
            case 1.0: self = .one
            case 2.0: self = .two
            case 3.0: self = .three
            case 5.0: self = .five
            case 8.0: self = .eight
            case 13.0: self = .thirteen
            case 20.0: self = .twenty
            case 40.0: self = .fourty
            case 100.0: self = .hundred
            case 999.0: self = .infinity
            case -1.0: self = .unknown
            case -2.0: self = .coffee
            default: self = .unknown
            }
        }

        var score: Float {
            switch self {
            case .zero: return 0.0
            case .half: return 0.5
            case .one: return 1.0
            case .two: return 2.0
            case .three: return 3.0
            case .five: return 5.0
            case .eight: return 8.0
            case .thirteen: return 13.0
            case .twenty: return 20.0
            case .fourty: return 40.0
            case .hundred: return 100.0
            case .infinity: return 999.0
            case .unknown: return -1.0
            case .coffee: return -2.0
            }
        }
    }

    let id: Card.Identifier
    var text: String {
        return id.rawValue
    }

    init(score: Float) {
        self.id = Card.Identifier(from: score)
    }

    init(id: Card.Identifier) {
        self.id = id
    }
}
