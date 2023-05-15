//
//  StorageManager.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 15.05.2023.
//

import Foundation
import FirebaseStorage
import SwiftUI
import UIKit


class StorageManager {
    private let storage = Storage.storage()
    static let shared = StorageManager()
    private init () {}
    
    
    func addImageToFirebaseStorage( image: UIImage, toPath path: String, completion: @escaping (Bool) -> ()) {
        let storageRef = storage.reference().child(path)
        
        guard let data = image.pngData() else {
            completion(false)
            return
        }
        
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let  _ = metadata else {
                print("[error]:: adding image to Firebase Storage -- (error!.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func getItemPictureURL(email: String,  completion: @escaping (Result<URL, Error>) -> ()) {
        let path = "pictures/doctor/" + email + "/profilePicture.png"
        let storageRef = storage.reference().child(path)
        
        storageRef.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(url))
        }
    }
}
