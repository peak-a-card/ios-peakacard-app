import Foundation

class BaseDataServiceLocator {
    weak var root: DataServiceLocator!
}

class DataServiceLocator {

    private(set) static var shared = DataServiceLocator.Builder().build()

    let cards: CardsDataServiceLocator
    let session: SessionDataServiceLocator
    let participants: ParticipantDataServiceLocator
    let votations: VotationDataServiceLocator

    init(cards: CardsDataServiceLocator,
         session: SessionDataServiceLocator,
         participants: ParticipantDataServiceLocator,
         votations: VotationDataServiceLocator) {
        self.cards = cards
        self.session = session
        self.participants = participants
        self.votations = votations

        cards.root = self
        session.root = self
        participants.root = self
        votations.root = self
    }
}

extension DataServiceLocator {

    class Builder {

        private var cards = CardsDataServiceLocator()
        private var session = SessionDataServiceLocator()
        private var participants = ParticipantDataServiceLocator()
        private var votations = VotationDataServiceLocator()

        func with(serviceLocator cards: CardsDataServiceLocator) -> Builder {
            self.cards = cards
            return self
        }

        func with(serviceLocator session: SessionDataServiceLocator) -> Builder {
            self.session = session
            return self
        }

        func with(serviceLocator participants: ParticipantDataServiceLocator) -> Builder {
            self.participants = participants
            return self
        }

        func with(serviceLocator votations: VotationDataServiceLocator) -> Builder {
            self.votations = votations
            return self
        }

        func build() -> DataServiceLocator {
            return DataServiceLocator(
                cards: cards,
                session: session,
                participants: participants,
                votations: votations
            )
        }
    }
}

