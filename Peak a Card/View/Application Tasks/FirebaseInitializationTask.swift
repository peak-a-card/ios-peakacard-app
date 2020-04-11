import SwiftUI
import Firebase
import GoogleSignIn

class FirebaseInitializationTask: UIResponder, UIWindowSceneDelegate {

    let store: AppStore

    init(store: AppStore) {
        self.store = store
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
}

extension FirebaseInitializationTask: GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
        Auth.auth().signIn(with: credential) { result, error in
            if error != nil {
                return
            }
            guard let email = result?.user.email, let name = result?.user.displayName else { return }
            let user = User(id: user.userID, name: name, email: email)
            self.store.dispatch(action: .session(.authenticatedWithGoogle(user: user)))
        }
    }
}
