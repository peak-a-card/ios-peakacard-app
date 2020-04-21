import SwiftUI

struct WaitVotingView: View {

    @EnvironmentObject var store: AppStore
    @State private var activityIndicatorIsAnimating = true
    @State private var showLogoutConfirmationAlert = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("wait_voting_start_title")
                        .fontWeight(.medium)
                        .font(Stylesheet.font(.l))
                        .foregroundColor(Stylesheet.color(.primary))
                        .lineLimit(.none)
                    ActivityIndicator(
                        isAnimating: self.$activityIndicatorIsAnimating,
                        style: .medium,
                        color: Stylesheet.color(.primary)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)

                List(self.store.state.participants) { participant in
                    Text(participant.name)
                        .font(Stylesheet.font(.m))
                        .foregroundColor(Stylesheet.color(.primary))
                }
                .background(Stylesheet.color(.background))
                .onAppear {
                    UITableView.appearance().tableFooterView = UIView()
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().bounces = false
                    UITableViewCell.appearance().backgroundColor = Stylesheet.color(.background)
                    UITableView.appearance().backgroundColor = Stylesheet.color(.background)
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
        .edgesIgnoringSafeArea(.bottom)
    }
}
