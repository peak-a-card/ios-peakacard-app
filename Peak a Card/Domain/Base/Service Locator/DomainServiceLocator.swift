import Foundation

class BaseDomainServiceLocator {
    weak var root: DomainServiceLocator!
}

class DomainServiceLocator {

    private(set) static var shared = DomainServiceLocator.Builder().build()

    let data: DataServiceLocator
    let cards: CardsDomainServiceLocator
    let session: SessionDomainServiceLocator
    let participants: ParticipantDomainServiceLocator

    init(data: DataServiceLocator,
         cards: CardsDomainServiceLocator,
         session: SessionDomainServiceLocator,
         participants: ParticipantDomainServiceLocator) {
        self.data = data
        self.cards = cards
        self.session = session
        self.participants = participants

        cards.root = self
        session.root = self
        participants.root = self
    }
}

extension DomainServiceLocator {

    class Builder {

        private var data = DataServiceLocator.shared
        private var cards = CardsDomainServiceLocator()
        private var session = SessionDomainServiceLocator()
        private var participants = ParticipantDomainServiceLocator()

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

        func with(serviceLocator participants: ParticipantDomainServiceLocator) -> Builder {
            self.participants = participants
            return self
        }

        func build() -> DomainServiceLocator {
            return DomainServiceLocator(data: data,
                                        cards: cards,
                                        session: session,
                                        participants: participants
            )
        }
    }
}

