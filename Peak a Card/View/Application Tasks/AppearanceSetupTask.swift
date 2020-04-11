import UIKit

class AppearanceSetupTask: UIResponder, UIWindowSceneDelegate {

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = Stylesheet.color(.primary)
        let titleColor: UIColor = Stylesheet.color(.onPrimary)
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    }
}
