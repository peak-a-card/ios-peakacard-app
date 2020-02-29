import Foundation

class BaseDomainServiceLocator {
    weak var root: DomainServiceLocator!
}

class DomainServiceLocator {

    private(set) static var shared = DomainServiceLocator.Builder().build()

    let data: DataServiceLocator
    let cards: CardsDomainServiceLocator

    init(data: DataServiceLocator,
         cards: CardsDomainServiceLocator) {
        self.data = data
        self.cards = cards

        cards.root = self
    }
}

extension DomainServiceLocator {

    class Builder {

        private var data = DataServiceLocator.shared
        private var cards = CardsDomainServiceLocator()

        func with(serviceLocator data: DataServiceLocator) -> Builder {
            self.data = data
            return self
        }

        func with(serviceLocator cards: CardsDomainServiceLocator) -> Builder {
            self.cards = cards
            return self
        }

        func build() -> DomainServiceLocator {
            return DomainServiceLocator(data: data,
                                        cards: cards)
        }
    }
}

