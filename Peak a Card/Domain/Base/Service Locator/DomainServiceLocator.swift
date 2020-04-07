import Foundation

class BaseDomainServiceLocator {
    weak var root: DomainServiceLocator!
}

class DomainServiceLocator {

    private(set) static var shared = DomainServiceLocator.Builder().build()

    let data: DataServiceLocator
    let cards: CardsDomainServiceLocator
    let session: SessionDomainServiceLocator

    init(data: DataServiceLocator,
         cards: CardsDomainServiceLocator,
         session: SessionDomainServiceLocator) {
        self.data = data
        self.cards = cards
        self.session = session

        cards.root = self
        session.root = self
    }
}

extension DomainServiceLocator {

    class Builder {

        private var data = DataServiceLocator.shared
        private var cards = CardsDomainServiceLocator()
        private var session = SessionDomainServiceLocator()

        func with(serviceLocator data: DataServiceLocator) -> Builder {
            self.data = data
            return self
        }

        func with(serviceLocator cards: CardsDomainServiceLocator) -> Builder {
            self.cards = cards
            return self
        }

        func with(serviceLocator session: SessionDomainServiceLocator) -> Builder {
            self.session = session
            return self
        }

        func build() -> DomainServiceLocator {
            return DomainServiceLocator(data: data,
                                        cards: cards,
                                        session: session
            )
        }
    }
}

