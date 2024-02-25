import SwiftUI

struct SkinColorTile: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(color)
            .frame(width: 50, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.white, lineWidth: isSelected ? 2 : 0)
            )
            .onTapGesture {
                action()
            }
    }
}

struct AccountView: View {
    @State private var notificationToggle: Bool = false
    @State private var locationUsage: Bool = false
    @State private var username: String = "James"
    @State private var selectedRace: Int = 0
    @State private var raceArray: [String] = ["White", "Black", "Hispanic", "East Asian", "South Asian", "Pacific Islander", "Native American", "Multiracial"]
    
    @State private var selectedGender: Int = 1
    @State private var genderArray: [String] = ["Female", "Male", "Rather Not Say"]
    
    @State private var selectedAge: Int = 1
    @State private var ageArray: [String] = ["18 - 25", "26 - 35", "36 - 45", "46 - 55", "56+"]
    
    @State private var selectedSkin: Int = 1
    @State private var skinArray: [String] = ["Oily", "Dry", "Combination"]
    @State private var selectedSkinColor: Int?

    var body: some View {
        GeometryReader { g in
            VStack {
                Image("profile_pic")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .padding(.bottom, 10)
                Text("Name")
                    .font(.system(size: 20))
                    
                Form {
                    Section(header: Text("Demographic Information")) {
                        Picker(selection: self.$selectedRace, label: Text("Race")) {
                            ForEach(0 ..< self.raceArray.count) {
                                Text(self.raceArray[$0]).tag($0)
                            }
                        }
                        
                        Picker(selection: self.$selectedGedner, label: Text("Gender")) {
                            ForEach(0 ..< self.genderArray.count) {
                                Text(self.genderArray[$0]).tag($0)
                            }
                        }
                        Picker(selection: self.$selectedAge, label: Text("Age")) {
                            ForEach(0 ..< self.ageArray.count) {
                                Text(self.ageArray[$0]).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Skin Information")) {
                        Picker(selection: self.$selectedSkin, label: Text("Skin Type")) {
                            ForEach(0 ..< self.skinArray.count) {
                                Text(self.skinArray[$0]).tag($0)
                            }
                        }

                        HStack {
                            ForEach(0 ..< skinColors.count) { index in
                                SkinColorTile(
                                    color: skinColors[index],
                                    isSelected: index == selectedSkinColor,
                                    action: {
                                        selectedSkinColor = index
                                    }
                                )
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Section(header: Text("Personal Information")) {
                       NavigationLink(destination: Text("Profile Info")) {
                            Text("Profile Information")
                        }
                       
                    }
                    
                }
            }
            .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
            .navigationBarTitle("Settings")
         }
    }
    
    private let skinColors: [Color] = [
        .init(red: 1, green: 0.87, blue: 0.77),
        .init(red: 1, green: 0.83, blue: 0.64),
        .init(red: 0.87, green: 0.55, blue: 0.35),
        .init(red: 0.66, green: 0.31, blue: 0.16),
        .init(red: 0.41, green: 0.15, blue: 0.07),
        .init(red: 0.28, green: 0.08, blue: 0.02)
    ]
}
