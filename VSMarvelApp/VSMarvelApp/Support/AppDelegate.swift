
import Hero
import UIKit
import VCore

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate, WindowStyleable {
    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Hero.shared.containerColor = DSColor.secondary.uiColor

        let window = appContainer.resolve(UIWindow.self)
        let coordinator = appContainer.resolve(AppFactory.self).makeCoordinator(window)

        self.window = window
        self.coordinator = coordinator

        coordinator.start()
        window.makeKeyAndVisible()

        return true
    }

    func applicationWillTerminate(_: UIApplication) {
        cache.save()
    }
}
