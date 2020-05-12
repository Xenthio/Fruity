//
//  fruityViewController.swift
//  Fruity
//
//  Created by Ethan Cardwell on 6/5/20.
//  Copyright © 2020 Ethan Cardwell. All rights reserved.
//



import Cocoa
import Foundation

var safeapps = getProcesses()
var bkup = getProcesses()
var sortMode = 0
var mib = [Int32]()


class fruityViewController: NSViewController {
	@IBOutlet weak var searchField: NSSearchField!
	@IBOutlet var tableView: NSTableView!
	var timer = Timer()
	
	@IBAction func kill(_ sender: Any) {
		for index in tableView.selectedRowIndexes.sorted() {
			
			killPID((safeapps[index])["processid"]!)
			reloadAll()
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		
		
    }
	override func viewDidAppear() {
		safeapps = getProcesses()
		tableView.reloadData()
		print("yo")
	}
	
	override func viewDidDisappear() {
		print("ok")
	}
	@IBAction func reload(_ sender: Any) {
		reloadAll()
	}
	
	@objc func reloadAll() {
		safeapps = getProcesses()
		bkup = getProcesses()
		
		tableView.reloadData()

	}
}


extension fruityViewController: NSSearchFieldDelegate {
	func controlTextDidChange(_ obj: Notification) {
		if searchField.stringValue != "" {
			var temp = [[String:String]]()
			for i in bkup {
				if i["process"]!.contains(searchField.stringValue) {
					temp.append(i)
				}
			}
			safeapps = temp
		} else {
			safeapps = bkup
		}
		tableView.reloadData()

	}
		
}

extension fruityViewController: NSTableViewDataSource {
  
  func numberOfRows(in tableView: NSTableView) -> Int {
		return safeapps.count
	
  }

}

extension fruityViewController: NSTableViewDelegate {
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

		let item = (safeapps)[row]
		  
		let cell = tableView.makeView(withIdentifier: (tableColumn!.identifier), owner: self) as? NSTableCellView
		cell!.textField!.stringValue = item[(tableColumn?.identifier)!.rawValue]!
			
		return cell
	}
	func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]){
//		if sortMode == 0 {
//			sortMode = 1
//		} else if sortMode == 1 {
//			safeapps = safeapps.sorted(by: { ($0[0]) > ($1[0]) })
//			sortMode = 2
//		} else if sortMode == 2 {
//			safeapps = safeapps.sorted(by: { ($0[0]) < ($1[0]) })
//			sortMode = 1
//		}
//
		tableView.reloadData()
	}
	func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
		return true
	}
}

