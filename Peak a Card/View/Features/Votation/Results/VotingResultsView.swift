import SwiftUI

struct VotingResultsView: View {

    @EnvironmentObject var store: AppStore
    @State private var activityIndicatorIsAnimating = true
    @State private var showLogoutConfirmationAlert = false
    private var results: [GroupedVotation] {
        let votations = store.state.lastVotedVotation?.votations ?? []

        let groupedResults = Dictionary(grouping: votations, by: { $0.card.id.score })
        let groupedVotations = groupedResults.map { key, value in
            return GroupedVotation(card: Card(score: key), participants: value.map { $0.participant })
        }
        return groupedVotations.sorted(by: { $0.card.id.score < $1.card.id.score })
    }
    private var mode: [Card] {
        store.state.lastVotedVotation?.mode ?? []
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Text(store.state.lastVotedVotation?.name ?? "")
                        .fontWeight(.medium)
                        .font(Stylesheet.font(.l))
                        .foregroundColor(Stylesheet.color(.primary))
                        .lineLimit(.none)
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                List(results, id: \.card) { group in
                    VStack(alignment: .leading) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Stylesheet.color(.primary))
                                .cornerRadius(8)
                            HStack {
                                Text(group.card.text)
                                    .padding(Stylesheet.margin(.medium))
                                    .foregroundColor(Stylesheet.color(.onPrimary))
                                    .font(Stylesheet.font(.l).weight(.medium))

                                Spacer()
                                Image(systemName: "person.3.fill")
                                    .foregroundColor(Stylesheet.color(.onPrimary))
                                    .padding(Stylesheet.margin(.medium))
                                    .opacity(self.mode.contains(group.card) ? 1.0 : 0.0)

                            }
                        }

                        ForEach(group.participants) { participant in
                            HStack {
                                Text(participant.name)
                                    .foregroundColor(.primary)
                                    .padding(.leading)
                                
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
                        }.padding(.top, Stylesheet.margin(.small))
                    }
                }
                .padding(.horizontal, -20)
                Spacer()
            }
            .padding(.horizontal)
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

struct VotingResultsView_Previews: PreviewProvider {
    static var previews: some View {
        VotingResultsView()
    }
}
