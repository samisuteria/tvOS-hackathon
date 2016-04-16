import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("BaypxnZmrMIhrf1AtksDExScEwA0C9vxA1pJ6Gsx", clientKey: "oAO2pmUq1pzvWw4rqCItWR6BlumjJyFDTsbqVw3S")
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = HomeScreen()
        window?.makeKeyAndVisible()
        
        return true
    }
}