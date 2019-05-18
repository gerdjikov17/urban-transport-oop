//
//  CarInputViewController.swift
//  OOPUrbanTransport
//
//  Created by Nikola Gerdzhikov on 19.05.19.
//  Copyright © 2019 Nikola Gerdzhikov. All rights reserved.
//

import Cocoa

class CarInputViewController: NSViewController {

    @IBOutlet weak var brandTextField: NSTextField!
    @IBOutlet weak var modelTextField: NSTextField!
    @IBOutlet weak var yearsOldTextField: NSTextField!
    @IBOutlet weak var seatsTextField: NSTextField!
    @IBOutlet weak var loadCapabilityTextField: NSTextField!
    @IBOutlet weak var fuelConsumptionTextField: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func chooseRouteButtonTap(_ sender: Any) {
        
    }
    @IBAction func addButtonTap(_ sender: Any) {
        
        self.dismiss(nil)
    }
}
