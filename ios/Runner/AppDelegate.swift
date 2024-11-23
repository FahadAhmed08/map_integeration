import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  //  GMSServices.provideAPIKey("AIzaSyAAFIfY60x_0emKLMGEz66Ocb_MVo4Wx0U")
   GMSServices.provideAPIKey("AIzaSyCAiXVOBP4z1KUQ3SjpFLhHiOXqQigeb8Y")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
