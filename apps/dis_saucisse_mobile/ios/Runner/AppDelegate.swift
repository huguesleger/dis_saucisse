import Flutter
import ImageIO
import UIKit
import UniformTypeIdentifiers

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "HeicConverter") {
      HeicConverter.register(with: registrar)
    }
  }
}

final class HeicConverter: NSObject, FlutterPlugin {
  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "fr.huguesleger.dissaucisse/heic",
      binaryMessenger: registrar.messenger()
    )
    registrar.addMethodCallDelegate(HeicConverter(), channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "toJpeg",
      let arguments = call.arguments as? [String: Any],
      let heic = arguments["bytes"] as? FlutterStandardTypedData,
      let quality = arguments["quality"] as? Double
    else {
      result(FlutterMethodNotImplemented)
      return
    }
    DispatchQueue.global(qos: .userInitiated).async {
      let jpeg = HeicConverter.jpeg(from: heic.data, quality: quality)
      DispatchQueue.main.async {
        if let jpeg {
          result(FlutterStandardTypedData(bytes: jpeg))
        } else {
          result(FlutterError(code: "conversion_failed", message: "HEIC could not be converted", details: nil))
        }
      }
    }
  }

  static func jpeg(from heic: Data, quality: Double) -> Data? {
    guard let source = CGImageSourceCreateWithData(heic as CFData, nil) else { return nil }
    let output = NSMutableData()
    guard
      let destination = CGImageDestinationCreateWithData(
        output, UTType.jpeg.identifier as CFString, 1, nil)
    else { return nil }
    CGImageDestinationAddImageFromSource(
      destination, source, 0,
      [kCGImageDestinationLossyCompressionQuality: quality] as CFDictionary)
    return CGImageDestinationFinalize(destination) ? output as Data : nil
  }
}
