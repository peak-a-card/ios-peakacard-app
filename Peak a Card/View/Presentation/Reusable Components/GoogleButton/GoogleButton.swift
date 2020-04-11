import SwiftUI
import GoogleSignIn

struct GoogleButton: UIViewRepresentable {

    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }

    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
}
