//
//  RatingView.swift
//  Bookworm
//
//  Created by Dave Spina on 1/1/21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1) { num in
                image(for: num)
                    .foregroundColor(num > rating ? offColor : onColor)
                    .onTapGesture {
                        self.rating = num
                    }
                    .accessibility(label: Text("\(num == 1 ? "1 star" : String(num) + " stars")"))
                    .accessibilityRemoveTraits(.isImage)
                    .accessibilityAddTraits(num > self.rating ? .isButton : [.isButton, .isSelected])
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

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
