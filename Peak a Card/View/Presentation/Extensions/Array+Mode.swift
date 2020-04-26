import Foundation

extension Array where Element == Float {

    func mode() -> [Float] {
        let grouped = Dictionary(grouping: self, by: { $0 })
        if let maxGroup = grouped.max(by: { $0.value.count < $1.value.count }) {
            let maxGroups = grouped.filter { $0.value.count == maxGroup.value.count }
            print(maxGroups.map { $0.key })
            return maxGroups.map { $0.key }
        }

        return []
    }
}
