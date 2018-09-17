//
//  Car.swift
//  Vin Getter
//
//  Created by student on 05.12.2017.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

struct Car {
    
    let make: String
    let model: String
    let year: String
    
    let power: String
    let country: String
    let city: String
    let state: String
    var typeID: String
    var type: String {
        get {
            if typeID  == "7" {
                return "SUV"
            }
            else if typeID == "13" {
                return "Sedan"
            }
            else if typeID == "1" {
                return "Cabrio"
            }
            else if typeID == "3" {
                return "Coupe"
            }
            else if typeID == "9" {
                return "Van / minivan"
            }
            else if typeID == "60" {
                return "Pickup"
            }
            else if typeID == "15" {
                return "Combi wagon"
            }
            else {
                return "Other Type"
            }
        }
    }


    var invalidVIN: String
    var vinValidity: String {
        get {
            if invalidVIN  == "7 - Manufacturer is not registered with NHTSA for sale or importation in the U.S. for use on U.S roads; Please contact the manufacturer directly for more information." {
                return "invalid"
            }
            else {
                return "valid"
            }
        }
    }
    
    
    init(car: [String: AnyObject]) {
        make = car["Results"]![5]!["Value"]!! as! String
        model = car["Results"]![7]!["Value"]!! as! String
        year = car["Results"]![8]!["Value"]!! as! String
        power = car["Results"]![69]!["Value"]!! as! String
        country = car["Results"]![13]!["Value"]!! as! String
        city = car["Results"]![9]!["Value"]!! as! String
        state = car["Results"]![15]!["Value"]!! as! String
        typeID = car["Results"]![22]!["ValueId"]!! as! String

        invalidVIN = car["Results"]![1]!["Value"]!! as! String

    }
    
}
