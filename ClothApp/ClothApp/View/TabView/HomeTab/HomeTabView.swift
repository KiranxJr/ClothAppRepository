//
//  HomeTabView.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI

struct HomeTabView: View {
    
    // passed viewmodel object for shared viewmodel
    @EnvironmentObject var sharedData : SharedViewModel
    // passed viewmodel object for Home viewmodel
    @EnvironmentObject var homeData : HomeViewModel
    // passed animation object
    var animation : Namespace.ID
    // Instance of font class
    var font : FontClass = FontClass()
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            
            HStack{
                // Menu button
                Button {
                    
                } label: {
                    Image("Menu")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                
                Spacer()
            } .padding(.horizontal,20)
            
            VStack(alignment: .leading) {
                // Title text
                Text("New Arrivals")
                    .font(.custom(font.semiBold, size: 32))
                    .foregroundColor(.black)
                // Description Text
                Text("Custom clothing for the mordern unique man")
                    .font(.custom(font.light, size: 12))
                    .foregroundColor(.gray)
            } .padding(.horizontal,20)
            // Custom search field view
            SearchTextFieldView(searchText: $homeData.searchText, buttonClicked: $homeData.buttonClicked, searchHint: "Search items...")
                .foregroundColor(.black)
                .padding(.horizontal,20)
            // Getting search filed event
                .onChange(of: homeData.searchText) { newValue in
                    homeData.buttonClicked = false
                }
            
            if homeData.loadingHome {
                // Lottie animation for loading
                ProductLoadingView()
                
            } else {
                
                if homeData.productList.isEmpty {
                    ProductErrorView()
                } else {
                    if homeData.filteredProductList.isEmpty {
                        FilteredErrorView()
                    } else {
                        // Product list view
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 20){
                                ForEach(homeData.filteredProductList) { item in
                                    // product list item view
                                    ItemCardView(item: item)
                                    
                                }
                            }  .padding(.horizontal,20)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    
                }
                
            }
            
        }
        .padding(.top)
        
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
        .background(Color("Background"))
        .onAppear {
            // Enables loading screen
            homeData.loadingHome = true
            // calls get product list api from view model
            homeData.getProductList()
        }
        
    }
    
    
    // Subview for loading
    @ViewBuilder
    private func ProductLoadingView() -> some View {
        LottieView(name: "Loading", loopMode: .repeat(20))
            .padding(.horizontal,20)
            .frame(width: getRect().width / 3, height: getRect().width / 3)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
    }
    
    // Subview for error
    @ViewBuilder
    private func ProductErrorView() -> some View {
        VStack {
            
            LottieView(name: "error", loopMode: .playOnce)
                .frame(width: getRect().width / 2, height: getRect().width / 2)
            Text(homeData.loadErrorText)
                .font(.custom(font.semiBold, size: 12))
                .foregroundColor(.black)
            Button {
                // Enables loading screen
                homeData.loadingHome = true
                // Api call to get product list
                homeData.getProductList()
            } label: {
                HStack {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("Primary"))
                    Text("Retry")
                        .font(.custom(font.semiBold, size: 12))
                        .foregroundColor(.black)
                }
            }
            
        }  .padding(.horizontal,20)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
    }
   // Subview for filtered error
    @ViewBuilder
    private func FilteredErrorView() -> some View {
        VStack {
            // No result found animation
            LottieView(name: "NoResults", loopMode: .playOnce)
                .padding(.horizontal,20)
                .frame(width: getRect().width / 3, height: getRect().width / 3)
            Text("Nothing to show here...")
                .font(.custom(font.semiBold, size: 12))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
    }
    
    // custom view for each product in list
    @ViewBuilder
    private func ItemCardView(item : ProductItemModel)-> some View {
        Button {
            withAnimation {
                // enables details page
                sharedData.showDetailedPage = true
                // initialize selected item
                homeData.selectedItem = item
            }
        } label: {
            HStack {
                // Loading url image
                AsyncImage(url:  URL(string: item.image ?? "")  ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: item.id, in: animation)
                        .frame(width: 110, height: 130)
                } placeholder: {
                    Image("PlaceHolder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: item.id, in: animation)
                        .frame(width: 110, height: 130)
                }
                
                
                // getting remaining space in view
                GeometryReader { reader in
                    
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text(item.title ?? "")
                                .font(.custom(font.semiBold, size: 13))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                            HStack {
                                // custom rate view
                                StarsView(rating: homeData.trimRate(value: item.rating?.rate ?? 0.0))
                                Text("\(String(format: "%.1f", item.rating?.rate ?? 0.0))")
                                    .font(.custom(font.medium, size: 10))
                                    .foregroundColor(.black)
                                Text("(\(item.rating?.count ?? 0))")
                                    .font(.custom(font.medium, size: 10))
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: reader.size.width, height: reader.size.height / 2,alignment: .leading)
                        Spacer()
                        HStack {
                            Spacer()
                            Text("$\(Int(item.price ?? 0))")
                                .font(.custom(font.semiBold, size: 18))
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray)
            )
        }
        
    }
}

//struct HomeTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTabView(, animation: <#Namespace.ID#>)
//    }
//}
