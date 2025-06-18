import SwiftUI

struct StakeCreatePredictionView: View {
    @StateObject var stakeCreatePredictionModel =  StakeCreatePredictionViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    @State private var selectedImage2: UIImage? = nil
    @State private var isImagePickerPresented2 = false
    
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
                                    
                                    Text("New prediction")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)

                                Rectangle()
                                    .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                    .overlay {
                                        VStack(spacing: 3) {
                                            CustomClearTextField(text: $stakeCreatePredictionModel.name, placeholder: "Predict the outcome of the event")
                                            
                                            Rectangle()
                                                .fill(Color(red: 57/255, green: 63/255, blue: 76/255))
                                                .frame(height: 1)
                                                .padding(.horizontal)
                                            
                                            HStack {
                                                Button(action: {
                                                    isImagePickerPresented = true
                                                }) {
                                                    if let image = selectedImage {
                                                        Image(uiImage: image)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 35, height: 35)
                                                            .clipShape(RoundedRectangle(cornerRadius: 35 / 2))
                                                    } else {
                                                        Image(.choosePhoto)
                                                            .resizable()
                                                            .frame(width: 35, height: 35)
                                                    }
                                                }
                                                .sheet(isPresented: $isImagePickerPresented) {
                                                    ImagePicker(image: $selectedImage, isPresented: $isImagePickerPresented)
                                                }
                                                
                                                CustomClearTextField(text: $stakeCreatePredictionModel.firstTeamName, placeholder: "Enter the name of the team or player", textSize: 17, isBold: false)
                                                
                                                Text("VS")
                                                    .ProBold(size: 14, color: Color(red: 137/255, green: 141/255, blue: 148/255))
                                                
                                                CustomClearTextField(text: $stakeCreatePredictionModel.secondTeamName, placeholder: "Enter the name of the team or player", textSize: 17, isBold: false)
                                                
                                                Button(action: {
                                                    isImagePickerPresented2 = true
                                                }) {
                                                    if let image = selectedImage2 {
                                                        Image(uiImage: image)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 35, height: 35)
                                                            .clipShape(RoundedRectangle(cornerRadius: 35 / 2))
                                                    } else {
                                                        Image(.choosePhoto)
                                                            .resizable()
                                                            .frame(width: 35, height: 35)
                                                    }
                                                }
                                                .sheet(isPresented: $isImagePickerPresented2) {
                                                    ImagePicker(image: $selectedImage2, isPresented: $isImagePickerPresented2)
                                                }
                                            }
                                            .padding(.horizontal)
                                            .padding(.top, 12)
                                            
                                            HStack {
                                                DateTF(date: $stakeCreatePredictionModel.date)
                                                
                                                Spacer()
                                            }
                                            
                                            Rectangle()
                                                .fill(Color(red: 57/255, green: 63/255, blue: 76/255))
                                                .frame(height: 1)
                                                .padding(.horizontal)
                                            
                                            CustomTextView(text: $stakeCreatePredictionModel.desc, placeholder: "Start typing what you expect the outcome of the sporting event to be", height: 90)
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
                                stakeCreatePredictionModel.savePrediction(
                                    firstTeamImage: selectedImage,
                                    secondTeamImage: selectedImage2
                                ) { success in
                                    if success {
                                        stakeCreatePredictionModel.isBack = true
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
                    .alert(isPresented: $stakeCreatePredictionModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(stakeCreatePredictionModel.alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .fullScreenCover(isPresented: $stakeCreatePredictionModel.isBack) {
                        StakePredictionsView()
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
                                
                                Text("New prediction")
                                    .ProBold(size: 24)
                                
                                Spacer()
                            }
                            .padding(.top, 30)

                            Rectangle()
                                .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                .overlay {
                                    VStack(spacing: 3) {
                                        CustomClearTextField(text: $stakeCreatePredictionModel.name, placeholder: "Predict the outcome of the event")
                                        
                                        Rectangle()
                                            .fill(Color(red: 57/255, green: 63/255, blue: 76/255))
                                            .frame(height: 1)
                                            .padding(.horizontal)
                                        
                                        HStack {
                                            Button(action: {
                                                isImagePickerPresented = true
                                            }) {
                                                if let image = selectedImage {
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 35, height: 35)
                                                        .clipShape(RoundedRectangle(cornerRadius: 35 / 2))
                                                } else {
                                                    Image(.choosePhoto)
                                                        .resizable()
                                                        .frame(width: 35, height: 35)
                                                }
                                            }
                                            .sheet(isPresented: $isImagePickerPresented) {
                                                ImagePicker(image: $selectedImage, isPresented: $isImagePickerPresented)
                                            }
                                            
                                            CustomClearTextField(text: $stakeCreatePredictionModel.firstTeamName, placeholder: "Enter the name of the team or player", textSize: 17, isBold: false)
                                            
                                            Text("VS")
                                                .ProBold(size: 14, color: Color(red: 137/255, green: 141/255, blue: 148/255))
                                            
                                            CustomClearTextField(text: $stakeCreatePredictionModel.secondTeamName, placeholder: "Enter the name of the team or player", textSize: 17, isBold: false)
                                            
                                            Button(action: {
                                                isImagePickerPresented2 = true
                                            }) {
                                                if let image = selectedImage2 {
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 35, height: 35)
                                                        .clipShape(RoundedRectangle(cornerRadius: 35 / 2))
                                                } else {
                                                    Image(.choosePhoto)
                                                        .resizable()
                                                        .frame(width: 35, height: 35)
                                                }
                                            }
                                            .sheet(isPresented: $isImagePickerPresented2) {
                                                ImagePicker(image: $selectedImage2, isPresented: $isImagePickerPresented2)
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.top, 12)
                                        
                                        HStack {
                                            DateTF(date: $stakeCreatePredictionModel.date)
                                            
                                            Spacer()
                                        }
                                        
                                        Rectangle()
                                            .fill(Color(red: 57/255, green: 63/255, blue: 76/255))
                                            .frame(height: 1)
                                            .padding(.horizontal)
                                        
                                        CustomTextView(text: $stakeCreatePredictionModel.desc, placeholder: "Start typing what you expect the outcome of the sporting event to be", height: 90)
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
                            stakeCreatePredictionModel.savePrediction(
                                firstTeamImage: selectedImage,
                                secondTeamImage: selectedImage2
                            ) { success in
                                if success {
                                    stakeCreatePredictionModel.isBack = true
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
                .alert(isPresented: $stakeCreatePredictionModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(stakeCreatePredictionModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .fullScreenCover(isPresented: $stakeCreatePredictionModel.isBack) {
                    StakePredictionsView()
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeCreatePredictionView()
}

