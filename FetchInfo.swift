//
//  FetchInfo.swift
//  Vin Getter
//
//  Created by student on 05.12.2017.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

protocol FetchInfoDelegate {
    func didGetCarInfo(car: Car)
    func didNotGetCarInfo(error: NSError)
}

class FetchInfo {
    
    private let nhtsaApiUrl = "https://vpic.nhtsa.dot.gov/api/vehicles/decodevin/"
    private var delegate: FetchInfoDelegate
    
    init(delegate: FetchInfoDelegate) {
        self.delegate = delegate
    }
    
    func getCarByVin(vin: String) {
        let carApiRequestUrl = NSURL(string: "\(nhtsaApiUrl)\(vin)?format=json")!
        getVehicleInfo(carApiRequestUrl)
    }
    
    func getVehicleInfo(carApiRequestUrl: NSURL) {
        let session = NSURLSession.sharedSession()
        
        //let carApiRequestUrl = NSURL(string: "\(nhtsaApiUrl)\(vin)?format=json")!
        
        let dataTask = session.dataTaskWithURL(carApiRequestUrl) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            //if let networkError = error
            if let error = error {
                print("Error:\n\(error)")
                self.delegate.didNotGetCarInfo(error)
            }
            else {
                //success
                do {
                    // convert data into a Swift dictionary
                    let carInfo = try NSJSONSerialization.JSONObjectWithData(
                        data!,
                        options: .MutableContainers) as! [String: AnyObject]
                    
                    let car = Car(car: carInfo)
                    
                    self.delegate.didGetCarInfo(car)
                }
                catch let jsonError as NSError {
                    print("JSON error: \(jsonError.description)")
                    self.delegate.didNotGetCarInfo(jsonError)
                    
                }
            }
        }
        
        // start the task and get data
        dataTask.resume()
    }
}
