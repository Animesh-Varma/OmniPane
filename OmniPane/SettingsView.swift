//
//  SettingsView.swift
//  OmniPane
//
//  Created by Aishwarya Rana on 09/04/26.
//

import SwiftUI
import ServiceManagement
import KeyboardShortcuts

struct SettingsView: View {
    @AppStorage("showFileDrop") private var showFileDrop = true
    @AppStorage("showScratchNotes") private var showScratchNotes = true
    
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Access Settings").opacity(0.8)
                Divider()
                Toggle("Launch at Login", isOn: $launchAtLogin)
                    .onChange(of: launchAtLogin) { newValue in
                        do {
                            if newValue {
                                try SMAppService.mainApp.register()
                            } else {
                                try SMAppService.mainApp.unregister()
                            }
                        } catch {
                            print("Unable to update Launch at Login: \(error)")
                        }
                    }
                HStack {
                    Text("Choose Shortcut: ")
                    KeyboardShortcuts.Recorder(for: .toggleApp)
                }
            }
            
//            Spacer().frame(height: 10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Utilities").opacity(0.8)
                Divider()
                Toggle("File Drop", isOn: $showFileDrop)
                Toggle("Scratch Notes", isOn: $showScratchNotes)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Coming Soon").opacity(0.4)
                Divider()
                Toggle("Color Assistant", isOn: .constant(false)).disabled(true)
                Toggle("Clipboard Manager", isOn: .constant(false)).disabled(true)
                Toggle("Screenshot Manager", isOn: .constant(false)).disabled(true)
            }
            Spacer()
        }
        .padding(20)
        .frame(minWidth: 100, maxWidth: 300, minHeight: 200, maxHeight: 500)
    }
}
