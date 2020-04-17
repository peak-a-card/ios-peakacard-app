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

        store.dispatch(action: .session(.authenticatingWithGoogle))
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
        Auth.auth().signIn(with: credential) { result, error in
            if error != nil {
                return
            }
            guard let resultUser = result?.user else { return }
            let user = User(id: resultUser.uid, name: resultUser.displayName!, email: resultUser.email!)
            self.store.dispatch(action: .session(.authenticatedWithGoogle(user: user)))
        }
    }
}
