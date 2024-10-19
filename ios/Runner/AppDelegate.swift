import Flutter
import UIKit
import GoogleMaps  // Importa el paquete de Google Maps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GMSServices.provideAPIKey("AIzaSyDYMS4cdyIBc8Y9bzrNNM8G8UI69rzS04U")  // Aquí agrega tu clave API de Google Maps
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
