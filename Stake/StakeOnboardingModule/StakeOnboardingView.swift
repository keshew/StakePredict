import SwiftUI

struct StakeOnboardingView: View {
    @StateObject var stakeOnboardingModel =  StakeOnboardingViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
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
                            HStack {
                                VStack {
                                    Text("Stake")
                                        .ProBold(size: 62)
                                    
                                    Image(.stake)
                                        .resizable()
                                        .frame(width: 380, height: 385)
                                }
                                
                                VStack(spacing: 30) {
                                    Text("Sign up to save your picks, notes,  and team analysis.")
                                        .Pro(size: 16, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                        .multilineTextAlignment(.center)
                                    
                                    VStack(spacing: 15) {
                                        Button(action: {
                                            stakeOnboardingModel.isStart = true
                                            UserDefaultsManager().enterAsGuest()
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
                                        
                                        Button(action: {
                                            stakeOnboardingModel.isLogin = true
                                        }) {
                                            Rectangle()
                                                .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color(red: 137/255, green: 141/255, blue: 148/255), lineWidth: 1)
                                                        .overlay {
                                                            Text("Create account")
                                                                .Pro(size: 20, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                                        }
                                                }
                                                .frame(height: 55)
                                                .cornerRadius(12)
                                        }
                                    }
                                }
                                .padding(.horizontal, 90)
                                .padding(.top, 80)
                            }
                            .padding(.horizontal, 60)
                            .padding(.top, UIScreen.main.bounds.height > 900 ? 170 : 110)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    }
                    .fullScreenCover(isPresented: $stakeOnboardingModel.isLogin) {
                        StakeSignInView()
                    }
                    
                    .fullScreenCover(isPresented: $stakeOnboardingModel.isStart) {
                        StakeMainView()
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
                        HStack {
                            VStack {
                                Text("Stake")
                                    .ProBold(size: 32)
                                
                                Image(.stake)
                                    .resizable()
                                    .frame(width: 180, height: 185)
                            }
                            
                            VStack(spacing: 30) {
                                Text("Sign up to save your picks, notes,  and team analysis.")
                                    .Pro(size: 16, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                    .multilineTextAlignment(.center)
                                
                                VStack(spacing: 15) {
                                    Button(action: {
                                        stakeOnboardingModel.isStart = true
                                        UserDefaultsManager().enterAsGuest()
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
                                    
                                    Button(action: {
                                        stakeOnboardingModel.isLogin = true
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color(red: 137/255, green: 141/255, blue: 148/255), lineWidth: 1)
                                                    .overlay {
                                                        Text("Create account")
                                                            .Pro(size: 20, color: Color(red: 197/255, green: 198/255, blue: 205/255))
                                                    }
                                            }
                                            .frame(height: 55)
                                            .cornerRadius(12)
                                    }
                                }
                            }
                            .padding(.horizontal, 90)
                            .padding(.top, 30)
                        }
                        .padding(.horizontal)
                        .padding(.top, 70)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                }
                .fullScreenCover(isPresented: $stakeOnboardingModel.isLogin) {
                    StakeSignInView()
                }
                
                .fullScreenCover(isPresented: $stakeOnboardingModel.isStart) {
                    StakeMainView()
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeOnboardingView()
}
