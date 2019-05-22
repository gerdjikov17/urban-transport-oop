//
//  AppDelegate.swift
//  OOPUrbanTransport
//
//  Created by Nikola Gerdzhikov on 18.05.19.
//  Copyright © 2019 Nikola Gerdzhikov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let data = FileRepository.shared().readFromFile(fileName: "data.txt")
        RealmRepository.initWithData(data: data)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        FileRepository.shared().writeToFile(fileName: "data.txt")
    }


}

