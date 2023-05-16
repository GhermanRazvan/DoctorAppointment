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
    func geoCodeAdress(address: String, completion: @escaping (CLLocation?) -> () ){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { placemarks, err in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location
            else{
                completion(nil)
                return
            }
            completion(location)
        }
    }
    
}



