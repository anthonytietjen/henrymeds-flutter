import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // Delay hiding launch screen for 500 milliseconds
    usleep(500_000);
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
