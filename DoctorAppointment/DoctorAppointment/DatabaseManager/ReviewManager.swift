//
//  ReviewManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 03.05.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReviewManager {
    
    static let shared = ReviewManager()
    let db = Firestore.firestore()
    
    private init(){}
    
    
    func getReviewsForDoctors(doctorID: String, completion: @escaping ([Review]?) -> ()){
        var reviews: [Review] = []
        db.collection("Review").whereField("doctor_id", isEqualTo: doctorID).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            }
            else {
                for document in snapshot!.documents{
                    
                    let result = Result{
                        try document.data(as: Review.self)
                        
                    }
                    switch result{
                    case .success(let item):
                        reviews.append(item)
                    case .failure(let err):
                        print("Couldn't parse review \(err.localizedDescription)")
                    }
                    
                }
                completion(reviews)
                
            }
            
        }
    }
    
    
    func addReview(review: Review){
        do {
            try db.collection("Review").addDocument(from: review)
        } catch let error {
            print("Error writing review to Firestore: \(error)")
        }

    }
}
