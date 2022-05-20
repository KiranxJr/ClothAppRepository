//
//  RatingView.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI


struct StarsView: View {
    // rate limit
  private static let MAX_RATING: Float = 5
    // star color
  private static let COLOR = Color.black

  let rating: Float
  private let fullCount: Int
  private let emptyCount: Int
  private let halfFullCount: Int

  init(rating: Float) {
    self.rating = rating
    fullCount = Int(rating)
    emptyCount = Int(StarsView.MAX_RATING - rating)
    halfFullCount = (Float(fullCount + emptyCount) < StarsView.MAX_RATING) ? 1 : 0
  }

  var body: some View {
    HStack {
        ForEach(0..<fullCount,id: \.self) { _ in
         self.fullStar
       }
       ForEach(0..<halfFullCount,id: \.self) { _ in
         self.halfFullStar
       }
       ForEach(0..<emptyCount,id: \.self) { _ in
         self.emptyStar
       }
     }
  }
// method called when count is full
  private var fullStar: some View {
    Image(systemName: "star.fill")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 10, height: 10)
          .foregroundColor(StarsView.COLOR)
  }
// method called when count is half
  private var halfFullStar: some View {
    Image(systemName: "star.lefthalf.fill")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 10, height: 10)
          .foregroundColor(StarsView.COLOR)
  }
// method called when count is empty
  private var emptyStar: some View {
    Image(systemName: "star")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 10, height: 10)
          .foregroundColor(StarsView.COLOR)
  }
}
