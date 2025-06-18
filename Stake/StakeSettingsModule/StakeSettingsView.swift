import SwiftUI

struct StakeSettingsView: View {
    @StateObject var stakeSettingsModel =  StakeSettingsViewModel()
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
                                    
                                    Text("Settings")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)

                                HStack {
                                    Group {
                                        if UserDefaultsManager().isGuest() {
                                            Rectangle()
                                                .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                                .overlay {
                                                    VStack(spacing: 15) {
                                                        VStack {
                                                            HStack {
                                                                VStack(alignment: .leading, spacing: 8) {
                                                                    Text("Notification")
                                                                        .Pro(size: 16)
                                                                    
                                                                    Text("Push notification")
                                                                        .Pro(size: 14, color: Color(red: 199/255, green: 205/255, blue: 209/255))
                                                                }
                                                                
                                                                Spacer()
                                                                
                                                                Toggle("", isOn: $stakeSettingsModel.isEmail)
                                                                    .toggleStyle(CustomToggleStyle())
                                                            }
                                                        }
                                                    }
                                                    .padding(.horizontal)
                                                }
                                                .frame(height: 90)
                                                .cornerRadius(10)
                                        } else {
                                            Rectangle()
                                                .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                                .overlay {
                                                    VStack(spacing: 15) {
                                                        VStack {
                                                            HStack {
                                                                VStack(alignment: .leading, spacing: 8) {
                                                                    Text(UserDefaultsManager().getName() ?? "Name")
                                                                        .Pro(size: 16)
                                                                    
                                                                    Text(UserDefaultsManager().getEmail() ?? "Email")
                                                                        .Pro(size: 14, color: Color(red: 199/255, green: 205/255, blue: 209/255))
                                                                }
                                                                
                                                                Spacer()
                                                                
                                                                Image(.edit)
                                                                    .resizable()
                                                                    .frame(width: 40, height: 40)
                                                                    .onTapGesture {
                                                                        stakeSettingsModel.isEdit = true
                                                                    }
                                                            }
                                                            
                                                            Rectangle()
                                                                .fill(Color(red: 82/255, green: 99/255, blue: 109/255))
                                                                .frame(height: 1)
                                                        }
                                                        
                                                        VStack {
                                                            HStack {
                                                                VStack(alignment: .leading, spacing: 8) {
                                                                    Text("Notification")
                                                                        .Pro(size: 16)
                                                                    
                                                                    Text("Push notification")
                                                                        .Pro(size: 14, color: Color(red: 199/255, green: 205/255, blue: 209/255))
                                                                }
                                                                
                                                                Spacer()
                                                                
                                                                Toggle("", isOn: $stakeSettingsModel.isNotif)
                                                                    .toggleStyle(CustomToggleStyle())
                                                            }
                                                            
                                                            Rectangle()
                                                                .fill(Color(red: 82/255, green: 99/255, blue: 109/255))
                                                                .frame(height: 1)
                                                        }
                                                        
                                                        VStack {
                                                            HStack {
                                                                VStack(alignment: .leading, spacing: 8) {
                                                                    Text("Email")
                                                                        .Pro(size: 16)
                                                                    
                                                                    Text("I want to receive news and offers")
                                                                        .Pro(size: 14, color: Color(red: 199/255, green: 205/255, blue: 209/255))
                                                                }
                                                                
                                                                Spacer()
                                                                
                                                                Toggle("", isOn: $stakeSettingsModel.isEmail)
                                                                    .toggleStyle(CustomToggleStyle())
                                                            }
                                                        }
                                                    }
                                                    .padding(.horizontal)
                                                }
                                                .frame(height: 235)
                                                .cornerRadius(10)
                                        }
                                    }
                                    VStack(spacing: 15) {
                                        Button(action: {
                                            if UserDefaultsManager().isGuest() {
                                                stakeSettingsModel.isSign = true
                                            } else {
                                                stakeSettingsModel.quit()
                                            }
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                .overlay {
                                                    Text(UserDefaultsManager().isGuest() ? "Create account" : "Log out")
                                                        .ProBold(size: 18)
                                                }
                                                .frame(width: 290, height: 45)
                                                .cornerRadius(8)
                                        }
                                        
                                        Button(action: {
                                            if UserDefaultsManager().isGuest() {
                                                stakeSettingsModel.isLog = true
                                            } else {
                                                stakeSettingsModel.showDeleteAlert = true
                                            }
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color(red: 137/255, green: 141/255, blue: 148/255), lineWidth: 1)
                                                        .overlay {
                                                            Text(UserDefaultsManager().isGuest() ? "Login" : "Delete account")
                                                                .Pro(size: 18, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                                        }
                                                }
                                                .frame(width: 290, height: 45)
                                                .cornerRadius(8)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.top, UserDefaultsManager().isGuest() ? 60 : 0)
                            }
                            .padding(.horizontal, 10)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    }
                    .fullScreenCover(isPresented: $stakeSettingsModel.isEdit) {
                        StakeEditView()
                    }
                    .fullScreenCover(isPresented: $stakeSettingsModel.isLog) {
                        StakeLoginView()
                    }
                    .fullScreenCover(isPresented: $stakeSettingsModel.isSign) {
                        StakeSignInView()
                    }
                    .fullScreenCover(isPresented: $stakeSettingsModel.isOnb) {
                        StakeOnboardingView()
                    }
                    .alert(isPresented: $stakeSettingsModel.showDeleteAlert) {
                        Alert(
                            title: Text("Delete account"),
                            message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                            primaryButton: .destructive(Text("Delete")) {
                                stakeSettingsModel.logOut { success in
                                    if success {
                                        stakeSettingsModel.quit()
                                    }
                                }
                            },
                            secondaryButton: .cancel()
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
                                
                                Text("Settings")
                                    .ProBold(size: 24)
                                
                                Spacer()
                            }
                            .padding(.top, 30)

                            HStack {
                                Group {
                                    if UserDefaultsManager().isGuest() {
                                        Rectangle()
                                            .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                            .overlay {
                                                VStack(spacing: 15) {
                                                    VStack {
                                                        HStack {
                                                            VStack(alignment: .leading, spacing: 8) {
                                                                Text("Notification")
                                                                    .Pro(size: 16)
                                                                
                                                                Text("Push notification")
                                                                    .Pro(size: 14, color: Color(red: 199/255, green: 205/255, blue: 209/255))
                                                            }
                                                            
                                                            Spacer()
                                                            
                                                            Toggle("", isOn: $stakeSettingsModel.isEmail)
                                                                .toggleStyle(CustomToggleStyle())
                                                        }
                                                    }
                                                }
                                                .padding(.horizontal)
                                            }
                                            .frame(height: 90)
                                            .cornerRadius(10)
                                    } else {
                                        Rectangle()
                                            .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                            .overlay {
                                                VStack(spacing: 15) {
                                                    VStack {
                                                        HStack {
                                                            VStack(alignment: .leading, spacing: 8) {
                                                                Text(UserDefaultsManager().getName() ?? "Name")
                                                                    .Pro(size: 16)
                                                                
                                                                Text(UserDefaultsManager().getEmail() ?? "Email")
                                                                    .Pro(size: 14, color: Color(red: 199/255, green: 205/255, blue: 209/255))
                                                            }
                                                            
                                                            Spacer()
                                                            
                                                            Image(.edit)
                                                                .resizable()
                                                                .frame(width: 40, height: 40)
                                                                .onTapGesture {
                                                                    stakeSettingsModel.isEdit = true
                                                                }
                                                        }
                                                        
                                                        Rectangle()
                                                            .fill(Color(red: 82/255, green: 99/255, blue: 109/255))
                                                            .frame(height: 1)
                                                    }
                                                    
                                                    VStack {
                                                        HStack {
                                                            VStack(alignment: .leading, spacing: 8) {
                                                                Text("Notification")
                                                                    .Pro(size: 16)
                                                                
                                                                Text("Push notification")
                                                                    .Pro(size: 14, color: Color(red: 199/255, green: 205/255, blue: 209/255))
                                                            }
                                                            
                                                            Spacer()
                                                            
                                                            Toggle("", isOn: $stakeSettingsModel.isNotif)
                                                                .toggleStyle(CustomToggleStyle())
                                                        }
                                                        
                                                        Rectangle()
                                                            .fill(Color(red: 82/255, green: 99/255, blue: 109/255))
                                                            .frame(height: 1)
                                                    }
                                                    
                                                    VStack {
                                                        HStack {
                                                            VStack(alignment: .leading, spacing: 8) {
                                                                Text("Email")
                                                                    .Pro(size: 16)
                                                                
                                                                Text("I want to receive news and offers")
                                                                    .Pro(size: 14, color: Color(red: 199/255, green: 205/255, blue: 209/255))
                                                            }
                                                            
                                                            Spacer()
                                                            
                                                            Toggle("", isOn: $stakeSettingsModel.isEmail)
                                                                .toggleStyle(CustomToggleStyle())
                                                        }
                                                    }
                                                }
                                                .padding(.horizontal)
                                            }
                                            .frame(height: 235)
                                            .cornerRadius(10)
                                    }
                                }
                                VStack(spacing: 15) {
                                    Button(action: {
                                        if UserDefaultsManager().isGuest() {
                                            stakeSettingsModel.isSign = true
                                        } else {
                                            stakeSettingsModel.quit()
                                        }
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                            .overlay {
                                                Text(UserDefaultsManager().isGuest() ? "Create account" : "Log out")
                                                    .ProBold(size: 18)
                                            }
                                            .frame(width: 290, height: 45)
                                            .cornerRadius(8)
                                    }
                                    
                                    Button(action: {
                                        if UserDefaultsManager().isGuest() {
                                            stakeSettingsModel.isLog = true
                                        } else {
                                            stakeSettingsModel.showDeleteAlert = true
                                        }
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color(red: 137/255, green: 141/255, blue: 148/255), lineWidth: 1)
                                                    .overlay {
                                                        Text(UserDefaultsManager().isGuest() ? "Login" : "Delete account")
                                                            .Pro(size: 18, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                                    }
                                            }
                                            .frame(width: 290, height: 45)
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .padding(.top, UserDefaultsManager().isGuest() ? 60 : 0)
                        }
                        .padding(.horizontal, 10)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                }
                .fullScreenCover(isPresented: $stakeSettingsModel.isEdit) {
                    StakeEditView()
                }
                .fullScreenCover(isPresented: $stakeSettingsModel.isLog) {
                    StakeLoginView()
                }
                .fullScreenCover(isPresented: $stakeSettingsModel.isSign) {
                    StakeSignInView()
                }
                .fullScreenCover(isPresented: $stakeSettingsModel.isOnb) {
                    StakeOnboardingView()
                }
                .alert(isPresented: $stakeSettingsModel.showDeleteAlert) {
                    Alert(
                        title: Text("Delete account"),
                        message: Text("Are you sure you want to delete your account? This action cannot be undone."),
                        primaryButton: .destructive(Text("Delete")) {
                            stakeSettingsModel.logOut { success in
                                if success {
                                    stakeSettingsModel.quit()
                                }
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeSettingsView()
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                .frame(width: 45, height: 23)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? Color(red: 17/255, green: 117/255, blue: 226/255) : Color(red: 137/255, green: 141/255, blue: 148/255))
                        .frame(width: 18, height: 18)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
}
