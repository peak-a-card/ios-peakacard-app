import SwiftUI

struct ContainerView: View {

    @EnvironmentObject var store: AppStore

    var body: some View {
        ZStack {
            ZStack {
                if store.state.waitingForParticipants {
                    WaitVotingView().environmentObject(store)
                } else if !store.state.startedVotations.isEmpty &&
                    store.state.lastVotedVotation != nil &&
                    store.state.startedVotations.first!.alreadyVoted &&
                    !store.state.edit {
                    WaitVotersView().environmentObject(store)
                } else if store.state.startedVotations.isEmpty &&
                    store.state.lastVotedVotation != nil &&
                    !store.state.edit {
                    VotingResultsView().environmentObject(store)
                } else if (store.state.sessionId != nil &&
                    store.state.user != nil &&
                    !store.state.startedVotations.isEmpty) ||
                    store.state.edit {
                    CardsView().environmentObject(store)
                } else {
                    JoinSessionView().environmentObject(store)
                }
            }.blur(radius: store.state.shouldWait ? 15 : 0)

            if store.state.shouldWait {
                LoadingView()
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
