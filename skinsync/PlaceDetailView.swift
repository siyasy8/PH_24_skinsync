

import SwiftUI
import Combine

class SelectedPoint: ObservableObject {
    @Published var selectedIndex: Int = 0
}

struct PlaceDetailView : View {
    @Binding var isShowing: Bool
    @Binding var placeItem: Skincare2?
    let defaultPoint = ProductPoints(id: 0, pointName: "Default", pointImage: "Default PlaceHolder", pointDescription: "Default Description PlaceHolder")
    
    @ObservedObject var selectedPoint = SelectedPoint()
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                Image(self.placeItem?.clean_ingreds[self.selectedPoint.selectedIndex] ?? "")
                    .resizable()
                    .frame(width: g.size.width, height: g.size.height)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
                    .background(Color.black)
                    .onDisappear {
                        self.isShowing = false
                }
                
                VStack(alignment: .leading) {
                    Text(self.placeItem?.product_name ?? "")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .padding(.top, 34)
                        .padding(.leading, 30)
                    HStack{
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text(self.placeItem?.clean_ingreds.joined(separator: ",") ?? "")
                        .foregroundColor(Color.white)
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .padding(.top, 34)
                        .padding(.leading, 30)
                    
//                    PlacesDetail(placeItems: self.placeItem?.clean_ingreds[self.selectedPoint.selectedIndex] ?? self.defaultPoint)
//                        .padding(.bottom, 50)
                    
//                    ZStack {
//                        BlurView(style: .light)
//                            .frame(width: g.size.width, height: 130)
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(self.placeItem?.clean_ingreds ?? [], id: \.id) { item in
//                                    PlacesCircleView(placeItems: item, selectedPoint: self.selectedPoint)
//                                }
//                            }.frame(width: g.size.width, height: 130)
//                        }
//                    }.padding(.bottom, 50)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ProductCircleView: View {
    var placeItems: productsFamousPoints
    @ObservedObject var selectedPoint: SelectedPoint
    
    var body: some View {
        GeometryReader { g in
            Button(action: {
                self.selectedPoint.selectedIndex = self.placeItems.id
            }) {
                ZStack {
                    Image(self.placeItems.pointImage).renderingMode(.original)
                        .resizable()
                        .frame(width: 110, height: 110)
                        .background(Color.red)
                        .clipShape(Circle())
                    
                    if (self.selectedPoint.selectedIndex == self.placeItems.id) {
                           Text("✓")
                                .font(.system(size: 30, weight: .bold, design: Font.Design.default))
                                .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}

struct ProductsDetail: View {
    var placeItems: productsFamousPoints
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(placeItems.pointName)
                .foregroundColor(Color.white)
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.leading, 30)
            
            Text(placeItems.pointDescription)
                .foregroundColor(Color.white)
                .font(.system(size: 16, weight: .regular, design: .default))
                .padding(.leading, 30)
                .padding(.trailing, 30)
        }
    }
}
