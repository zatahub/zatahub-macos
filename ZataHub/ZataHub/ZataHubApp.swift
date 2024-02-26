//
//  ZataHubApp.swift
//  ZataHub
//
//  Created by Macbook on 26/01/2024.
//

import SwiftUI

@main
struct ZataHubApp: App {
    @State var installViewHeight: CGFloat = 600

    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: LocalStorageKeys.isAlreadyInstalled.rawValue) {
                LoginView()
                    .frame(width: 1097, height: 652)
                    .fixedSize()
            } else {
                InstallView()
                    .fixedSize()
            }
        }
        .windowResizabilityContentSize()
    }
}
