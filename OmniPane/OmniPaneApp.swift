//
//  OmniPaneApp.swift
//  OmniPane
//
//  Created by Aishwarya Rana on 08/04/26.
//

import SwiftUI

@main
struct OmniPaneApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
