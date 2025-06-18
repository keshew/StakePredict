import SwiftUI

struct StakeCreateTeamNoteView: View {
    @StateObject var stakeCreateTeamNoteModel =  StakeCreateTeamNoteViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    var isPortrait: Bool {
        UIScreen.main.bounds.height > UIScreen.main.bounds.width
    }
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            Group {
                if isPortrait {
                    
                } else {
                    ZStack {
                        Color(red: 22/255, green: 32/255, blue: 51/255)
                            .ignoresSafeArea()
                        
                        Image(.bg)
                            .resizable()
                            .ignoresSafeArea()
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 30) {
                                HStack {
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "chevron.left")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 24))
                                    }
                                    
                                    Spacer()
                                    
                                    Text("New note")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)

                                Rectangle()
                                    .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                    .overlay {
                                        VStack(spacing: 5) {
                                            HStack(spacing: -5) {
                                                Button(action: {
                                                    isImagePickerPresented = true
                                                }) {
                                                    if let image = selectedImage {
                                                        Image(uiImage: image)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 35, height: 35)
                                                            .clipShape(RoundedRectangle(cornerRadius: 35 / 2))
                                                            .padding(.leading)
                                                    } else {
                                                        Image(.choosePhoto)
                                                            .resizable()
                                                            .frame(width: 35, height: 35)
                                                            .padding(.leading)
                                                    }
                                                }
                                                .sheet(isPresented: $isImagePickerPresented) {
                                                    ImagePicker(image: $selectedImage, isPresented: $isImagePickerPresented)
                                                }
                                                
                                                CustomClearTextField(text: $stakeCreateTeamNoteModel.name, placeholder: "Note title")
                                            }
                                            
                                            Rectangle()
                                                .fill(Color(red: 57/255, green: 63/255, blue: 76/255))
                                                .frame(height: 1)
                                                .padding(.horizontal)
                                                .padding(.top, 3)
                                            
                                            CustomTextView(text: $stakeCreateTeamNoteModel.desc, placeholder: "Start typing the text of the new note...")
                                        }
                                    }
                                    .frame(height: 235)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 50)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                        
                        HStack(spacing: 15) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Rectangle()
                                    .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(red: 137/255, green: 141/255, blue: 148/255), lineWidth: 1)
                                            .overlay {
                                                Text("Back")
                                                    .Pro(size: 18, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                            }
                                    }
                                    .frame(width: 130, height: 45)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                stakeCreateTeamNoteModel.saveTeamNote(image: selectedImage) { success in
                                    if success {
                                        stakeCreateTeamNoteModel.isBack = true
                                    }
                                }
                            }) {
                                Rectangle()
                                    .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                    .overlay {
                                        Text("Save")
                                            .ProBold(size: 18)
                                    }
                                    .frame(width: 130, height: 45)
                                    .cornerRadius(8)
                            }
                        }
                        .position(x: UIScreen.main.bounds.width / 1.2, y: UIScreen.main.bounds.height / 3.25)
                    }
                    .alert(isPresented: $stakeCreateTeamNoteModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(stakeCreateTeamNoteModel.alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .fullScreenCover(isPresented: $stakeCreateTeamNoteModel.isBack) {
                        StakeTeamNotesView()
                    }
                }
            }
        } else {
            if verticalSizeClass == .compact {
                ZStack {
                    Color(red: 22/255, green: 32/255, blue: 51/255)
                        .ignoresSafeArea()
                    
                    Image(.bg)
                        .resizable()
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 30) {
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24))
                                }
                                
                                Spacer()
                                
                                Text("New note")
                                    .ProBold(size: 24)
                                
                                Spacer()
                            }
                            .padding(.top, 30)

                            Rectangle()
                                .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                .overlay {
                                    VStack(spacing: 5) {
                                        HStack(spacing: -5) {
                                            Button(action: {
                                                isImagePickerPresented = true
                                            }) {
                                                if let image = selectedImage {
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 35, height: 35)
                                                        .clipShape(RoundedRectangle(cornerRadius: 35 / 2))
                                                        .padding(.leading)
                                                } else {
                                                    Image(.choosePhoto)
                                                        .resizable()
                                                        .frame(width: 35, height: 35)
                                                        .padding(.leading)
                                                }
                                            }
                                            .sheet(isPresented: $isImagePickerPresented) {
                                                ImagePicker(image: $selectedImage, isPresented: $isImagePickerPresented)
                                            }
                                            
                                            CustomClearTextField(text: $stakeCreateTeamNoteModel.name, placeholder: "Note title")
                                        }
                                        
                                        Rectangle()
                                            .fill(Color(red: 57/255, green: 63/255, blue: 76/255))
                                            .frame(height: 1)
                                            .padding(.horizontal)
                                            .padding(.top, 3)
                                        
                                        CustomTextView(text: $stakeCreateTeamNoteModel.desc, placeholder: "Start typing the text of the new note...")
                                    }
                                }
                                .frame(height: 235)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 10)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    
                    HStack(spacing: 15) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Rectangle()
                                .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 137/255, green: 141/255, blue: 148/255), lineWidth: 1)
                                        .overlay {
                                            Text("Back")
                                                .Pro(size: 18, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                        }
                                }
                                .frame(width: 130, height: 45)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            stakeCreateTeamNoteModel.saveTeamNote(image: selectedImage) { success in
                                if success {
                                    stakeCreateTeamNoteModel.isBack = true
                                }
                            }
                        }) {
                            Rectangle()
                                .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                .overlay {
                                    Text("Save")
                                        .ProBold(size: 18)
                                }
                                .frame(width: 130, height: 45)
                                .cornerRadius(8)
                        }
                    }
                    .position(x: UIScreen.main.bounds.width / 1.42, y: UIScreen.main.bounds.height / 1.25)
                }
                .alert(isPresented: $stakeCreateTeamNoteModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(stakeCreateTeamNoteModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .fullScreenCover(isPresented: $stakeCreateTeamNoteModel.isBack) {
                    StakeTeamNotesView()
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeCreateTeamNoteView()
}

import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isPresented = false // Только это!
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false // Только это!
        }
    }
}

