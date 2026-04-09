//
//  AppDelegate.swift
//  OmniPane
//
//  Created by Aishwarya Rana on 08/04/26.
//

import KeyboardShortcuts
import Foundation
import SwiftUI
import AppKit

extension KeyboardShortcuts.Name {
    static let toggleApp = Self("toggleApp",
                                default: .init(.k, modifiers: [.command, .option]))
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var statusItem: NSStatusItem!
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        let contentView = ContentView()
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 350, height: 700),
            styleMask: [.titled, .closable, .fullSizeContentView, .resizable],
            backing: .buffered,
            defer: false
        )
        
        window.isReleasedWhenClosed = false
        window.center()
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.standardWindowButton(.zoomButton)?.isEnabled = false
        window.standardWindowButton(.miniaturizeButton)?.isEnabled = false
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image =
                NSImage(systemSymbolName: "text.and.command.macwindow", accessibilityDescription: "OmniPane")
        //            button.action = #selector(toggleWindow)
        //            button.target = self
        }
        
        let menu = NSMenu()
        
        let appItem = NSMenuItem(title: "OmniPane", action: #selector(toggleWindow), keyEquivalent: "")
        appItem.image = NSImage(systemSymbolName: "arrow.up.forward.app", accessibilityDescription: nil)
        menu.addItem(appItem)
        
        menu.addItem(NSMenuItem(title: "Settings", action: #selector(openSettings), keyEquivalent: ","))
        // Settings has an icon. I researched and found that Apple by default adds a gear icon for "Settings" since macOS Ventura. Anyways, I'll add icons for all items then.
        
        let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.image = NSImage(systemSymbolName: "xmark.circle", accessibilityDescription: nil)
        menu.addItem(quitItem)
        
        statusItem.menu = menu
        
        KeyboardShortcuts.onKeyUp(for: .toggleApp) {
            [weak self] in
            self?.toggleWindow()
        }
    }
    
    @objc func toggleWindow () {
        if window.isVisible {
            window.orderOut(nil)
        } else {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        }
    }
    
    @objc func openSettings() {
        NSApp.activate(ignoringOtherApps: true)
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
    }
    
    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
