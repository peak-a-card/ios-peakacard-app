import Foundation

class BaseDataServiceLocator {
    weak var root: DataServiceLocator!
}

class DataServiceLocator {

    private(set) static var shared = DataServiceLocator.Builder().build()

    let cards: CardsDataServiceLocator
    let session: SessionDataServiceLocator

    init(cards: CardsDataServiceLocator,
         session: SessionDataServiceLocator) {
        self.cards = cards
        self.session = session

        cards.root = self
        session.root = self
    }
}

extension DataServiceLocator {

    class Builder {

        private var cards = CardsDataServiceLocator()
        private var session = SessionDataServiceLocator()

        func with(serviceLocator cards: CardsDataServiceLocator) -> Builder {
            self.cards = cards
            return self
        }

        func with(serviceLocator session: SessionDataServiceLocator) -> Builder {
            self.session = session
            return self
        }

        func build() -> DataServiceLocator {
            return DataServiceLocator(cards: cards, session: session)
        }
    }
}

