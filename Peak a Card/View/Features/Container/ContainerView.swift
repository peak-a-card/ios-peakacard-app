import SwiftUI

struct ContainerView: View {

    @EnvironmentObject var store: AppStore

    var body: some View {
        ZStack {
            if store.state.session != nil {
                CardsView().environmentObject(store)
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
