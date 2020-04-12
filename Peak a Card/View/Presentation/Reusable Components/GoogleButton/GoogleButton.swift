import SwiftUI
import GoogleSignIn

struct GoogleButton: View {
    var body: some View {
        Button(action: {
            GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
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
                .stroke(Color.gray, lineWidth: 0.5))
        .foregroundColor(Color.gray)
        .background(Color.white)
    }
}

struct GoogleButton_Previews: PreviewProvider {
    static var previews: some View {
        GoogleButton()
    }
}
