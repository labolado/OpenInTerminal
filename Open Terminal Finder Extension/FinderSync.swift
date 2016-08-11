//
//  FinderSync.swift
//  FinderExtension
//
//  Created by Quentin PÂRIS on 23/02/2016.
//  Copyright © 2016 QP. All rights reserved.
//

import Cocoa
import FinderSync


class FinderSync: FIFinderSync {
    
    var myFolderURL: NSURL = NSURL(fileURLWithPath: "/")
    
    override init() {
        super.init()
        
        NSLog("FinderSync() launched from %@", NSBundle.mainBundle().bundlePath)
        
        // Set up the directory we are syncing.
        FIFinderSyncController.defaultController().directoryURLs = [self.myFolderURL]
    }
    
    
    
    override func menuForMenuKind(menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension.
        let menu = NSMenu(title: "Open Terminal")
        menu.addItemWithTitle("Open Terminal", action: "openTerminal:", keyEquivalent: "")
        menu.addItemWithTitle("Copy Path", action: "copyPath:",  keyEquivalent: "")
         //  menu.addItemWithTitle("Execute Here", action: "executeHere:",  keyEquivalent: "")
        return menu
    }
    
    @IBAction func openTerminal(sender: AnyObject?) {
        let target = FIFinderSyncController.defaultController().targetedURL()
        
        if let targetPath = target?.path {
            system("open \"terminal://"+targetPath+"\"")
        }
    }
    @IBAction func executeHere(sender: AnyObject){
        let alert: NSAlert = NSAlert()
        alert.messageText = "Do you like cooking?"
        alert.addButtonWithTitle("Yes")
        alert.addButtonWithTitle("No")
        
        let inputTextField = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
        inputTextField.placeholderString = "Enter Shell Command Here"
        alert.accessoryView = inputTextField
        
        alert.alertStyle = NSAlertStyle.WarningAlertStyle
        let response: Int = alert.runModal()
        switch response {
        case NSAlertFirstButtonReturn:
            
            let target = FIFinderSyncController.defaultController().targetedURL()
            if let targetPath = target?.path {
               
                let enteredString = "cd \"" + targetPath + "\" && " + inputTextField.stringValue + " && read -p \"Press [Enter] key to contiune...\""
                self.alert1(  targetPath, message: enteredString)
                system(enteredString)
            }

            
            
            
            
        case NSAlertSecondButtonReturn:
          return
        default:
            break
        }
    }
    
    func showNotification(title: String, message: String) -> Void {
        var notification = NSUserNotification()
        notification.title = title
        notification.informativeText = message
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
       // FIFinderSyncController.defaultController().notifi
    }
    
    
    func alert1(title: String, message: String){
        let a = NSAlert ()
        a.messageText = title
        a.informativeText = message
        a.runModal()
    }
    
    
    @IBAction func copyPath(sender: AnyObject?) {
        let target = FIFinderSyncController.defaultController().targetedURL()
        
        
        if let targetPath = target?.path {
            system("echo '" + targetPath + "' | pbcopy")
            //self.alert1("abc", message: targetPath);
            //self.showNotification("Path Copyed", message: targetPath)
            //self.alert1("abc", message: targetPath);
            
            //system("open \"terminal://"+targetPath+"\"")
            //UIPasteboard.generalPasteboard().string = targetPath
//            let alert = NSAlert ()
//            alert.messageText = "Information"
//            alert.informativeText = targetPath
//            alert.runModal()
        }
    }
    
}

