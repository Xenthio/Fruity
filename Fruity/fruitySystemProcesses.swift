//
//  fruitySystemProcesses.swift
//  Fruity
//
//  Created by Ethan Cardwell on 6/5/20.
//  Copyright © 2020 Ethan Cardwell. All rights reserved.
//

import Foundation
import Cocoa
import Darwin



// VERSIONS SYSTEM TASK
let version15sys = ["kernel_task", "loginwindow"] // System tasks for 10.15
var dialogShown = false


func shell(launchPath: String, arguments: [String]) -> String?
{
    let task = Process()
    task.launchPath = launchPath
    task.arguments = arguments

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)

    return output
}

func dialog(question: String, text: String) -> Bool {
    let alert: NSAlert = NSAlert()
    alert.messageText = question
    alert.informativeText = text
	alert.alertStyle = NSAlert.Style.warning
	alert.addButton(withTitle: "OK")
	alert.addButton(withTitle: "Quit")
    let res = alert.runModal()
	if res == NSApplication.ModalResponse.alertFirstButtonReturn {
        return true
    }
    return false
}


func getSystemItems() -> [String] {
	let systemVersion = ProcessInfo.processInfo.operatingSystemVersion
	if systemVersion.minorVersion == 15 {
		return version15sys
	} else {
		if dialogShown == false {
			versionWarning()
			dialogShown = true
		}
		return version15sys
	}
}

func versionWarning() {
	let systemVersion = ProcessInfo.processInfo.operatingSystemVersion
	let awnser = dialog(question: "The version you are using isn't supported.", text: "The version \'10." + String(systemVersion.minorVersion) + ".x\' isn't supported at the moment, send an issue on the github. You may continue, but some system apps might be shown in the menu.")
	if awnser == false {
		exit(0)
	}
}

func getProcesses() -> [[String:String]] {
	var final = [[String:String]]()
	var apps = shell(launchPath: "/bin/ps", arguments: ["-eo", "ucomm"])?.components(separatedBy: "\n");
	apps?.removeFirst()
	apps?.removeLast()
	var appspid = shell(launchPath: "/bin/ps", arguments: ["-eo", "pid"])?.components(separatedBy: "\n");
	print(appspid)
	appspid?.removeFirst()
	print(appspid)
	for i in apps! {
		if getSystemItems().contains(i) != true {
			var a = "kool"
			
			if appspid!.count != 0 {
				a = appspid!.removeFirst()
			} else {
				a = "N/A, Try refresh."
			}
			final.append(["process" : i, "processid" : a])
			
		} else {
			appspid!.removeFirst()
		}
	}
	return final
}

func killPID(_ pid: String) {
	_ = shell(launchPath: "/bin/kill", arguments: [pid])
}
