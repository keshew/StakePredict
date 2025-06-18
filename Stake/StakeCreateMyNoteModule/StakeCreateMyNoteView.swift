import SwiftUI

struct StakeCreateMyNoteView: View {
    @StateObject var stakeCreateMyNoteModel =  StakeCreateMyNoteViewModel()
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
                                    
                                    Text("New note")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)

                                Rectangle()
                                    .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                    .overlay {
                                        VStack(spacing: 3) {
                                            CustomClearTextField(text: $stakeCreateMyNoteModel.name, placeholder: "Note title")
                                            
                                            Rectangle()
                                                .fill(Color(red: 57/255, green: 63/255, blue: 76/255))
                                                .frame(height: 1)
                                                .padding(.horizontal)
                                            
                                            CustomTextView(text: $stakeCreateMyNoteModel.desc, placeholder: "Start typing the text of the new note...")
                                        }
                                    }
                                    .frame(height: 235)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 70)
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
                                stakeCreateMyNoteModel.saveNote { success in
                                     if success {
                                         stakeCreateMyNoteModel.isBack = true
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
                    .fullScreenCover(isPresented: $stakeCreateMyNoteModel.isBack, content: {
                        StakeMyNotesView()
                    })
                    .alert(isPresented: $stakeCreateMyNoteModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(stakeCreateMyNoteModel.alertMessage),
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
                                
                                Text("New note")
                                    .ProBold(size: 24)
                                
                                Spacer()
                            }
                            .padding(.top, 30)

                            Rectangle()
                                .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                .overlay {
                                    VStack(spacing: 3) {
                                        CustomClearTextField(text: $stakeCreateMyNoteModel.name, placeholder: "Note title")
                                        
                                        Rectangle()
                                            .fill(Color(red: 57/255, green: 63/255, blue: 76/255))
                                            .frame(height: 1)
                                            .padding(.horizontal)
                                        
                                        CustomTextView(text: $stakeCreateMyNoteModel.desc, placeholder: "Start typing the text of the new note...")
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
                            stakeCreateMyNoteModel.saveNote { success in
                                 if success {
                                     stakeCreateMyNoteModel.isBack = true
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
                .fullScreenCover(isPresented: $stakeCreateMyNoteModel.isBack, content: {
                    StakeMyNotesView()
                })
                .alert(isPresented: $stakeCreateMyNoteModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(stakeCreateMyNoteModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeCreateMyNoteView()
}

