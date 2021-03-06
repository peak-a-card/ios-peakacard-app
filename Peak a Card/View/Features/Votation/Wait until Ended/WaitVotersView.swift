import SwiftUI

struct WaitVotersView: View {

    @EnvironmentObject var store: AppStore
    @State private var activityIndicatorIsAnimating = true
    @State private var showLogoutConfirmationAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Text("wait_voters_title")
                    .fontWeight(.medium)
                    .font(Stylesheet.font(.l))
                    .foregroundColor(Stylesheet.color(.primary))
                    .lineLimit(.none)
                    .padding(.top)

                List(self.store.state.participants) { participant in
                    HStack {
                        Text(participant.name)
                            .font(Stylesheet.font(.m))
                            .foregroundColor(Stylesheet.color(.primary))

                        if self.store.state.lastVotedVotation?.votations.first(where: { $0.participant == participant }) == nil {
                            ActivityIndicator(
                                isAnimating: self.$activityIndicatorIsAnimating,
                                style: .medium,
                                color: Stylesheet.color(.primary)
                            )
                        } else {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(Stylesheet.color(.success))
                                .padding(.init(top: 0, leading: Stylesheet.margin(.small), bottom: 0, trailing: 0))
                        }

                        if participant.id == self.store.state.user!.id {
                            Button(action: {
                                self.store.dispatch(action: .votation(.edit))
                            }) {
                                Image(systemName: "pencil.circle")
                                .foregroundColor(Stylesheet.color(.primary))
                                    .padding([.top, .bottom, .trailing])
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .background(Stylesheet.color(.background))
            .navigationBarTitle("app_name", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showLogoutConfirmationAlert = true
                }) {
                    Image(systemName: "power")
                        .foregroundColor(Stylesheet.color(.onPrimary))
                        .padding()
                }
                .alert(isPresented: $showLogoutConfirmationAlert) {
                    Alert(
                        title: Text("close_session_title"),
                        message: Text("close_session_message"),
                        primaryButton: .default(Text("close_session_no")),
                        secondaryButton: .destructive(Text("close_session_yes"), action: {
                            self.store.dispatch(action: .session(.participantLogout))
                        })
                    )
                }
            )
        }.onAppear {
            self.store.dispatch(action: .votation(.getAll))
        }
    }
}
