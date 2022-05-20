//
//  HomeViewModel.swift
//  ClothApp
//
//  Created by Dilshad N on 19/05/22.
//

import SwiftUI

// ViewModel class for home page
class HomeViewModel: ObservableObject {
    // constant instance of rest manager class
    let rest = RestManager()
    // holds search field value
    @Published var searchText : String = ""
    
    // holds products
    @Published var productList : [ProductItemModel] = []
    // loading home screen data
    @Published var loadingHome : Bool = false
    // load screen error text
    @Published var loadErrorText : String = ""
    // selected item from product list
    @Published var selectedItem : ProductItemModel = ProductItemModel()
    
    // Search field button click
    @Published var buttonClicked: Bool = false
    
    // Filtering produt list
     var filteredProductList: [ProductItemModel]  {
        if self.searchText.isEmpty {
            return self.productList
        } else {
            var list: [ProductItemModel] = []
            if buttonClicked == true {
                list = self.productList.filter {
                    $0.title!.contains(searchText)
                }
            } else {
                list = productList
            }
            return list
        }
    }
    
    // Api call for getting  product list
    func getProductList() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                print("result")
                let decoder = JSONDecoder()
                guard let productData = try? decoder.decode([ProductItemModel].self, from: data) else {
                    print("result error")
                    DispatchQueue.main.async {
                        self.loadingHome = false
                        self.loadErrorText = "Something went wrong"
                    }
                    
                    return }
                print(productData)
                DispatchQueue.main.async {
                    self.productList = productData
                    self.loadingHome = false
                    self.loadErrorText = ""
                }
            } else{
                print("error")
                self.loadingHome = false
                self.loadErrorText = "Something went wrong"
            }
        }
    }
    
     func trimRate(value: Double) -> Float {
         let string = String(format: "%.1f", value)
         let float = Float(string) ?? 0.0
         print(float)
        return float
        
    }
}
