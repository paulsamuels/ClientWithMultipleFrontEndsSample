import Shared
import UIKit

// This is by no means an example of a reasonable AppDelegate.
// The emphasis in this sample project is to keep the code as light/simple as
// possible so it doesn't get in the way of the higher level topic.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let client = makeClient()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        
        window.rootViewController = PeopleViewController(fetch: client.fetch)
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}
