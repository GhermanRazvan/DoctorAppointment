//
//  DoctorView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.05.2023.
//

import SwiftUI

struct DoctorView: View {
    var doctor: Doctor
    @State private var showingSheet = false
    @State var reviews: [Review] = []
    var body: some View {
        VStack{
            HStack{
                Text("\(doctor.firstName)")
                if doctor.middleName != nil{
                    
                    Text("\(doctor.middleName!)")
                    
                }
                
                Text("\(doctor.lastName)")
                
                
            }
            Text("\(doctor.phoneNumber)")
            Text("\(doctor.email)")
            if doctor.about != nil
            {
                Text("\(doctor.about!)")
            }
            Text("\(avgRating())")
            ScrollView(.horizontal){
                
                HStack{
                    ForEach(reviews) { review in
                        /*@START_MENU_TOKEN@*/Text(review.text)/*@END_MENU_TOKEN@*/
                    }
                }
                
                
                
            }
            
            Button("Add a review") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet){
                AddReviewView(doctorID: doctor.id!)
        }
            
    }.onAppear{
            
            ReviewManager.shared.getReviewsForDoctors(doctorID: doctor.id! ){ result in
                
                if let result = result {
                    reviews = result
                   
                }
                
            }
            
        }
    }
    
    func avgRating() -> String{
        var sum: Double = 0
        for review in reviews {
            sum += Double(review.reviewScore)
 
        }
        let doubleStr = String(format: "%.2f", sum/Double(reviews.count))
        return doubleStr
        
    }
}

struct DoctorView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorView(doctor: Doctor(firstName: "", middleName: "", lastName: "", phoneNumber: "", email: "", profession: "", about: "", clinicId: ""))
    }
}