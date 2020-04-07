import UIKit
import SwiftUI
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContainerView().environmentObject(AppStore())

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = HostingController(rootView: AnyView(contentView))
            setupNavigationBar()
            setupFirebase()
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    // TODO: Move it to an environment style scene task object
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = Stylesheet.color(.primary)
        let titleColor: UIColor = Stylesheet.color(.onPrimary)
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    }

    // TODO: Move it to a Firebase initialization task
    private func setupFirebase() {
        FirebaseApp.configure()
    }
}

