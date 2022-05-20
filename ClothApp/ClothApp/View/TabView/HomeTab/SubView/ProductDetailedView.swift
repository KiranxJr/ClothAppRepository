//
//  DetailedView.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI

struct ProductDetailedView: View {
    // passed instance of shared view model
    @EnvironmentObject var sharedData : SharedViewModel
    // passed instance of home view model
    @EnvironmentObject var homeData : HomeViewModel
    // instance of font class
     var font : FontClass = FontClass()
    // passed animation instance
    var animation : Namespace.ID
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea([.top,.bottom])
            VStack {
                VStack(){
                    HStack {
                        
                        Button {
                            withAnimation {
                                // Disable detail page
                                sharedData.showDetailedPage = false
                                // Empty selected item
                                homeData.selectedItem = ProductItemModel()
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button {
                            // Wishlist button
                            
                        } label: {
                            Image("Heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .padding()
                                .background(
                                    Color.white
                                        .clipShape(Circle())
                                )
                        }
                        
                        
                    }
                    // Loading url image
                    AsyncImage(url: URL(string: homeData.selectedItem.image ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: homeData.selectedItem.id, in: animation)
                            .frame(width: getRect().width / 1.5, height:  getRect().width / 1.5)
                    } placeholder: {
                        Image("PlaceHolder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: homeData.selectedItem.id, in: animation)
                            .frame(width: getRect().width / 1.5, height:  getRect().width / 1.5)
                    }
                    
                    
                }
                .padding(.horizontal,20)
                .frame(height: getRect().height / 2)
                .background(Color("Background"))
                // product details
                VStack(alignment: .leading,spacing: 0){
                    // Details of product
                    ProductDetailSubview()
                }
                .padding(20)
                .frame(height: getRect().height / 2)
                .hLeading()
                .background(
                    Color.white
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 50))
                        .shadow(radius: 2)
                    
                    
                )
            } .padding(.top)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(
                    Color("Background"))
        }
    }
    @ViewBuilder
    private func ProductDetailSubview() -> some View {
        
            // product category
            Text(homeData.selectedItem.category ?? "")
                .font(.custom(font.medium, size: 12))
                .foregroundColor(.gray)
            // product title
            Text(homeData.selectedItem.title ?? "")
                .font(.custom(font.semiBold, size: 20))
                .foregroundColor(.black)
                .padding(.top,1)
            HStack {
                // custom rate view
                StarsView(rating: homeData.trimRate(value: homeData.selectedItem.rating?.rate ?? 0.0))
                // product rate
                Text("\(String(format: "%.1f", homeData.selectedItem.rating?.rate ?? 0.0))")
                    .font(.custom(font.medium, size: 10))
                    .foregroundColor(.black)
                // product count
                Text("(\(homeData.selectedItem.rating?.count ?? 0))")
                    .font(.custom(font.medium, size: 10))
                    .foregroundColor(.black)
            }  .padding(.top,8)
            ScrollView {
                // product description
                Text(homeData.selectedItem.description ?? "")
                    .font(.custom(font.semiBold, size: 12))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.top,25)
            }
            
            Spacer()
            HStack {
                // product price
                Text("$\(Int(homeData.selectedItem.price ?? 0))")
                    .font(.custom(font.medium, size: 19))
                    .foregroundColor(.black)
                Spacer()
                // Add to cart
                Button {
                    
                } label: {
                    Text("Add to Cart")
                        .font(.custom(font.semiBold, size: 16))
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color("Primary").clipShape(RoundedRectangle(cornerRadius: 10)))
                }  .hTrailing()
                
            }
            .padding(.bottom)
        
    }
}

//struct DetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailedView()
//    }
//}
