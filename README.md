# OmniPane v1.0

## Video for Peer Reviewers & Shipwrights - Includes Instatllation, Features and MOST IMPORTANTLY, Bugs.
https://github.com/user-attachments/assets/b0278f5d-eb54-4352-860f-f62125697233

## Overview
**OmniPane** is a modular, universal utility sidebar designed for native macOS and will very soon come for Windows. 
It operates silently as an unobtrusive menubar agent, summoned on command across any desktop workspace to serve as a high-speed productivity staging area.

---
## Features
### 🖥️ Native Operation
*   **Menu Bar App:** OmniPane lives entirely in your menu bar. No messy Dock icons, and it doesn't pollute your `Cmd + Tab` Application Switcher.
*   **Global Hotkey Support:** Fire the app open natively over any full-screen window, app, or virtual desktop by hitting `Cmd + Option + K`. You can set your own hotkey from Settings too!
*   **Settings Integration:** Supports macOS Ventura's native settings ecosystem, complete with one-click `Launch on Login` via `SMAppService`.
### 📦 Utilities
*   **File Drop:**
    *   **Universal Staging:** Drag and drop absolutely any file or folder from your computer or internet browser into the staging grid.
    *   **Native QuickLook:** Double-click any dropped file to instantly preview it natively without opening its default app.
    *   **Drag-Out:** Drag it seamlessly out of OmniPane and into any email, folder, or application window.
*   **Scratch Notes:**
    *   **Stateless Ephemeral Notes:** Instantly jot down text with zero overhead (no messy tags, titles, or timestamps).
    *   **Dual-State UI:** Module dynamically morphs between a horizontally scrolling collection of truncated cards, and a massive full-length expanding canvas when reading/editing.
    *   **Contextual Tooling:** Sleek glassmorphism hover-states neatly reveal Edit/Trash tools only when targeted.
### ↕️ Dynamic Reordering Engine
OmniPane allows you to build your stack *your* way. Hovering over a module reveals a custom 6-dot UI grip. Simply grab it and physically drag the module up or down to globally reorganize the utility stack.

---
## Buggy Features (Will be fixed in next release)
#### Dragging to change position
- It works but only in a very specific, kinda unusable way.
- It is clearly demonstrated in the main demo video at the top of the page.
- But here's another video of how it'll work (it won't work any other way):

https://github.com/user-attachments/assets/1a4b7ef2-b99e-4f20-8e59-fc532f3dba65

#### Memory Reset
- Scratch Notes' & FileDrop's memory resets when app is closed or utility is deactivated in the settings.
- It is clearly demonstrated in the main demo video at the top of the page.

---
## Usage Guide
1. Launch the app. You'll see the default Menu Bar icon. 
2. **Accessing:** Click the `macwindow` icon in your menu bar, or simply hit `Cmd + Option + K` anywhere on your computer.
3. **Module Drag & Drop:** Hover your mouse near the exact left side of a utility's title text (e.g., File Drop). A 6-dot grip will fade in. Click and hold the grip to drag that utility box to the top or bottom of your stack.
4. **Settings:** Click the Menu Bar icon and hit `Settings`, or hit `Cmd + ,` while the app is active. You can universally toggle components on or off from this window, and change your global hotkey instantly.

---
## Installation Guide (macOS)
OmniPane relies completely on native Core functions. Because it currently isn't tied to a paid, official Apple Developer ID, Apple's Gatekeeper will initially block the app from opening as a safety precaution. Follow these exact steps to bypass:
1. Download the `OmniPane` `.app` file.
2. Move `OmniPane.app` directly into your Mac's `/Applications` folder.
3. Double-click to open it.
4. **macOS will display an "Unidentified Developer" warning.** Click **OK** on that warning to dismiss it.
5. Open your Mac's **System Settings** app.
6. In the left sidebar, navigate to **Privacy & Security**.
7. Scroll down to the middle section under "Security". You will see a small message stating: *"OmniPane" was blocked from use because it is not from an identified developer.*
8. Click the **Open Anyway** button.
9. Provide your Mac Administrator password (or Touch ID fingerprint) when prompted.
10. Click **Open** on the final confirmation popup.
11. **You're fully installed!** *(Pro Tip: Hit `Cmd + ,` to open Settings and toggle "Launch at Login" so you never have to do this again!)*

---
## AI Usage Declaration
- Color Palette Suggestions
- Minor code writings (~5%)
- Rewrote README based on my draft.

---
## Coming Up
- Adding memory to file drop & scratch notes
- Fixing drag reorder
- Add System Monitor Utility
- Add Color Palette & Picker Utility
- Add Clipboard Manager Utility
- Add Screenshot Manager Utility
