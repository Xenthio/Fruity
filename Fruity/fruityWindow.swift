//
//  fruityWindow.swift
//  Fruity
//
//  Created by Ethan Cardwell on 6/5/20.
//  Copyright © 2020 Ethan Cardwell. All rights reserved.
//

import Cocoa

class fruityWindow: NSWindowController {

	
	@IBOutlet var List: NSScrollView!
	@IBOutlet var tableViewOutlet: NSTableView!
	
	
	override var windowNibName: String! {
        return "fruityWindow"
    }
	
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
	

	

	
}
