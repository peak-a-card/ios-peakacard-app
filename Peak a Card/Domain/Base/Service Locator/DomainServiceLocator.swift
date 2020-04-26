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
    let votations: VotationDomainServiceLocator
    let user: UserDomainServiceLocator

    init(data: DataServiceLocator,
         cards: CardsDomainServiceLocator,
         session: SessionDomainServiceLocator,
         participants: ParticipantDomainServiceLocator,
         votations: VotationDomainServiceLocator,
         user: UserDomainServiceLocator) {
        self.data = data
        self.cards = cards
        self.session = session
        self.participants = participants
        self.votations = votations
        self.user = user

        cards.root = self
        session.root = self
        participants.root = self
        votations.root = self
        user.root = self
    }
}

extension DomainServiceLocator {

    class Builder {

        private var data = DataServiceLocator.shared
        private var cards = CardsDomainServiceLocator()
        private var session = SessionDomainServiceLocator()
        private var participants = ParticipantDomainServiceLocator()
        private var votations = VotationDomainServiceLocator()
        private var user = UserDomainServiceLocator()

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

        func with(serviceLocator votations: VotationDomainServiceLocator) -> Builder {
            self.votations = votations
            return self
        }

        func with(serviceLocator user: UserDomainServiceLocator) -> Builder {
            self.user = user
            return self
        }

        func build() -> DomainServiceLocator {
            return DomainServiceLocator(data: data,
                                        cards: cards,
                                        session: session,
                                        participants: participants,
                                        votations: votations,
                                        user: user
            )
        }
    }
}

