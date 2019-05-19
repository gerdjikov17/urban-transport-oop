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
    @IBOutlet weak var chosenRouteTextField: NSTextField!
    
    private var chosenRoute: Route?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chosenRouteTextField.isEditable = false
        let numbersOnlyFormatter = OnlyIntegerValueFormatter()
        let doubleOnlyFormatter = OnlyDoubleValueFormatter()
        self.yearsOldTextField.formatter = numbersOnlyFormatter
        self.seatsTextField.formatter = numbersOnlyFormatter
        self.loadCapabilityTextField.formatter = doubleOnlyFormatter
        self.fuelConsumptionTextField.formatter = doubleOnlyFormatter
    }
    
    @IBAction func chooseRouteButtonTap(_ sender: Any) {
        guard let chooseRouteVC = storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("chooseRouteVC")) as? NSViewController else { return }
        self.presentAsSheet(chooseRouteVC)
    }
    
    @IBAction func addButtonTap(_ sender: Any) {
        guard validateAllFields() else {
            self.presentError(NSError(domain: "Fill all fields", code: 1, userInfo: nil))
            return
        }
        let car = carFromAllFields()
        RealmRepository.addCar(car: car)
        
        self.dismiss(nil)
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.dismiss(nil)
    }
    
    public func setChosenRoute(route: Route) {
        self.chosenRoute = route
        self.chosenRouteTextField.stringValue = route.getName()
    }
    
    private func validateAllFields() -> Bool {
        guard !self.brandTextField.stringValue.isEmpty else { return false }
        guard !self.modelTextField.stringValue.isEmpty else { return false }
        guard !self.yearsOldTextField.stringValue.isEmpty else { return false }
        guard !self.seatsTextField.stringValue.isEmpty else { return false }
        guard !self.loadCapabilityTextField.stringValue.isEmpty else { return false }
        guard !self.fuelConsumptionTextField.stringValue.isEmpty else { return false }
        guard !self.chosenRouteTextField.stringValue.isEmpty else { return false }
        return true
    }
    
    private func carFromAllFields() -> Car {
        let brand = self.brandTextField.stringValue
        let model = self.modelTextField.stringValue
        let yearsOld = self.yearsOldTextField.integerValue
        let seats = self.seatsTextField.integerValue
        let loads = self.loadCapabilityTextField.doubleValue
        let fuelConsumption = self.fuelConsumptionTextField.doubleValue
        let car = Car(brand: brand, model: model, yearsOld: yearsOld, seats: seats, loadCapability: loads, fuelConsumption: fuelConsumption, route: self.chosenRoute)
        return car
    }
}

class OnlyIntegerValueFormatter: NumberFormatter {
    
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        if partialString.isEmpty {
            return true
        }

         if partialString.count>3 {
            return false
         }
        
        return Int(partialString) != nil
    }
}


class OnlyDoubleValueFormatter: NumberFormatter {
    
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        if partialString.isEmpty {
            return true
        }
        
        if partialString.count>6 {
            return false
        }
        
        return Double(partialString) != nil
    }
}
