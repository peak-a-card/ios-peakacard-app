import Foundation

class InMemoryCardsDataSource {

    private let cards = [
        CardDataModel(score: 0.0),
        CardDataModel(score: 0.5),
        CardDataModel(score: 1.0),
        CardDataModel(score: 2.0),
        CardDataModel(score: 3.0),
        CardDataModel(score: 5.0),
        CardDataModel(score: 8.0),
        CardDataModel(score: 13.0),
        CardDataModel(score: 20.0),
        CardDataModel(score: 40.0),
        CardDataModel(score: 100.0),
        CardDataModel(score: Float.infinity),
        CardDataModel(score: -1.0),
        CardDataModel(score: -2.0),
    ]

    func get() -> [CardDataModel] { cards }
}
