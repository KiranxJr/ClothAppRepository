//
//  LottieView.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI
import Lottie

// Lottie View
struct LottieView: UIViewRepresentable {
    
    @State var name: String
    var loopMode: LottieLoopMode
    var animationView = AnimationView()

    // Make view for animation
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        // constant view 
        let view = UIView()

        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode
        let blue = Color(r: (0/255), g: (120/255), b: (149/255), a: 1)
       
        let orangeColorValueProvider = ColorValueProvider(blue)

        // Set color value provider to animation view
        let keyPath = AnimationKeypath(keypath: "**.Shape 1.Fill 1.Color")
        animationView.setValueProvider(orangeColorValueProvider, keypath: keyPath)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    // Update view on change
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}

