import SwiftUI

struct JoinSessionView: View {

    @EnvironmentObject var store: AppStore
    @State var username: String = ""
    @State var code: String = ""
    @State var activityAnimatorIsAnimating = true

    var body: some View {
        NavigationView {
            VStack {
                Text("join_session_join")
                    .fontWeight(.medium)
                    .font(Stylesheet.font(.h3))
                    .foregroundColor(Stylesheet.color(.primary))
                    .lineLimit(.none)
                    .padding(.top)

                TextField("join_session_name", text: $username)
                    .textContentType(.name)
                    .keyboardType(.namePhonePad)
                    .padding()
                    .background(Stylesheet.color(.background))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Stylesheet.color(.primary), lineWidth: 1.5))
                    .padding(.bottom)
                    .disabled(store.state.isRequestingSession)

                TextField("join_session_code", text: $code)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Stylesheet.color(.background))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Stylesheet.color(.primary), lineWidth: 1.5))
                    .padding(.bottom)
                    .disabled(store.state.isRequestingSession)

                Button(action: {
                    self.store.dispatch(action: .session(.start))
                }) {
                    HStack {
                        Text("join_session_enter")
                        if store.state.isRequestingSession {
                            ActivityIndicator(
                                isAnimating: self.$activityAnimatorIsAnimating, style: .medium
                            )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(Stylesheet.color(.onPrimary))
                    .background(Stylesheet.color(.primary))
                    .cornerRadius(8.0)
                }
                Spacer()
            }
            .padding()
            .background(Stylesheet.color(.background))
            .navigationBarTitle("app_name", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct JoinSessionView_Previews: PreviewProvider {
    static var previews: some View {
        JoinSessionView()
    }
}
