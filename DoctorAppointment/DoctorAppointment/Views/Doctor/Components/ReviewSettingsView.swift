//
//  ReviewSettingsView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 14.05.2023.
//

import SwiftUI

struct ReviewSettingsView: View {
    @AppStorage("email") var userEmail: String = ""
    @State var reviews: [Review] = []
    
    
    var body: some View {
        List{
            ForEach(reviews){ review in
                VStack(alignment: .leading){
                    Text(review.text)
//                        .frame(maxWidth: .infinity, alignment: .leading)
                    DoctorRatingView(rating: review.reviewScore)
                }
            }
        }.onAppear{
            ReviewManager.shared.getReviewsForDoctors(doctorID: userEmail) { result in
                if let result = result{
                    reviews = result
                    
                }
            }
        }
    }
}

struct ReviewSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewSettingsView()
    }
}
