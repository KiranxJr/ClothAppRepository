//
//  SearchTextFieldView.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI

// custom search textfield view
struct SearchTextFieldView: View {
    // search text constant value
    @Binding var searchText : String
    @Binding var buttonClicked: Bool
    
    
    // search text hint
    var searchHint : String
    var font : FontClass = FontClass()
    var body: some View {
        
        
        HStack(spacing: 0){
            
            ZStack(alignment: .leading) {
                Text(searchHint)
                    .foregroundColor($searchText.wrappedValue.isEmpty ? Color.clear : Color.black)
                    .font(.custom(font.regular, size: 14))
                    .padding(.horizontal,1)
                // Overlay hint to the border
                    .background(
                        RoundedRectangle(cornerRadius: 2).foregroundColor(.white))
                    .offset(x: $searchText.wrappedValue.isEmpty ? 0 : 10,y: $searchText.wrappedValue.isEmpty ? 0 : -41)
                    .scaleEffect($searchText.wrappedValue.isEmpty ? 1 : 0.8, anchor: .leading)
                TextField("", text: $searchText) // give TextField an empty placeholder
                    .font(.custom(font.regular, size: 14))
                    .foregroundColor(.black)
                // custom modifier for hint
                    .placeholder(when: $searchText.wrappedValue ==   "") {
                        Text(searchHint).foregroundColor(.gray)
                            .font(.custom(font.regular, size: 14))
                            .lineLimit(1)
                    }
                
            } .padding(.horizontal)
                .padding(.vertical,12)
                .frame(height: 50)
            Button {
                withAnimation {
                    // search field button click to true
                    self.buttonClicked = true
                    // hide keyboard
                    hideKeyboard()
                }
            } label: {
                Image("Search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(
                        Color("Primary")
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
            }
            .padding(5)
            .padding(.trailing, 7)
            
            
        }
        .background(
            ZStack {
                Color.white
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black)
                
            }
            
            
        )  .animation(.spring(response: 0.2, dampingFraction: 0.5), value: $searchText.wrappedValue.isEmpty )
        
    }
}

struct SearchTextFieldView_Previews: PreviewProvider {
static var previews: some View {
    SearchTextFieldView(searchText: .constant(""), buttonClicked: .constant(false),searchHint: "hint")
}
}
