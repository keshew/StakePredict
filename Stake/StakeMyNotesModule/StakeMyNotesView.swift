import SwiftUI

struct StakeMyNotesView: View {
    @StateObject var stakeMyNotesModel =  StakeMyNotesViewModel()
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
                                        stakeMyNotesModel.isBack = true
                                    }) {
                                        Image(systemName: "chevron.left")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 24))
                                    }
                                    
                                    Spacer()
                                    
                                    Text("My notes")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)
                                
                                HStack {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 20) {
                                            if stakeMyNotesModel.notes.isEmpty {
                                                Text("Create your\nfirst note!")
                                                    .ProBold(size: 18, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 200, height: 250)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                    )
                                            } else {
                                                ForEach(stakeMyNotesModel.notes.indices, id: \.self) { idx in
                                                    let note = stakeMyNotesModel.notes[idx]
                                                    Rectangle()
                                                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                        .overlay {
                                                            HStack {
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    Text(note.title)
                                                                        .ProBold(size: 22)
                                                                        .minimumScaleFactor(0.7)
                                                                    
                                                                    Text(note.textOfNote)
                                                                        .Pro(size: 13, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                                        .minimumScaleFactor(0.7)
                                                                    
                                                                    Spacer()
                                                                }
                                                                .padding(.leading)
                                                                .padding(.top)
                                                                
                                                                Spacer()
                                                            }
                                                        }
                                                        .frame(width: 200, height: 250)
                                                        .cornerRadius(10)
                                                }
                                            }
                                        }

                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                        
                        if !UserDefaultsManager().isGuest() {
                            Button(action: {
                                stakeMyNotesModel.isAdd = true
                            }) {
                                Rectangle()
                                    .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                    .overlay {
                                        Image(systemName: "plus")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 30, weight: .semibold))
                                    }
                                    .frame(width: 70, height: 65)
                                    .cornerRadius(10)
                            }
                            .position(x: UIScreen.main.bounds.width / 1.1, y: UIScreen.main.bounds.height / 1.15)
                        }
                    }
                    .fullScreenCover(isPresented: $stakeMyNotesModel.isAdd) {
                        StakeCreateMyNoteView()
                    }
                    .fullScreenCover(isPresented: $stakeMyNotesModel.isBack) {
                        StakeMainView()
                    }
                    .onAppear {
                        if !UserDefaultsManager().isGuest() {
                            stakeMyNotesModel.fetchNotes()
                        }
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
                                    stakeMyNotesModel.isBack = true
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24))
                                }
                                
                                Spacer()
                                
                                Text("My notes")
                                    .ProBold(size: 24)
                                
                                Spacer()
                            }
                            .padding(.top, 30)
                            
                            HStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        if stakeMyNotesModel.notes.isEmpty {
                                            Text("Create your\nfirst note!")
                                                .ProBold(size: 18, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                .multilineTextAlignment(.center)
                                                .frame(width: 200, height: 250)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                )
                                        } else {
                                            ForEach(stakeMyNotesModel.notes.indices, id: \.self) { idx in
                                                let note = stakeMyNotesModel.notes[idx]
                                                Rectangle()
                                                    .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                    .overlay {
                                                        HStack {
                                                            VStack(alignment: .leading, spacing: 10) {
                                                                Text(note.title)
                                                                    .ProBold(size: 22)
                                                                    .minimumScaleFactor(0.7)
                                                                
                                                                Text(note.textOfNote)
                                                                    .Pro(size: 13, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                                    .minimumScaleFactor(0.7)
                                                                
                                                                Spacer()
                                                            }
                                                            .padding(.leading)
                                                            .padding(.top)
                                                            
                                                            Spacer()
                                                        }
                                                    }
                                                    .frame(width: 200, height: 250)
                                                    .cornerRadius(10)
                                            }
                                        }
                                    }

                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    
                    if !UserDefaultsManager().isGuest() {
                        Button(action: {
                            stakeMyNotesModel.isAdd = true
                        }) {
                            Rectangle()
                                .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                .overlay {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 30, weight: .semibold))
                                }
                                .frame(width: 70, height: 65)
                                .cornerRadius(10)
                        }
                        .position(x: UIScreen.main.bounds.width / 1.3, y: UIScreen.main.bounds.height / 1.25)
                    }
                }
                .fullScreenCover(isPresented: $stakeMyNotesModel.isAdd) {
                    StakeCreateMyNoteView()
                }
                .fullScreenCover(isPresented: $stakeMyNotesModel.isBack) {
                    StakeMainView()
                }
                .onAppear {
                    if !UserDefaultsManager().isGuest() {
                        stakeMyNotesModel.fetchNotes()
                    }
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeMyNotesView()
}

