import SwiftUI

struct VotingResultsView: View {

    @EnvironmentObject var store: AppStore
    @State private var activityIndicatorIsAnimating = true
    @State private var showLogoutConfirmationAlert = false
    var results: [Participant: Card] {
        store.state.lastVotedVotation?.votations ?? [:]
    }

    var body: some View {
        NavigationView {
            VStack {
                Text(store.state.lastVotedVotation?.name ?? "")
                    .fontWeight(.medium)
                    .font(Stylesheet.font(.l))
                    .foregroundColor(Stylesheet.color(.primary))
                    .lineLimit(.none)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)
                List {
                    ForEach(Array(results.keys)) { key in
                        HStack {
                            Text(key.name)
                            Text(self.results[key]!.text)
                        }
                    }
                }
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
    }
}
