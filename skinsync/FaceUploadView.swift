

import Foundation
import SwiftUI
import UIKit
import CoreML

struct ContentView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerDisplay = false
    @State private var predictionResult: String = ""

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            
            Button("Select Image") {
                self.isImagePickerDisplay = true
            }
            .padding()
            
            Button("Submit for Test") {
                if let selectedImage = selectedImage {
                    submitImageForTest(image: selectedImage)
                }
            }
            .padding()
            .disabled(selectedImage == nil)
            
            Text("Prediction Result: \(predictionResult)")
        }
        .sheet(isPresented: $isImagePickerDisplay) {
            PhotoPicker(selectedImage: self.$selectedImage)
        }
    }
    
    func submitImageForTest(image: UIImage) {
        // Convert UIImage to CIImage
        guard let ciImage = CIImage(image: image) else {
            fatalError("Couldn't convert UIImage to CIImage")
        }
        
        // Load the ML model
        guard let model = try? MyCreateMLModel(configuration: MLModelConfiguration()) else {
            fatalError("Couldn't load CreateML model")
        }
        
        // Perform prediction
        do {
            let prediction = try model.prediction(image: ciImage)
            predictionResult = prediction.label
        } catch {
            print(error)
            predictionResult = "Error making prediction"
        }
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
