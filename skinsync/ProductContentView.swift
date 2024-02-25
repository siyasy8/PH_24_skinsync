
import SwiftUI
import Combine

struct sItem {
    var id: Int
    var Name: String
    var NameLabel: String
    var Image: String
    var selected: Bool
}

struct Skincare2 {
    var id: Int
    var _name: String
    var proudct_url: String
    var clean_ingreds: [String]
    var price: String
    var proudct_type: String //
   
}

struct Resource {
    var id: Int
    var resourceName: String
    var resourceDescription: String
    var resources : [ResourcesItem]
}

struct ResourcesItem {
    var id: Int
    var resourceName: String
    var resourceImage: String
    var resourceDescription: String
}

struct SkincareData2 {
    var id: Int
    var skincare: [Skincare2]
}

struct FamousPoints {
    var id: Int
    var pointName: String
    var pointImage: String
    var pointDescription: String
}

class s: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var sCollection : [SkincareData2] {
       willSet {
            objectWillChange.send()
        }
    }
    
    var products: [sItem] {
        willSet {
                   objectWillChange.send()
               }
    }
    
    init(data: [SkincareData2], items: [sItem] ) {
        self.sCollection = data
        self.products = items
    }
}

class Selected: ObservableObject {
    @Published var index: Int = 0
}

struct sContentView: View {
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var sData : s
    @ObservedObject var selected = Selected()
    @State var isShowing: Bool = false
    @State var placeItemSelected: Skincare2? = nil
    @State private var searchText: String = ""

    

    @State private var isActive = false
    var filteredPlaces: [Skincare2] {
            if searchText.isEmpty {
                return Data.sCollection[selectedproduct.index].skincare
            } else {
                return Data.sCollection[selectedproduct.index].skincare.filter {
                    $0._name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }

    
    
    var body: some View {
        GeometryReader { g in
            ScrollView{
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 10){
                            ForEach(self.sData.products, id: \.id) { item in
                                ShopPromotionBannerView(sItems: item, selected: self.selected)
                                    .frame(width: 120, height: 60)
                            }
                        }.padding(.leading, 30)
                            .padding(.trailing, 30)
                            .padding(.bottom, 10)
                    }
                    .padding(.top, 20)
                    
                    Text("\(self.sData.products[self.selected.index].productNameLabel) Recommended")
                        .font(.system(size: 20))
                        .padding(.leading, 30)
                        .padding(.top, 10)
                    
                    TextField("Search s", text: $searchText)
                                          .textFieldStyle(RoundedBorderTextFieldStyle())
                                          .padding(.horizontal, 30)
                                          .padding(.bottom, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 10) {
                            ForEach(self.activtiesData.productsCollection[self.selected.index].skincare, id: \.id) { item in
                                Button(action: {
                                    self.placeItemSelected = item
                                    self.isShowing = true
                                }) {
                                    ShopBestSellerViews(Places: item)
                                        .frame(width: 155, height: 225)
                                }
                            }
                            
                        }.padding(.leading, 30)
                            .padding(.trailing, 30)
                            .padding(.bottom, 10)
                        
                    }
                    
//                    VStack (spacing: 20) {
//                        ForEach(self.activtiesData.productsCollection[self.selectedproduct.index].productResources, id: \.id) { item in
//                            ShopNewViews(productResources: item)
//                                .frame(width: g.size.width - 60, height: g.size.width - 60)
//                        }
//                    }.padding(.leading, 30)
                    
                    
                }
                .navigationBarTitle("s")
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.settings.loggedIn = false
                    self.isActive = true
                }) {
                    Text("Log Out")
                })
                .background(
                    NavigationLink(destination: StartingPageView(),
                                   isActive: self.$isActive
                                  ){
                                      EmptyView()
                                  }
                )
            }
            }.sheet(isPresented: self.$isShowing) { DetailView(isShowing: self.$isShowing, placeItem: self.$placeItemSelected)}
        }
    }

struct ShopBestSellerViews: View {
    
    var Places: Skincare2
    
    var body: some View {
            ZStack{
                Image("\(Places.proudct_url)").renderingMode(.original)
                        .resizable()
                        .frame(width: 155, height: 225)
                        .background(Color.black)
                        .cornerRadius(10)
                        .opacity(0.8)
                        .aspectRatio(contentMode: .fill)
               
                VStack (alignment: .leading) {
                    Spacer()
                    
                    Text(Places._name)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .bold, design: Font.Design.default))
                        .padding(.bottom, 24)
                }
                    
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.white)
          
    }
}

struct ShopPromotionBannerView: View {
    var activtiesItems: productsItem
    @ObservedObject var selectedproduct: productSelected
    
    var body: some View {
        
        Button(action: {
            self.selectedproduct.index = self.activtiesItems.id
            
        }) {
            GeometryReader { g in
                   ZStack{
                    Image("\(self.activtiesItems.productImage)").renderingMode(.original)
                       .resizable()
                       .opacity(0.8)
                       .aspectRatio(contentMode: .fill)
                       .background(Color.black)
                    
                    
                    if (self.selected.index == self.Items.id) {
                           Text("✓ \(self.Items.productName)")
                                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                    .foregroundColor(Color.white)
                    } else {
                             Text(self.activtiesItems.productName)
                                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                     .foregroundColor(Color.white)
                    }
                               
                   }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                   .cornerRadius(15)
               }
        }
    }
}


struct ShopNewViews: View {
    var productResources: productResource
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                VStack (alignment: .leading){
                    Text(self.productResources.resourceName)
                        .padding(.top, 18)
                        .padding(.leading, 18)
                        .font(.system(size: 20, weight: .bold, design: Font.Design.default))
                        .foregroundColor(Color.black)
                    Text(self.productResources.resourceDescription)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                        .font(.system(size: 14))
                        .foregroundColor(Color.black)
                    
                        
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack (spacing: 10) {
                            
                            ForEach(self.productResources.resources, id: \.id) { item in
                                productResourceItems(resourceItems: item)
                                                    .frame(width: 150, height: 200)
                            }
                            
                        }.padding(.leading, 18)
                        .padding(.trailing, 18)
                            .padding(.top, 25)
                    }
                    
                     Spacer()
                }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(10)
                
            }
        }
    }

struct productResourceItems: View {
    var resourceItems: productResourcesItem
    var body: some View {
        GeometryReader { g in
            ZStack{
                Image("\(self.resourceItems.resourceImage)")
                .resizable()
                .opacity(0.8)
                .aspectRatio(contentMode: .fill)
                .background(Color.black)
                VStack(alignment: .center) {

                    Text(self.resourceItems.resourceName)
                        .font(.system(size: 16, weight: .bold, design: Font.Design.default))
                        .frame(width: 150)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                }
                        
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .cornerRadius(10)
        }
    }
}

//#Preview {
//    productsContentView( activtiesData: <#products#>)
//}
