import UIKit
import Flutter
import Firebase
import FirebaseMessaging
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GMSServices.provideAPIKey("AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication,
          didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
              Messaging.messaging().apnsToken = deviceToken
//              if (kDebugMode) print("Token: \(deviceToken)")
              super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
          }
}
