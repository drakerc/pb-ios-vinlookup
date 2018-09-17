//
//  ViewController.swift
//  Vin Getter
//
//  Created by student on 05.12.2017.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FetchInfoDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var vinTextField: UITextField!
    @IBOutlet weak var getCarInfoButton: UIButton!
    
    @IBOutlet weak var makeInfo: UILabel!
    @IBOutlet weak var modelInfo: UILabel!
    @IBOutlet weak var yearInfo: UILabel!
    @IBOutlet weak var horsepowerInfo: UILabel!
    @IBOutlet weak var countryInfo: UILabel!
    @IBOutlet weak var typeInfo: UILabel!

    
    var car: FetchInfo!

    //shake gesture detection stuff
    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            makeLabel.text = ""
            modelLabel.text = ""
            yearLabel.text = ""
            capacityLabel.text = ""
            countryLabel.text = ""
            carTypeLabel.text = ""
            
            makeInfo.text = ""
            modelInfo.text = ""
            yearInfo.text = ""
            horsepowerInfo.text = ""
            countryInfo.text = ""
            typeInfo.text = ""

            vinTextField.placeholder = "Enter VIN Number"
            vinTextField.delegate = self
            vinTextField.enablesReturnKeyAutomatically = true
            getCarInfoButton.enabled = false
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        car = FetchInfo(delegate: self)
        
        makeLabel.text = ""
        modelLabel.text = ""
        yearLabel.text = ""
        capacityLabel.text = ""
        countryLabel.text = ""
        carTypeLabel.text = ""
        
        makeInfo.text = ""
        modelInfo.text = ""
        yearInfo.text = ""
        horsepowerInfo.text = ""
        countryInfo.text = ""
        typeInfo.text = ""

        
        vinTextField.placeholder = "Enter VIN Number"
        vinTextField.delegate = self
        vinTextField.enablesReturnKeyAutomatically = true
        getCarInfoButton.enabled = false
        
        
        //let car = FetchInfo()
        //car.getVehicleInfo("1G6KE54Y63U253010")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getCarForVinButtonTapped(sender: UIButton) {
        guard let text = vinTextField.text where !text.isEmpty else {
            return
        }
        car.getCarByVin(vinTextField.text!)
    }
    func didGetCarInfo(car: Car) {
        dispatch_async(dispatch_get_main_queue()) {
            
            if car.make == null && car.model == null && car.year == null && car.power == null && car.country == null && car.type == null {
            self.showSimpleAlert(title: "Specified VIN number is invalid",
                message: "Specified VIN number is invalid")
            return
            }
            
            if car.make == "" && car.model == "" && car.year == "" && car.power == "" && car.country == "" && car.type == "" {
            self.showSimpleAlert(title: "Specified VIN number is invalid",
                message: "Specified VIN number is invalid")
            return
            }

            if car.vinValidity == "invalid" {
            self.showSimpleAlert(title: "Specified VIN number is invalid",
                message: "Specified VIN number is invalid")
            return
            }

            self.makeLabel.text = car.make
            self.modelLabel.text = car.model
            self.yearLabel.text = car.year
            self.capacityLabel.text = car.power
            self.countryLabel.text = car.country
            self.carTypeLabel.text = car.type
            
            self.makeInfo.text = "Make:"
            self.modelInfo.text = "Model:"
            self.yearInfo.text = "Production year:"
            self.horsepowerInfo.text = "Engine capacity [l]:"
            self.countryInfo.text = "Country of production:"
            self.typeInfo.text = "Car type:"

        }
    }
    
    func didNotGetCarInfo(error: NSError) {
        
        dispatch_async(dispatch_get_main_queue()) {
            self.showSimpleAlert(title: "Can't get the car info",
                message: "Can't get the car info")
        }
    }
    
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(
                range,
                withString: string)
            getCarInfoButton.enabled = prospectiveText.characters.count > 0
            return true
    }
    
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        textField.text = ""
        getCarInfoButton.enabled = false
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getCarForVinButtonTapped(getCarInfoButton)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showSimpleAlert(title title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .Alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style:  .Default,
            handler: nil
        )
        alert.addAction(okAction)
        presentViewController(
            alert,
            animated: true,
            completion: nil
        )
    }
    
}


extension String {
    
    var urlEncoded: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLUserAllowedCharacterSet())!
    }
    
}
