//
//  HomeView.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI

// enum for bottom tab options
enum Tab : String,CaseIterable {
    case Home = "house"
    case Wishlist = "heart"
    case Cart = "cart"
    case User = "person"
}


struct HomeView: View {
    // viewmodel object passed
    @EnvironmentObject var sharedData : SharedViewModel
    
    // Current bottom tab selected
    @State private var currentTab : Tab = .Home
    // Provide animation
    @Namespace var animation
    // created homeViewmodel instance
    @StateObject var homeData : HomeViewModel = HomeViewModel()
    
    // Hiding tab bar
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing:0){
            // Tabview to view all view according to selected tab
            TabView(selection: $currentTab) {
                
                // Home tab view
                HomeTabView(animation: animation)
                    .environmentObject(sharedData)
                    .environmentObject(homeData)
                    .tag(Tab.Home)
                
                // Wish tab view
                WishlistTabView()
                    .tag(Tab.Wishlist)
                
                // Cart tab view
                CartTabView()
                    .tag(Tab.Cart)
                
                // User tab view
                UserTabView()
                    .tag(Tab.User)
                
            }
            
            // Tab Bar
            ZStack{
                HStack(spacing:0){
                    // Looping through all tab cases
                    ForEach(Tab.allCases,id:\.self){ tab in
                        // Tab button
                        Button{
                            // on button tap current tab is selected
                            withAnimation {
                                currentTab = tab
                                
                            }
                            
                        }label:{
                            
                            // Image view for tab
                            Image(systemName: currentTab == tab ? "\(tab.rawValue).fill" : tab.rawValue )
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .frame(maxWidth:.infinity)
                                .foregroundColor(currentTab == tab ? Color("Primary") : Color.gray)
                            
                            
                            
                            
                        }
                    }
                }  .padding()
                    .padding(.bottom)
                // background for tab
                    .background(
                        Rectangle()
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                    )
                
            }
        }.edgesIgnoringSafeArea(.bottom)
            .overlay(
                // overlay to show pages over home view
                ZStack {
                    // Showing detail page on condition check
                    if sharedData.showDetailedPage == true {
                        ProductDetailedView(animation: animation)
                            .environmentObject(sharedData)
                            .environmentObject(homeData)
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                    }
                }
            
            )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
