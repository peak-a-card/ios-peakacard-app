import Foundation

class BaseDataServiceLocator {
    weak var root: DataServiceLocator!
}

class DataServiceLocator {

    private(set) static var shared = DataServiceLocator.Builder().build()

    let cards: CardsDataServiceLocator

    init(cards: CardsDataServiceLocator) {
        self.cards = cards

        cards.root = self
    }
}

extension DataServiceLocator {

    class Builder {

        private var cards = CardsDataServiceLocator()

        func with(serviceLocator cards: CardsDataServiceLocator) -> Builder {
            self.cards = cards
            return self
        }

        func build() -> DataServiceLocator {
            return DataServiceLocator(cards: cards)
        }
    }
}

