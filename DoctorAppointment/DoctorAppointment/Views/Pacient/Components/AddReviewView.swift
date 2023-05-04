//
//  AddReviewView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.05.2023.
//

import SwiftUI

struct AddReviewView: View {
    @State var reviewText: String = ""
    @State var rating = 1
    @AppStorage("email") var userEmail: String = ""
    var doctorID: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            
            VStack{
                TextField("Review Text", text: $reviewText)
                RatingView(rating: $rating)
                Button("Add review") {
                    let review = Review(reviewScore: rating, text: reviewText, doctorID: doctorID, pacientID: userEmail)
                    ReviewManager.shared.addReview(review: review)
                    dismiss()

                    
                }
            }.toolbar {
                Button{
                    dismiss()
                    
                }label: {
                    Image(systemName: "xmark.circle")
                }
            }
        }
        
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView(doctorID: "salut")
    }
}
