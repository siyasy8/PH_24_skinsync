

import SwiftUI

struct TabbarView: View {
//    guard let filepath = Bundle.main.path(forResource: "skincare_products_clean", ofType: "csv") else {
//        return
//    }
//    
//    var data = ""
//    do {
//        data = try String(contentsOfFile: filepath)
//    } catch {
//        print(error)
//        return
//    }
    @ObservedObject var mockStore = ActivitiesMockStore()
    
    var body: some View {
        TabView {
            NavigationView {
                ActivitiesContentView(activtiesData: Activities(data: mockStore.skincare_data, items: ActivitiesMockStore.activities))
            }
            .tag(0)
            .tabItem {
                Image("product-1")
                    .resizable()
                Text("Products")
            }
            
            NavigationView {
                ActivitiesCartView(ShoppingCartItemsData: ActivitiesCart(data: ActivitiesMockStore.shoppingCartData))
            }
            .tag(1)
            .tabItem {
                Image("shopping-cart-icon")
                Text("Wishlist")
            }
            
            NavigationView {
                     AccountView()
                  }
                   .tag(2)
                    .tabItem {
                    Image("profile-glyph-icon")
                    Text("Account")
                }
        }
    }
}



