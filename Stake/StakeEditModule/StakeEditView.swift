import SwiftUI

struct StakeEditView: View {
    @StateObject var stakeEditModel =  StakeEditViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
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
                                    
                                    Text("Edit name, email")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)
                                
                                HStack {
                                    Rectangle()
                                        .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                        .overlay {
                                            VStack(spacing: 15) {
                                                VStack {
                                                    HStack {
                                                        VStack(alignment: .leading, spacing: 5) {
                                                            Text("Name")
                                                                .Pro(size: 16)
                                                            
                                                            CustomTextField(text: $stakeEditModel.name, placeholder: UserDefaultsManager().getName() ?? "Old name")
                                                        }
                                                        
                                                        Spacer()
                                                    }
                                                    
                                                    Rectangle()
                                                        .fill(Color(red: 82/255, green: 99/255, blue: 109/255))
                                                        .frame(height: 1)
                                                }
                                                
                                                VStack {
                                                    HStack {
                                                        VStack(alignment: .leading, spacing: 5) {
                                                            Text("Email")
                                                                .Pro(size: 16)
                                                            
                                                            CustomTextField(text: $stakeEditModel.email, placeholder: UserDefaultsManager().getEmail() ?? "Old email")
                                                        }
                                                        
                                                        Spacer()
                                                        
                                                    }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                        .frame(height: 195)
                                        .cornerRadius(10)
                                    
                                    VStack(spacing: 15) {
                                        Button(action: {
                                            stakeEditModel.changeUser { success in
                                                 if success {
                                                     stakeEditModel.isBack = true
                                                 }
                                             }
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                .overlay {
                                                    Text("Save")
                                                        .ProBold(size: 18)
                                                }
                                                .frame(width: 290, height: 45)
                                                .cornerRadius(8)
                                        }
                                        
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
                                                .frame(width: 290, height: 45)
                                                .cornerRadius(8)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.top, 40)
                            }
                            .padding(.horizontal, 10)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    }
                    .fullScreenCover(isPresented: $stakeEditModel.isBack) {
                        StakeSettingsView()
                    }
                    .alert(isPresented: $stakeEditModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(stakeEditModel.alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
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
                                
                                Text("Edit name, email")
                                    .ProBold(size: 24)
                                
                                Spacer()
                            }
                            .padding(.top, 30)
                            
                            HStack {
                                Rectangle()
                                    .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                    .overlay {
                                        VStack(spacing: 15) {
                                            VStack {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 5) {
                                                        Text("Name")
                                                            .Pro(size: 16)
                                                        
                                                        CustomTextField(text: $stakeEditModel.name, placeholder: UserDefaultsManager().getName() ?? "Old name")
                                                    }
                                                    
                                                    Spacer()
                                                }
                                                
                                                Rectangle()
                                                    .fill(Color(red: 82/255, green: 99/255, blue: 109/255))
                                                    .frame(height: 1)
                                            }
                                            
                                            VStack {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 5) {
                                                        Text("Email")
                                                            .Pro(size: 16)
                                                        
                                                        CustomTextField(text: $stakeEditModel.email, placeholder: UserDefaultsManager().getEmail() ?? "Old email")
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                    .frame(height: 195)
                                    .cornerRadius(10)
                                
                                VStack(spacing: 15) {
                                    Button(action: {
                                        stakeEditModel.changeUser { success in
                                             if success {
                                                 stakeEditModel.isBack = true
                                             }
                                         }
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                            .overlay {
                                                Text("Save")
                                                    .ProBold(size: 18)
                                            }
                                            .frame(width: 290, height: 45)
                                            .cornerRadius(8)
                                    }
                                    
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
                                            .frame(width: 290, height: 45)
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .padding(.top, 40)
                        }
                        .padding(.horizontal, 10)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                }
                .fullScreenCover(isPresented: $stakeEditModel.isBack) {
                    StakeSettingsView()
                }
                .alert(isPresented: $stakeEditModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(stakeEditModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeEditView()
}

