import SwiftUI

struct ContainerView: View {

    @EnvironmentObject var store: AppStore

    var body: some View {
        ZStack {
            if store.state.sessionId != nil &&
                store.state.user != nil &&
                !store.state.votations.isEmpty {
                CardsView().environmentObject(store)
            } else if store.state.waitingForParticipants {
                WaitVotingView().environmentObject(store)
            } else {
                JoinSessionView().environmentObject(store)
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
