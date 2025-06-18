import SwiftUI

struct StakeSignInView: View {
    @StateObject var stakeSignInModel =  StakeSignInViewModel()
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
                                    
                                    Text("Hello!")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text("Create an account to get access to all features and possibilites of Habit Tracker")
                                            .Pro(size: 16)
                                        
                                        HStack {
                                            CustomTextField(text: $stakeSignInModel.name, placeholder: "Your name")
                                            
                                            CustomTextField(text: $stakeSignInModel.email, placeholder: "Enter your email")
                                            
                                            CustomSecureFiled(text: $stakeSignInModel.password, placeholder: "Enter password")
                                            
                                            CustomSecureFiled(text: $stakeSignInModel.confirmPassword, placeholder: "Confirm password")
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                }
                                .padding(.top, 40)
                                
                                VStack(spacing: 25) {
                                    HStack(spacing: 15) {
                                        Button(action: {
                                            stakeSignInModel.isSkip = true
                                            UserDefaultsManager().enterAsGuest()
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color(red: 137/255, green: 141/255, blue: 148/255), lineWidth: 1)
                                                        .overlay {
                                                            Text("Skip")
                                                                .Pro(size: 20, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                                        }
                                                }
                                                .frame(height: 55)
                                                .cornerRadius(12)
                                        }
                                        
                                        Button(action: {
                                            stakeSignInModel.register { success in
                                                if success {
                                                    stakeSignInModel.isLog = true
                                                    print("YES")
                                                }
                                            }
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                .overlay {
                                                    Text("Get Started")
                                                        .ProBold(size: 20)
                                                }
                                                .frame(height: 55)
                                                .cornerRadius(12)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.top, 30)
                                    
                                    HStack(spacing: 5) {
                                        Text("Do you have an account?")
                                            .Pro(size: 14, color: Color(red: 80/255, green: 89/255, blue: 103/255))
                                        
                                        Button(action: {
                                            stakeSignInModel.isLog = true
                                        }) {
                                            Text("Log in")
                                                .ProBold(size: 14, color: Color(red: 17/255, green: 117/255, blue: 226/255))
                                        }
                                    }
                                }
                                .padding(.top, 10)
                            }
                            .padding(.horizontal, 10)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    }
                    .fullScreenCover(isPresented: $stakeSignInModel.isLog) {
                        StakeLoginView()
                    }
                    .fullScreenCover(isPresented: $stakeSignInModel.isSkip) {
                        StakeMainView()
                    }
                    .alert(isPresented: $stakeSignInModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(stakeSignInModel.alertMessage),
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
                                
                                Text("Hello!")
                                    .ProBold(size: 24)
                                
                                Spacer()
                            }
                            .padding(.top, 30)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("Create an account to get access to all features and possibilites of Habit Tracker")
                                        .Pro(size: 16)
                                    
                                    HStack {
                                        CustomTextField(text: $stakeSignInModel.name, placeholder: "Your name")
                                        
                                        CustomTextField(text: $stakeSignInModel.email, placeholder: "Enter your email")
                                        
                                        CustomSecureFiled(text: $stakeSignInModel.password, placeholder: "Enter password")
                                        
                                        CustomSecureFiled(text: $stakeSignInModel.confirmPassword, placeholder: "Confirm password")
                                    }
                                }
                                .padding(.horizontal, 10)
                            }
                            .padding(.top, 40)
                            
                            VStack(spacing: 25) {
                                HStack(spacing: 15) {
                                    Button(action: {
                                        stakeSignInModel.isSkip = true
                                        UserDefaultsManager().enterAsGuest()
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color(red: 137/255, green: 141/255, blue: 148/255), lineWidth: 1)
                                                    .overlay {
                                                        Text("Skip")
                                                            .Pro(size: 20, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                                    }
                                            }
                                            .frame(height: 55)
                                            .cornerRadius(12)
                                    }
                                    
                                    Button(action: {
                                        stakeSignInModel.register { success in
                                            if success {
                                                stakeSignInModel.isLog = true
                                                print("YES")
                                            }
                                        }
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                            .overlay {
                                                Text("Get Started")
                                                    .ProBold(size: 20)
                                            }
                                            .frame(height: 55)
                                            .cornerRadius(12)
                                    }
                                }
                                .padding(.horizontal, 10)
                                .padding(.top, 30)
                                
                                HStack(spacing: 5) {
                                    Text("Do you have an account?")
                                        .Pro(size: 14, color: Color(red: 80/255, green: 89/255, blue: 103/255))
                                    
                                    Button(action: {
                                        stakeSignInModel.isLog = true
                                    }) {
                                        Text("Log in")
                                            .ProBold(size: 14, color: Color(red: 17/255, green: 117/255, blue: 226/255))
                                    }
                                }
                            }
                            .padding(.top, 10)
                        }
                        .padding(.horizontal, 10)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                }
                .fullScreenCover(isPresented: $stakeSignInModel.isLog) {
                    StakeLoginView()
                }
                .fullScreenCover(isPresented: $stakeSignInModel.isSkip) {
                    StakeMainView()
                }
                .alert(isPresented: $stakeSignInModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(stakeSignInModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeSignInView()
}
