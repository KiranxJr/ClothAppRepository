//
//  CustomCorner.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI

//  providing custom corners by extending shape protocol
struct CustomCorner: Shape {
    var corners : UIRectCorner
    var radius : CGFloat
    func path(in rect : CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
