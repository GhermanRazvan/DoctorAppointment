//
//  DoctorRatingView.swift
//  DoctorAppointment
//
//  Created by Razvan Gherman on 15.05.2023.
//

import SwiftUI

struct DoctorRatingView: View {
    @State var rating: Int
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    
    var body: some View {
        
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
        
        
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}


struct DoctorRatingView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorRatingView(rating: 4)
    }
}
