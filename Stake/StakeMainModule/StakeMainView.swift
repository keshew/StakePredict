import SwiftUI

struct StakeMainView: View {
    @StateObject var stakeMainModel =  StakeMainViewModel()
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
                            VStack(spacing: 30) {
                                HStack {
                                    Text("Sport Notebook")
                                        .ProBold(size: 36)
                                        .padding(.leading)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        stakeMainModel.isSettings = true
                                    }) {
                                        Image(systemName: "gearshape.fill")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 24))
                                    }
                                }
                                .padding(.top, 30)
                                
                                HStack {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                            .overlay {
                                                VStack {
                                                    Color.clear.frame(height: 50)
                                                    if stakeMainModel.isLoadingMyNote {
                                                        ProgressView()
                                                            .scaleEffect(1.5)
                                                            .padding()
                                                    } else if let note = stakeMainModel.lastMyNote {
                                                        Rectangle()
                                                            .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                            .overlay {
                                                                HStack(alignment: .top) {
                                                                    VStack(alignment: .leading, spacing: 10) {
                                                                        Text(note.title)
                                                                            .ProBold(size: 19)
                                                                            .minimumScaleFactor(0.8)
                                                                        
                                                                        Text(note.textOfNote)
                                                                            .Pro(size: 11, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                                            .minimumScaleFactor(0.8)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    .padding(.horizontal, 10)
                                                                    .padding(.vertical, 15)
                                                                    
                                                                    Spacer()
                                                                }
                                                            }
                                                            .cornerRadius(7)
                                                            .padding()
                                                    } else {
                                                        Rectangle()
                                                            .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                            .overlay {
                                                                HStack(alignment: .top) {
                                                                    VStack(alignment: .leading, spacing: 10) {
                                                                        Text("Create your\nfirst note!")
                                                                            .ProBold(size: 19)
                                                                            .multilineTextAlignment(.center)
                                                                            .minimumScaleFactor(0.8)
                                                                    }
                                                                    .padding(.horizontal, 10)
                                                                    .padding(.vertical, 15)
                                                                }
                                                            }
                                                            .cornerRadius(7)
                                                            .padding()
                                                    }
                                                }
                                            }
                                            .frame(height: 200)
                                            .cornerRadius(20)
                                        
                                        HStack {
                                            Text("My notes")
                                                .ProBold(size: 17)
                                            
                                            Spacer()
                                            
                                            Image(.notes)
                                                .resizable()
                                                .frame(width: 70, height: 70)
                                                .offset(x: 10, y: -20)
                                        }
                                        .padding(.horizontal)
                                        .offset(y: -70)
                                    }
                                    .onTapGesture {
                                        if UserDefaultsManager().isGuest() {
                                            stakeMainModel.isGuestTapped = true
                                        } else {
                                            stakeMainModel.isMyNotes = true
                                        }
                                    }
                                    
                                    ZStack {
                                        Rectangle()
                                            .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                            .overlay {
                                                VStack {
                                                    Color.clear.frame(height: 50)
                                                    if stakeMainModel.isLoadingPrediction {
                                                        ProgressView()
                                                            .scaleEffect(1.5)
                                                            .padding()
                                                    } else if let prediction = stakeMainModel.lastPrediction {
                                                        Rectangle()
                                                            .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                            .overlay {
                                                                HStack {
                                                                    VStack(spacing: 10) {
                                                                        Rectangle()
                                                                            .fill(prediction.isPredicted
                                                                                  ? (prediction.isPredictionRight
                                                                                     ? Color(red: 17/255, green: 117/255, blue: 226/255)
                                                                                     : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                                  : .clear)
                                                                            .overlay {
                                                                                RoundedRectangle(cornerRadius: 6)
                                                                                    .stroke(
                                                                                        prediction.isPredicted
                                                                                        ? (prediction.isPredictionRight
                                                                                           ? Color(red: 17/255, green: 117/255, blue: 226/255)
                                                                                           : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                                        : .white,
                                                                                        lineWidth: 1
                                                                                    )
                                                                                    .overlay {
                                                                                        Text(
                                                                                            prediction.isPredicted
                                                                                            ? (prediction.isPredictionRight ? "Correct prediction" : "Wrong prediction")
                                                                                            : "Expect an event"
                                                                                        )
                                                                                        .Pro(size: 13)
                                                                                        .minimumScaleFactor(0.8)
                                                                                    }
                                                                            }
                                                                            .frame(height: 20)
                                                                            .cornerRadius(6)
                                                                            .padding(.horizontal, 25)
                                                                        
                                                                        VStack(spacing: 5) {
                                                                            Text("\(prediction.firstTeamName) VS \(prediction.secondTeamName)")
                                                                                .ProBold(size: 15)
                                                                                .minimumScaleFactor(0.8)
                                                                            Text(prediction.textOfPrediction)
                                                                                .Pro(size: 11, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                                                .minimumScaleFactor(0.8)
                                                                        }
                                                                    }
                                                                    .padding(.horizontal, 10)
                                                                    .padding(.vertical, 5)
                                                                    Spacer()
                                                                }
                                                            }
                                                            .cornerRadius(7)
                                                            .padding()
                                                    } else {
                                                        Rectangle()
                                                            .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                            .overlay {
                                                                HStack {
                                                                    VStack(spacing: 10) {
                                                                        VStack(spacing: 5) {
                                                                            Text("Create your\nfirst prediction!")
                                                                                .ProBold(size: 15)
                                                                                .multilineTextAlignment(.center)
                                                                                .minimumScaleFactor(0.8)
                                                                        }
                                                                    }
                                                                    .padding(.horizontal, 10)
                                                                    .padding(.vertical, 5)
                                                                    
                                                                }
                                                            }
                                                            .cornerRadius(7)
                                                            .padding()
                                                    }
                                                }
                                            }
                                            .frame(height: 200)
                                            .cornerRadius(20)
                                        
                                        HStack {
                                            Text("My predictions")
                                                .ProBold(size: 17)
                                            
                                            Spacer()
                                            
                                            Image(.prediction)
                                                .resizable()
                                                .frame(width: 70, height: 70)
                                                .offset(x: 10, y: -20)
                                        }
                                        .padding(.horizontal)
                                        .offset(y: -70)
                                    }
                                    .onTapGesture {
                                        if UserDefaultsManager().isGuest() {
                                            stakeMainModel.isGuestTapped = true
                                        } else {
                                            stakeMainModel.isMyPredictions = true
                                        }
                                    }
                                    
                                    ZStack {
                                        Rectangle()
                                            .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                            .overlay {
                                                VStack {
                                                    Color.clear.frame(height: 50)
                                                    if stakeMainModel.isLoadingTeamNote {
                                                        ProgressView()
                                                            .scaleEffect(1.5)
                                                            .padding()
                                                    } else if let teamNote = stakeMainModel.lastTeamNote {
                                                        HStack {
                                                            VStack(spacing: 10) {
                                                                VStack(alignment: .leading, spacing: 15) {
                                                                    if let imageBase64 = teamNote.image,
                                                                       !imageBase64.isEmpty,
                                                                       let imgData = Data(base64Encoded: imageBase64),
                                                                       let uiImg = UIImage(data: imgData) {
                                                                        Image(uiImage: uiImg)
                                                                            .resizable()
                                                                            .frame(width: 50, height: 50)
                                                                            .clipShape(Circle())
                                                                    } else {
                                                                        ZStack {
                                                                            Circle()
                                                                                .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                                                .frame(width: 50, height: 50)
                                                                            Text(String((teamNote.username ?? teamNote.title).prefix(1)).uppercased())
                                                                                .foregroundColor(.white)
                                                                                .font(.system(size: 24, weight: .bold))
                                                                        }
                                                                    }
                                                                    
                                                                    Text(teamNote.textOfNote)
                                                                        .Pro(size: 14)
                                                                        .minimumScaleFactor(0.8)
                                                                }
                                                            }
                                                            .padding(.horizontal, 15)
                                                            .padding(.vertical, 5)
                                                            
                                                            Spacer()
                                                        }
                                                    } else {
                                                        HStack {
                                                            VStack(spacing: 10) {
                                                                VStack(alignment: .leading, spacing: 15) {
                                                                    
                                                                    Text("Create your\nfirst team note!")
                                                                        .ProBold(size: 15)
                                                                        .multilineTextAlignment(.center)
                                                                        .minimumScaleFactor(0.8)
                                                                }
                                                            }
                                                            .padding(.horizontal, 15)
                                                            .padding(.vertical, 5)
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            .frame(height: 200)
                                            .cornerRadius(20)
                                        
                                        HStack {
                                            Text("Notes on the teams")
                                                .ProBold(size: 17)
                                            
                                            Spacer()
                                            
                                            Image(.notesOnTeam)
                                                .resizable()
                                                .frame(width: 70, height: 70)
                                                .offset(x: 10, y: -20)
                                        }
                                        .padding(.horizontal)
                                        .offset(y: -70)
                                    }
                                    .onTapGesture {
                                        if UserDefaultsManager().isGuest() {
                                            stakeMainModel.isGuestTapped = true
                                        } else {
                                            stakeMainModel.isTeamNotes = true
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 30)
                            }
                            .padding(.horizontal, 10)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    }
                    .fullScreenCover(isPresented: $stakeMainModel.isSettings) {
                        StakeSettingsView()
                    }
                    .fullScreenCover(isPresented: $stakeMainModel.isMyNotes) {
                        StakeMyNotesView()
                    }
                    .fullScreenCover(isPresented: $stakeMainModel.isMyPredictions) {
                        StakePredictionsView()
                    }
                    .fullScreenCover(isPresented: $stakeMainModel.isTeamNotes) {
                        StakeTeamNotesView()
                    }
                    .fullScreenCover(isPresented: $stakeMainModel.isGuestTapped) {
                        StakeSignInView()
                    }
                    .onAppear {
                        if !UserDefaultsManager().isGuest() {
                            stakeMainModel.fetchAllLast()
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
                                Text("Sport Notebook")
                                    .ProBold(size: 36)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Button(action: {
                                    stakeMainModel.isSettings = true
                                }) {
                                    Image(systemName: "gearshape.fill")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24))
                                }
                            }
                            .padding(.top, 30)
                            
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                        .overlay {
                                            VStack {
                                                Color.clear.frame(height: 50)
                                                if stakeMainModel.isLoadingMyNote {
                                                    ProgressView()
                                                        .scaleEffect(1.5)
                                                        .padding()
                                                } else if let note = stakeMainModel.lastMyNote {
                                                    Rectangle()
                                                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                        .overlay {
                                                            HStack(alignment: .top) {
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    Text(note.title)
                                                                        .ProBold(size: 19)
                                                                        .minimumScaleFactor(0.8)
                                                                    
                                                                    Text(note.textOfNote)
                                                                        .Pro(size: 11, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                                        .minimumScaleFactor(0.8)
                                                                    
                                                                    Spacer()
                                                                }
                                                                .padding(.horizontal, 10)
                                                                .padding(.vertical, 15)
                                                                
                                                                Spacer()
                                                            }
                                                        }
                                                        .cornerRadius(7)
                                                        .padding()
                                                } else {
                                                    Rectangle()
                                                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                        .overlay {
                                                            HStack(alignment: .top) {
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    Text("Create your\nfirst note!")
                                                                        .ProBold(size: 19)
                                                                        .multilineTextAlignment(.center)
                                                                        .minimumScaleFactor(0.8)
                                                                }
                                                                .padding(.horizontal, 10)
                                                                .padding(.vertical, 15)
                                                            }
                                                        }
                                                        .cornerRadius(7)
                                                        .padding()
                                                }
                                            }
                                        }
                                        .frame(height: 200)
                                        .cornerRadius(20)
                                    
                                    HStack {
                                        Text("My notes")
                                            .ProBold(size: 17)
                                        
                                        Spacer()
                                        
                                        Image(.notes)
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                            .offset(x: 10, y: -20)
                                    }
                                    .padding(.horizontal)
                                    .offset(y: -70)
                                }
                                .onTapGesture {
                                    if UserDefaultsManager().isGuest() {
                                        stakeMainModel.isGuestTapped = true
                                    } else {
                                        stakeMainModel.isMyNotes = true
                                    }
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                        .overlay {
                                            VStack {
                                                Color.clear.frame(height: 50)
                                                if stakeMainModel.isLoadingPrediction {
                                                    ProgressView()
                                                        .scaleEffect(1.5)
                                                        .padding()
                                                } else if let prediction = stakeMainModel.lastPrediction {
                                                    Rectangle()
                                                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                        .overlay {
                                                            HStack {
                                                                VStack(spacing: 10) {
                                                                    Rectangle()
                                                                        .fill(prediction.isPredicted
                                                                              ? (prediction.isPredictionRight
                                                                                 ? Color(red: 17/255, green: 117/255, blue: 226/255)
                                                                                 : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                              : .clear)
                                                                        .overlay {
                                                                            RoundedRectangle(cornerRadius: 6)
                                                                                .stroke(
                                                                                    prediction.isPredicted
                                                                                    ? (prediction.isPredictionRight
                                                                                       ? Color(red: 17/255, green: 117/255, blue: 226/255)
                                                                                       : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                                    : .white,
                                                                                    lineWidth: 1
                                                                                )
                                                                                .overlay {
                                                                                    Text(
                                                                                        prediction.isPredicted
                                                                                        ? (prediction.isPredictionRight ? "Correct prediction" : "Wrong prediction")
                                                                                        : "Expect an event"
                                                                                    )
                                                                                    .Pro(size: 13)
                                                                                    .minimumScaleFactor(0.8)
                                                                                }
                                                                        }
                                                                        .frame(height: 20)
                                                                        .cornerRadius(6)
                                                                        .padding(.horizontal, 25)
                                                                    
                                                                    VStack(spacing: 5) {
                                                                        Text("\(prediction.firstTeamName) VS \(prediction.secondTeamName)")
                                                                            .ProBold(size: 15)
                                                                            .minimumScaleFactor(0.8)
                                                                        Text(prediction.textOfPrediction)
                                                                            .Pro(size: 11, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                                            .minimumScaleFactor(0.8)
                                                                    }
                                                                }
                                                                .padding(.horizontal, 10)
                                                                .padding(.vertical, 5)
                                                                Spacer()
                                                            }
                                                        }
                                                        .cornerRadius(7)
                                                        .padding()
                                                } else {
                                                    Rectangle()
                                                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                                        .overlay {
                                                            HStack {
                                                                VStack(spacing: 10) {
                                                                    VStack(spacing: 5) {
                                                                        Text("Create your\nfirst prediction!")
                                                                            .ProBold(size: 15)
                                                                            .multilineTextAlignment(.center)
                                                                            .minimumScaleFactor(0.8)
                                                                    }
                                                                }
                                                                .padding(.horizontal, 10)
                                                                .padding(.vertical, 5)
                                                                
                                                            }
                                                        }
                                                        .cornerRadius(7)
                                                        .padding()
                                                }
                                            }
                                        }
                                        .frame(height: 200)
                                        .cornerRadius(20)
                                    
                                    HStack {
                                        Text("My predictions")
                                            .ProBold(size: 17)
                                        
                                        Spacer()
                                        
                                        Image(.prediction)
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                            .offset(x: 10, y: -20)
                                    }
                                    .padding(.horizontal)
                                    .offset(y: -70)
                                }
                                .onTapGesture {
                                    if UserDefaultsManager().isGuest() {
                                        stakeMainModel.isGuestTapped = true
                                    } else {
                                        stakeMainModel.isMyPredictions = true
                                    }
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                        .overlay {
                                            VStack {
                                                Color.clear.frame(height: 50)
                                                if stakeMainModel.isLoadingTeamNote {
                                                    ProgressView()
                                                        .scaleEffect(1.5)
                                                        .padding()
                                                } else if let teamNote = stakeMainModel.lastTeamNote {
                                                    HStack {
                                                        VStack(spacing: 10) {
                                                            VStack(alignment: .leading, spacing: 15) {
                                                                if let imageBase64 = teamNote.image,
                                                                   !imageBase64.isEmpty,
                                                                   let imgData = Data(base64Encoded: imageBase64),
                                                                   let uiImg = UIImage(data: imgData) {
                                                                    Image(uiImage: uiImg)
                                                                        .resizable()
                                                                        .frame(width: 50, height: 50)
                                                                        .clipShape(Circle())
                                                                } else {
                                                                    ZStack {
                                                                        Circle()
                                                                            .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                                            .frame(width: 50, height: 50)
                                                                        Text(String((teamNote.username ?? teamNote.title).prefix(1)).uppercased())
                                                                            .foregroundColor(.white)
                                                                            .font(.system(size: 24, weight: .bold))
                                                                    }
                                                                }
                                                                
                                                                Text(teamNote.textOfNote)
                                                                    .Pro(size: 14)
                                                                    .minimumScaleFactor(0.8)
                                                            }
                                                        }
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        
                                                        Spacer()
                                                    }
                                                } else {
                                                    HStack {
                                                        VStack(spacing: 10) {
                                                            VStack(alignment: .leading, spacing: 15) {
                                                                
                                                                Text("Create your\nfirst team note!")
                                                                    .ProBold(size: 15)
                                                                    .multilineTextAlignment(.center)
                                                                    .minimumScaleFactor(0.8)
                                                            }
                                                        }
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        .frame(height: 200)
                                        .cornerRadius(20)
                                    
                                    HStack {
                                        Text("Notes on the teams")
                                            .ProBold(size: 17)
                                        
                                        Spacer()
                                        
                                        Image(.notesOnTeam)
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                            .offset(x: 10, y: -20)
                                    }
                                    .padding(.horizontal)
                                    .offset(y: -70)
                                }
                                .onTapGesture {
                                    if UserDefaultsManager().isGuest() {
                                        stakeMainModel.isGuestTapped = true
                                    } else {
                                        stakeMainModel.isTeamNotes = true
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 30)
                        }
                        .padding(.horizontal, 10)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                }
                .fullScreenCover(isPresented: $stakeMainModel.isSettings) {
                    StakeSettingsView()
                }
                .fullScreenCover(isPresented: $stakeMainModel.isMyNotes) {
                    StakeMyNotesView()
                }
                .fullScreenCover(isPresented: $stakeMainModel.isMyPredictions) {
                    StakePredictionsView()
                }
                .fullScreenCover(isPresented: $stakeMainModel.isTeamNotes) {
                    StakeTeamNotesView()
                }
                .fullScreenCover(isPresented: $stakeMainModel.isGuestTapped) {
                    StakeSignInView()
                }
                .onAppear {
                    if !UserDefaultsManager().isGuest() {
                        stakeMainModel.fetchAllLast()
                    }
                }
            } else {
                
                
            }
        }
    }
}

#Preview {
    StakeMainView()
}

