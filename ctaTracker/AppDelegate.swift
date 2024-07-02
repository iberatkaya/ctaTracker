//
//  AppDelegate.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 6/24/24.
//

import UIKit
import Intents

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        INPreferences.requestSiriAuthorization { _ in
        }

        return true
    }
}
