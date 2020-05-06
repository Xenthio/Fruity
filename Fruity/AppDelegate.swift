//
//  AppDelegate.swift
//  Fruity - An open-source, real Mac cleaner.
//

import Cocoa
import Darwin

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	var statusBarItem: NSStatusItem!
	var fruityMainWindow = fruityWindow()

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		NSApp.setActivationPolicy(.accessory)
		let statusBar = NSStatusBar.system // Create a status icon in the dock.
		statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength) // Set the size for the item.
		statusBarItem.button?.title = "🍉"
		let statusBarMenu = NSMenu(title: "Cap Status Bar Menu")
		statusBarItem.menu = statusBarMenu
        statusBarMenu.addItem(
            withTitle: "Open Fruity",
            action: #selector(AppDelegate.open),
            keyEquivalent: "")
        statusBarMenu.addItem(
            withTitle: "Quit",
            action: #selector(AppDelegate.quit),
            keyEquivalent: "")
	}
	
	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	@objc func quit() {
		exit(0)
	}
	@objc func open() {
		fruityMainWindow.showWindow(nil)
		fruityMainWindow.window?.orderFront(nil)
	}
}

