import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var tasks: [UIWindowSceneDelegate] = []

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let store = AppStore()
        initializeTasks(with: store)
        for task in tasks {
            task.scene?(scene, willConnectTo: session, options: connectionOptions)
        }
        let contentView = ContainerView().environmentObject(store)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = HostingController(rootView: AnyView(contentView))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    private func initializeTasks(with store: AppStore) {
        tasks = [
            AppearanceSetupTask(),
            FirebaseInitializationTask(store: store),
        ]
    }
}
