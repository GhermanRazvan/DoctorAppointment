//
//  MapView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 16.05.2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct PinPoint: Identifiable{
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
     var clinic: Clinic
    @State var annotations: [PinPoint] = []
    @State var address: String = ""
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View {
        VStack{
            GeometryReader{ geo in
                Map(coordinateRegion: $region, interactionModes: MapInteractionModes.all, showsUserLocation: false, annotationItems: annotations) { location in
                    MapMarker(coordinate: location.coordinate)
                }
                .frame(width: geo.size.width  , height: geo.size.height)
            }
        }.onAppear{
            address = "\(clinic.number), \(clinic.street), \(clinic.city), \(clinic.country), \(clinic.zipCode)"
            let locationUtil = LocationUtil()
            locationUtil.geoCodeAdress(address: address) { result in
            
                if let result = result {
                    region = MKCoordinateRegion(center: result.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                    annotations.append(PinPoint(name: clinic.name, coordinate: result.coordinate))
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        
        MapView(clinic: Clinic(name: "", street: "", number: "", country: "", zipCode: "", city: "", clinicImage: ""))
        
    }
}
