import SwiftUI

struct StakeLoginView: View {
    @StateObject var stakeLoginModel =  StakeLoginViewModel()
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
                                        stakeLoginModel.isBack = true
                                    }) {
                                        Image(systemName: "chevron.left")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 24))
                                    }
                                    
                                    Spacer()
                                    
                                    Text("Welcome back")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)
                                
                                HStack {
                                    Image(.login)
                                        .resizable()
                                        .frame(width: 110, height: 100)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Sign in to continue organizing your habits in easiest way")
                                            .Pro(size: 16)
                                        
                                        HStack {
                                            CustomTextField(text: $stakeLoginModel.email, placeholder: "Enter your email")
                                            
                                            CustomSecureFiled(text: $stakeLoginModel.password, placeholder: "Enter password")
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                }
                                .padding(.top, 50)
                                
                                HStack(spacing: 15) {
                                    Button(action: {
                                        stakeLoginModel.isSkip = true
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
                                        stakeLoginModel.login { success in
                                            if success {
                                                stakeLoginModel.isSkip = true
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
                            }
                            .padding(.horizontal, 10)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    }
                    .fullScreenCover(isPresented: $stakeLoginModel.isSkip) {
                        StakeMainView()
                    }
                    .fullScreenCover(isPresented: $stakeLoginModel.isBack) {
                        StakeOnboardingView()
                    }
                    .alert(isPresented: $stakeLoginModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(stakeLoginModel.alertMessage),
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
                                    stakeLoginModel.isBack = true
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24))
                                }
                                
                                Spacer()
                                
                                Text("Welcome back")
                                    .ProBold(size: 24)
                                
                                Spacer()
                            }
                            .padding(.top, 30)
                            
                            HStack {
                                Image(.login)
                                    .resizable()
                                    .frame(width: 110, height: 100)
                                
                                VStack(alignment: .leading) {
                                    Text("Sign in to continue organizing your habits in easiest way")
                                        .Pro(size: 16)
                                    
                                    HStack {
                                        CustomTextField(text: $stakeLoginModel.email, placeholder: "Enter your email")
                                        
                                        CustomSecureFiled(text: $stakeLoginModel.password, placeholder: "Enter password")
                                    }
                                }
                                .padding(.horizontal, 10)
                            }
                            .padding(.top, 50)
                            
                            HStack(spacing: 15) {
                                Button(action: {
                                    stakeLoginModel.isSkip = true
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
                                    stakeLoginModel.login { success in
                                        if success {
                                            stakeLoginModel.isSkip = true
                                            print("YES")
                                        }
                                    }
                                }) {
                                    Rectangle()
                                        .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                        .overlay {
                                            Text("Log in")
                                                .ProBold(size: 20)
                                        }
                                        .frame(height: 55)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.top, 30)
                        }
                        .padding(.horizontal, 10)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                }
                .fullScreenCover(isPresented: $stakeLoginModel.isSkip) {
                    StakeMainView()
                }
                .fullScreenCover(isPresented: $stakeLoginModel.isBack) {
                    StakeOnboardingView()
                }
                .alert(isPresented: $stakeLoginModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(stakeLoginModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeLoginView()
}
