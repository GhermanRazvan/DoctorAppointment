//
//  LocationUtil.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 02.05.2023.
//

import Foundation
import SwiftUI
import CoreLocation
import Contacts

class LocationUtil{
    func geoCodeLocation(lat: Double, long: Double, completion: @escaping (Location?) -> () ) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: lat, longitude: long)){
            (placemarks, error) in
            guard error == nil  else {
                completion(nil)
                return
                
            }
            
            if let placemarks = placemarks{
//                completion(placemarks[0])
                let loc = placemarks[0]
                if let address = placemarks[0].postalAddress{
                    let result = Location(street: address.street, postalCode: loc.postalCode ?? "0", country: address.country, city: address.city)
                    completion(result)
                }
            }
        }

    }
    
}



