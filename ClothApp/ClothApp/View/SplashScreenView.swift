//
//  LoadingView.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI

struct SplashScreenView: View {
    // instance of shared viewmodel class
    @StateObject var sharedData : SharedViewModel = SharedViewModel()
    
    var body: some View {
        
        if self.sharedData.showHomePage {
            
            // navigating to home page
            HomeView()
                .environmentObject(sharedData)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            
        } else {
            // Splash screen aniamtion view
            SplashScreenAnimation()
            
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                        withAnimation {
                            self.sharedData.showHomePage = true
                        }
                       
                    }
                }
        }
    }
    
    // Animation view for splash screen
    @ViewBuilder
    func SplashScreenAnimation() -> some View {
        VStack {
            // Lottie Animation
            LottieView(name: "Splash", loopMode: .loop)
                .frame(width: getRect().width / 2, height: getRect().width / 2)
            
        }
        // frame
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
        // bacground
        .background(
            Color("Primary")
        )
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}


// Extending view to get screen bounds
extension View{
    
    // get screen size
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    // horizontal leading alignment
    func hLeading()-> some View{
        self.frame(maxWidth: .infinity,alignment: .leading)
    }
    
    // horizontal trailing alignment
    func hTrailing()-> some View{
        self.frame(maxWidth: .infinity,alignment: .trailing)
    }
    
    // horizontal center alignment
    func hCenter()-> some View{
        self.frame(maxWidth: .infinity,alignment: .center)
    }
    
    // vertical center alignment
    func vCenter()-> some View{
        self.frame(maxHeight: .infinity,alignment: .center)
    }
    
    // vertical top alignment
    func vTop()-> some View{
        self.frame(maxHeight: .infinity,alignment: .top)
    }
    
    // vertical bottom alignment
    func vBottom()-> some View{
        self.frame(maxHeight: .infinity,alignment: .bottom)
    }
    
    // hide keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    // place holder for textfield or text view
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
}
