
import Foundation
import SwiftUI

struct StartingPageView: View {
    var body: some View {
        VStack {
            Image("Image 1") // Replace with your actual image name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            NavigationLink(destination: SignUpView()) {
                Text("Sign Up")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            NavigationLink(destination: LoginView()) {
                Text("Login")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct LoginView: View {
    var body: some View {
        Text("Login View")
    }
}
