import SwiftUI
import GoogleSignIn

struct GoogleButton: View {

    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
            UIApplication.shared.endEditing()
            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
            GIDSignIn.sharedInstance()?.signIn()
        }) {
            HStack {
                Image("googleIcon")
                Text("join_session_sign_in_with_google")
                    .font(Stylesheet.font(.m))
            }.frame(maxWidth: .infinity)
        }
        .padding(Stylesheet.margin(.medium))
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.gray, lineWidth: 0.5)
                .foregroundColor(Color.white))
        .foregroundColor(Color.gray)
        .background(Color.clear)
    }
}
