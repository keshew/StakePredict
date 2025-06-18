import SwiftUI

enum PredictionType {
    case all, successful, unsuccessful
}

struct StakePredictionsView: View {
    @StateObject var stakePredictionsModel =  StakePredictionsViewModel()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedPredictionType: PredictionType = .all
    @State private var isExpanded = false
    @State private var expandedCards: Set<Int> = []
    @State private var selectedAnswers: [Int: String] = [:]
    
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
                                        stakePredictionsModel.isBack = true
                                    }) {
                                        Image(systemName: "chevron.left")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 24))
                                    }
                                    
                                    Spacer()
                                    
                                    Text("My predictions")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        stakePredictionsModel.isAdd = true
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 24))
                                    }
                                }
                                .padding(.top, 30)
                                
                                HStack(spacing: 30) {
                                    Rectangle()
                                        .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                        .overlay {
                                            VStack(spacing: 20) {
                                                Text("Your statistics on the probability of realizability of forecasts")
                                                    .Pro(size: 20)
                                                    .padding(.horizontal)
                                                
                                                let percent = correctPredictionPercent(from: stakePredictionsModel.predictions)
                                                TwoColorProgressBar(firstValue: percent)
                                                
                                                Spacer()
                                            }
                                            .padding(.top)
                                        }
                                        .frame(width: 240, height: 290)
                                        .cornerRadius(10)
                                    
                                    VStack(alignment: .leading, spacing: 20) {
                                        HStack {
                                            Button(action: {
                                                selectedPredictionType = .all
                                            }) {
                                                Text("All predictions")
                                                    .Pro(size: 12, color: selectedPredictionType == .all ? .white : Color(red: 80/255, green: 89/255, blue: 103/255))
                                                    .padding(.horizontal)
                                                    .padding(.vertical, 4)
                                                    .background(Color.clear)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(selectedPredictionType == .all ? Color.white : Color(red: 138/255, green: 143/255, blue: 153/255), lineWidth: 0.5)
                                                    )
                                            }
                                            
                                            Button(action: {
                                                selectedPredictionType = .successful
                                            }) {
                                                Text("Successful predictions")
                                                    .Pro(size: 12, color: selectedPredictionType == .successful ? .white : Color(red: 80/255, green: 89/255, blue: 103/255))
                                                    .padding(.horizontal)
                                                    .padding(.vertical, 4)
                                                    .background(Color.clear)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(selectedPredictionType == .successful ? Color.white : Color(red: 138/255, green: 143/255, blue: 153/255), lineWidth: 0.5)
                                                    )
                                            }
                                            
                                            Button(action: {
                                                selectedPredictionType = .unsuccessful
                                            }) {
                                                Text("Unsuccessful predictions")
                                                    .Pro(size: 12, color: selectedPredictionType == .unsuccessful ? .white : Color(red: 80/255, green: 89/255, blue: 103/255))
                                                    .padding(.horizontal)
                                                    .padding(.vertical, 4)
                                                    .background(Color.clear)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(selectedPredictionType == .unsuccessful ? Color.white : Color(red: 138/255, green: 143/255, blue: 153/255), lineWidth: 0.5)
                                                    )
                                            }
                                        }
                                        
                                        HStack {
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(alignment: .top) {
                                                    if stakePredictionsModel.isLoading {
                                                        ProgressView()
                                                            .scaleEffect(2.5)
                                                            .padding()
                                                    } else if filteredPredictions.isEmpty {
                                                        Text(
                                                            selectedPredictionType == .successful
                                                            ? "You have not\nsuccessful predictions"
                                                            : selectedPredictionType == .unsuccessful
                                                            ? "You have not\nunsuccessful predictions"
                                                            : "Create your first prediction!"
                                                        )
                                                        .ProBold(size: 18, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                        .multilineTextAlignment(.center)
                                                        .frame(width: 320, height: 150)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 10)
                                                                .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                                        )
                                                    } else {
                                                        ForEach(Array(filteredPredictions.enumerated()), id: \.element.id) { index, prediction in
                                                            let isPredictionToday = isToday(prediction.date)
                                                            Rectangle()
                                                                .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 10)
                                                                        .stroke(
                                                                            prediction.isPredicted ?
                                                                            (prediction.isPredictionRight ? Color(red: 17/255, green: 117/255, blue: 226/255) : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                            : Color.clear,
                                                                            lineWidth: 2
                                                                        )
                                                                        .overlay {
                                                                            VStack(spacing: 15) {
                                                                                HStack {
                                                                                    Text("You bet that \(prediction.textOfPrediction)")
                                                                                        .Pro(size: 14)
                                                                                    
                                                                                    Spacer()
                                                                                    
                                                                                    Text(stakePredictionsModel.formatDate(prediction.date))
                                                                                        .Pro(size: 14)
                                                                                }
                                                                                .padding(.horizontal, 10)
                                                                                
                                                                                Spacer()
                                                                                
                                                                                HStack {
                                                                                    if let imgData = Data(base64Encoded: prediction.firstTeamImage),
                                                                                       let uiImg = UIImage(data: imgData) {
                                                                                        Image(uiImage: uiImg)
                                                                                            .resizable()
                                                                                            .frame(width: 40, height: 40)
                                                                                            .cornerRadius(20)
                                                                                    } else {
                                                                                        ZStack {
                                                                                            Circle()
                                                                                                .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                                                                .frame(width: 40, height: 40)
                                                                                            Text(String(prediction.firstTeamName.prefix(1)).uppercased())
                                                                                                .foregroundColor(.white)
                                                                                                .font(.system(size: 20, weight: .bold))
                                                                                        }
                                                                                    }
                                                                                    
                                                                                    Text(prediction.firstTeamName)
                                                                                        .Pro(size: 14)
                                                                                    
                                                                                    Spacer()
                                                                                    
                                                                                    Text("VS")
                                                                                        .Pro(size: 12, color: Color(red: 145/255, green: 154/255, blue: 161/255))
                                                                                    
                                                                                    Spacer()
                                                                                    
                                                                                    Text(prediction.secondTeamName)
                                                                                        .Pro(size: 14)
                                                                                    
                                                                                    if let imgData = Data(base64Encoded: prediction.secondTeamImage),
                                                                                       let uiImg = UIImage(data: imgData) {
                                                                                        Image(uiImage: uiImg)
                                                                                            .resizable()
                                                                                            .frame(width: 40, height: 40)
                                                                                            .cornerRadius(20)
                                                                                    } else {
                                                                                        ZStack {
                                                                                            Circle()
                                                                                                .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                                                                .frame(width: 40, height: 40)
                                                                                            Text(String(prediction.secondTeamName.prefix(1)).uppercased())
                                                                                                .foregroundColor(.white)
                                                                                                .font(.system(size: 20, weight: .bold))
                                                                                        }
                                                                                    }
                                                                                }
                                                                                .padding(.horizontal, 10)
                                                                                
                                                                                HStack {
                                                                                    Rectangle()
                                                                                        .fill(prediction.isPredicted ?
                                                                                              (prediction.isPredictionRight ? Color(red: 17/255, green: 117/255, blue: 226/255) : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                                              : Color.clear
                                                                                        )
                                                                                        .overlay {
                                                                                            RoundedRectangle(cornerRadius: 6)
                                                                                                .stroke(prediction.isPredicted ?
                                                                                                        (prediction.isPredictionRight ? Color(red: 17/255, green: 117/255, blue: 226/255) : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                                                        : Color.white, lineWidth: 1)
                                                                                                .overlay {
                                                                                                    Text(
                                                                                                        prediction.isPredicted ?
                                                                                                        (prediction.isPredictionRight ? "Correct prediction" : "Wrong prediction")
                                                                                                        : "Expect an event"
                                                                                                    )
                                                                                                    .Pro(size: 12)
                                                                                                    .minimumScaleFactor(0.8)
                                                                                                }
                                                                                        }
                                                                                        .frame(width: 115, height: 20)
                                                                                        .cornerRadius(6)
                                                                                        .padding(.leading, 10)
                                                                                    Spacer()
                                                                                }
                                                                                
                                                                                if isPredictionToday && !prediction.isPredicted {
                                                                                    VStack(spacing: 10) {
                                                                                        Rectangle()
                                                                                            .fill(.gray)
                                                                                            .frame(height: 0.5)
                                                                                            .padding(.horizontal, 10)
                                                                                        
                                                                                        HStack {
                                                                                            Text("Are you right?")
                                                                                                .Pro(size: 14)
                                                                                                .padding(.leading, 10)
                                                                                            Spacer()
                                                                                        }
                                                                                        
                                                                                        HStack {
                                                                                            Button(action: {
                                                                                                NetworkManager.shared.updatePredictionStatus(
                                                                                                    id: prediction.id,
                                                                                                    email: UserDefaultsManager().getEmail() ?? "",
                                                                                                    isPredicted: true,
                                                                                                    isPredictionRight: true
                                                                                                ) { result in
                                                                                                    if case .success = result {
                                                                                                        DispatchQueue.main.async {
                                                                                                            self.stakePredictionsModel.predictions[index].isPredicted = true
                                                                                                            self.stakePredictionsModel.predictions[index].isPredictionRight = true
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }) {
                                                                                                Rectangle()
                                                                                                    .fill(.clear)
                                                                                                    .overlay {
                                                                                                        RoundedRectangle(cornerRadius: 6)
                                                                                                            .stroke(.white, lineWidth: 1)
                                                                                                            .overlay {
                                                                                                                Text("Yes")
                                                                                                                    .Pro(size: 13)
                                                                                                                    .minimumScaleFactor(0.8)
                                                                                                            }
                                                                                                    }
                                                                                                    .frame(width: 115, height: 30)
                                                                                                    .cornerRadius(6)
                                                                                            }
                                                                                            
                                                                                            Button(action: {
                                                                                                NetworkManager.shared.updatePredictionStatus(
                                                                                                    id: prediction.id,
                                                                                                    email: UserDefaultsManager().getEmail() ?? "",
                                                                                                    isPredicted: true,
                                                                                                    isPredictionRight: false
                                                                                                ) { result in
                                                                                                    if case .success = result {
                                                                                                        DispatchQueue.main.async {
                                                                                                            self.stakePredictionsModel.predictions[index].isPredicted = true
                                                                                                            self.stakePredictionsModel.predictions[index].isPredictionRight = false
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }) {
                                                                                                Rectangle()
                                                                                                    .fill(.clear)
                                                                                                    .overlay {
                                                                                                        RoundedRectangle(cornerRadius: 6)
                                                                                                            .stroke(.white, lineWidth: 1)
                                                                                                            .overlay {
                                                                                                                Text("No")
                                                                                                                    .Pro(size: 13)
                                                                                                                    .minimumScaleFactor(0.8)
                                                                                                            }
                                                                                                    }
                                                                                                    .frame(width: 115, height: 30)
                                                                                                    .cornerRadius(6)
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                                                                                }
                                                                            }
                                                                            .padding(.vertical, 15)
                                                                        }
                                                                }
                                                                .frame(width: 320, height: isPredictionToday && !prediction.isPredicted ? 240 : 150)
                                                                .cornerRadius(10)
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                    .padding(.bottom, 10)
                                }
                            }
                            .padding(.horizontal, 50)
                        }
                        .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                    }
                    .fullScreenCover(isPresented: $stakePredictionsModel.isAdd) {
                        StakeCreatePredictionView()
                    }
                    .fullScreenCover(isPresented: $stakePredictionsModel.isBack) {
                        StakeMainView()
                    }
                    .onAppear {
                        stakePredictionsModel.fetchPredictions()
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
                                    stakePredictionsModel.isBack = true
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24))
                                }
                                
                                Spacer()
                                
                                Text("My predictions")
                                    .ProBold(size: 24)
                                
                                Spacer()
                                
                                Button(action: {
                                    stakePredictionsModel.isAdd = true
                                }) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24))
                                }
                            }
                            .padding(.top, 30)
                            
                            HStack(spacing: 30) {
                                Rectangle()
                                    .fill(Color(red: 19/255, green: 27/255, blue: 42/255))
                                    .overlay {
                                        VStack(spacing: 20) {
                                            Text("Your statistics on the probability of realizability of forecasts")
                                                .Pro(size: 20)
                                                .padding(.horizontal)
                                            
                                            let percent = correctPredictionPercent(from: stakePredictionsModel.predictions)
                                            TwoColorProgressBar(firstValue: percent)
                                            
                                            Spacer()
                                        }
                                        .padding(.top)
                                    }
                                    .frame(width: 240, height: 290)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading, spacing: 20) {
                                    HStack {
                                        Button(action: {
                                            selectedPredictionType = .all
                                        }) {
                                            Text("All predictions")
                                                .Pro(size: 12, color: selectedPredictionType == .all ? .white : Color(red: 80/255, green: 89/255, blue: 103/255))
                                                .padding(.horizontal)
                                                .padding(.vertical, 4)
                                                .background(Color.clear)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(selectedPredictionType == .all ? Color.white : Color(red: 138/255, green: 143/255, blue: 153/255), lineWidth: 0.5)
                                                )
                                        }
                                        
                                        Button(action: {
                                            selectedPredictionType = .successful
                                        }) {
                                            Text("Successful predictions")
                                                .Pro(size: 12, color: selectedPredictionType == .successful ? .white : Color(red: 80/255, green: 89/255, blue: 103/255))
                                                .padding(.horizontal)
                                                .padding(.vertical, 4)
                                                .background(Color.clear)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(selectedPredictionType == .successful ? Color.white : Color(red: 138/255, green: 143/255, blue: 153/255), lineWidth: 0.5)
                                                )
                                        }
                                        
                                        Button(action: {
                                            selectedPredictionType = .unsuccessful
                                        }) {
                                            Text("Unsuccessful predictions")
                                                .Pro(size: 12, color: selectedPredictionType == .unsuccessful ? .white : Color(red: 80/255, green: 89/255, blue: 103/255))
                                                .padding(.horizontal)
                                                .padding(.vertical, 4)
                                                .background(Color.clear)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(selectedPredictionType == .unsuccessful ? Color.white : Color(red: 138/255, green: 143/255, blue: 153/255), lineWidth: 0.5)
                                                )
                                        }
                                    }
                                    
                                    HStack {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(alignment: .top) {
                                                if stakePredictionsModel.isLoading {
                                                    ProgressView()
                                                        .scaleEffect(2.5)
                                                        .padding()
                                                } else if filteredPredictions.isEmpty {
                                                    Text(
                                                        selectedPredictionType == .successful
                                                        ? "You have not\nsuccessful predictions"
                                                        : selectedPredictionType == .unsuccessful
                                                        ? "You have not\nunsuccessful predictions"
                                                        : "Create your first prediction!"
                                                    )
                                                    .ProBold(size: 18, color: Color(red: 196/255, green: 197/255, blue: 202/255))
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 320, height: 150)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                                    )
                                                } else {
                                                    ForEach(Array(filteredPredictions.enumerated()), id: \.element.id) { index, prediction in
                                                        let isPredictionToday = isToday(prediction.date)
                                                        Rectangle()
                                                            .fill(Color(red: 33/255, green: 55/255, blue: 67/255))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 10)
                                                                    .stroke(
                                                                        prediction.isPredicted ?
                                                                        (prediction.isPredictionRight ? Color(red: 17/255, green: 117/255, blue: 226/255) : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                        : Color.clear,
                                                                        lineWidth: 2
                                                                    )
                                                                    .overlay {
                                                                        VStack(spacing: 15) {
                                                                            HStack {
                                                                                Text("You bet that \(prediction.textOfPrediction)")
                                                                                    .Pro(size: 14)
                                                                                
                                                                                Spacer()
                                                                                
                                                                                Text(stakePredictionsModel.formatDate(prediction.date))
                                                                                    .Pro(size: 14)
                                                                            }
                                                                            .padding(.horizontal, 10)
                                                                            
                                                                            Spacer()
                                                                            
                                                                            HStack {
                                                                                if let imgData = Data(base64Encoded: prediction.firstTeamImage),
                                                                                   let uiImg = UIImage(data: imgData) {
                                                                                    Image(uiImage: uiImg)
                                                                                        .resizable()
                                                                                        .frame(width: 40, height: 40)
                                                                                        .cornerRadius(20)
                                                                                } else {
                                                                                    ZStack {
                                                                                        Circle()
                                                                                            .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                                                            .frame(width: 40, height: 40)
                                                                                        Text(String(prediction.firstTeamName.prefix(1)).uppercased())
                                                                                            .foregroundColor(.white)
                                                                                            .font(.system(size: 20, weight: .bold))
                                                                                    }
                                                                                }
                                                                                
                                                                                Text(prediction.firstTeamName)
                                                                                    .Pro(size: 14)
                                                                                
                                                                                Spacer()
                                                                                
                                                                                Text("VS")
                                                                                    .Pro(size: 12, color: Color(red: 145/255, green: 154/255, blue: 161/255))
                                                                                
                                                                                Spacer()
                                                                                
                                                                                Text(prediction.secondTeamName)
                                                                                    .Pro(size: 14)
                                                                                
                                                                                if let imgData = Data(base64Encoded: prediction.secondTeamImage),
                                                                                   let uiImg = UIImage(data: imgData) {
                                                                                    Image(uiImage: uiImg)
                                                                                        .resizable()
                                                                                        .frame(width: 40, height: 40)
                                                                                        .cornerRadius(20)
                                                                                } else {
                                                                                    ZStack {
                                                                                        Circle()
                                                                                            .fill(Color(red: 20/255, green: 117/255, blue: 225/255))
                                                                                            .frame(width: 40, height: 40)
                                                                                        Text(String(prediction.secondTeamName.prefix(1)).uppercased())
                                                                                            .foregroundColor(.white)
                                                                                            .font(.system(size: 20, weight: .bold))
                                                                                    }
                                                                                }
                                                                            }
                                                                            .padding(.horizontal, 10)
                                                                            
                                                                            HStack {
                                                                                Rectangle()
                                                                                    .fill(prediction.isPredicted ?
                                                                                          (prediction.isPredictionRight ? Color(red: 17/255, green: 117/255, blue: 226/255) : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                                          : Color.clear
                                                                                    )
                                                                                    .overlay {
                                                                                        RoundedRectangle(cornerRadius: 6)
                                                                                            .stroke(prediction.isPredicted ?
                                                                                                    (prediction.isPredictionRight ? Color(red: 17/255, green: 117/255, blue: 226/255) : Color(red: 228/255, green: 51/255, blue: 55/255))
                                                                                                    : Color.white, lineWidth: 1)
                                                                                            .overlay {
                                                                                                Text(
                                                                                                    prediction.isPredicted ?
                                                                                                    (prediction.isPredictionRight ? "Correct prediction" : "Wrong prediction")
                                                                                                    : "Expect an event"
                                                                                                )
                                                                                                .Pro(size: 12)
                                                                                                .minimumScaleFactor(0.8)
                                                                                            }
                                                                                    }
                                                                                    .frame(width: 115, height: 20)
                                                                                    .cornerRadius(6)
                                                                                    .padding(.leading, 10)
                                                                                Spacer()
                                                                            }
                                                                            
                                                                            if isPredictionToday && !prediction.isPredicted {
                                                                                VStack(spacing: 10) {
                                                                                    Rectangle()
                                                                                        .fill(.gray)
                                                                                        .frame(height: 0.5)
                                                                                        .padding(.horizontal, 10)
                                                                                    
                                                                                    HStack {
                                                                                        Text("Are you right?")
                                                                                            .Pro(size: 14)
                                                                                            .padding(.leading, 10)
                                                                                        Spacer()
                                                                                    }
                                                                                    
                                                                                    HStack {
                                                                                        Button(action: {
                                                                                            NetworkManager.shared.updatePredictionStatus(
                                                                                                id: prediction.id,
                                                                                                email: UserDefaultsManager().getEmail() ?? "",
                                                                                                isPredicted: true,
                                                                                                isPredictionRight: true
                                                                                            ) { result in
                                                                                                if case .success = result {
                                                                                                    DispatchQueue.main.async {
                                                                                                        self.stakePredictionsModel.predictions[index].isPredicted = true
                                                                                                        self.stakePredictionsModel.predictions[index].isPredictionRight = true
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }) {
                                                                                            Rectangle()
                                                                                                .fill(.clear)
                                                                                                .overlay {
                                                                                                    RoundedRectangle(cornerRadius: 6)
                                                                                                        .stroke(.white, lineWidth: 1)
                                                                                                        .overlay {
                                                                                                            Text("Yes")
                                                                                                                .Pro(size: 13)
                                                                                                                .minimumScaleFactor(0.8)
                                                                                                        }
                                                                                                }
                                                                                                .frame(width: 115, height: 30)
                                                                                                .cornerRadius(6)
                                                                                        }
                                                                                        
                                                                                        Button(action: {
                                                                                            NetworkManager.shared.updatePredictionStatus(
                                                                                                id: prediction.id,
                                                                                                email: UserDefaultsManager().getEmail() ?? "",
                                                                                                isPredicted: true,
                                                                                                isPredictionRight: false
                                                                                            ) { result in
                                                                                                if case .success = result {
                                                                                                    DispatchQueue.main.async {
                                                                                                        self.stakePredictionsModel.predictions[index].isPredicted = true
                                                                                                        self.stakePredictionsModel.predictions[index].isPredictionRight = false
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }) {
                                                                                            Rectangle()
                                                                                                .fill(.clear)
                                                                                                .overlay {
                                                                                                    RoundedRectangle(cornerRadius: 6)
                                                                                                        .stroke(.white, lineWidth: 1)
                                                                                                        .overlay {
                                                                                                            Text("No")
                                                                                                                .Pro(size: 13)
                                                                                                                .minimumScaleFactor(0.8)
                                                                                                        }
                                                                                                }
                                                                                                .frame(width: 115, height: 30)
                                                                                                .cornerRadius(6)
                                                                                        }
                                                                                    }
                                                                                }
                                                                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                                                                            }
                                                                        }
                                                                        .padding(.vertical, 15)
                                                                    }
                                                            }
                                                            .frame(width: 320, height: isPredictionToday && !prediction.isPredicted ? 240 : 150)
                                                            .cornerRadius(10)
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    .scrollDisabled(UIScreen.main.bounds.height > 380  ? true : false)
                }
                .fullScreenCover(isPresented: $stakePredictionsModel.isAdd) {
                    StakeCreatePredictionView()
                }
                .fullScreenCover(isPresented: $stakePredictionsModel.isBack) {
                    StakeMainView()
                }
                .onAppear {
                    stakePredictionsModel.fetchPredictions()
                }
            } else {
                
                
            }
        }
    }
    
    func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var filteredPredictions: [MyPrediction] {
        switch selectedPredictionType {
        case .all:
            return stakePredictionsModel.predictions
        case .successful:
            return stakePredictionsModel.predictions.filter { $0.isPredicted && $0.isPredictionRight }
        case .unsuccessful:
            return stakePredictionsModel.predictions.filter { $0.isPredicted && !$0.isPredictionRight }
            
        }
    }
    
    func correctPredictionPercent(from predictions: [MyPrediction]) -> CGFloat {
        let total = predictions.filter { $0.isPredicted }.count
        guard total > 0 else { return 0 }
        let correct = predictions.filter { $0.isPredicted && $0.isPredictionRight }.count
        return CGFloat(correct) / CGFloat(total) * 100
    }

}

#Preview {
    StakePredictionsView()
}

struct TwoColorProgressBar: View {
    var firstValue: CGFloat
    var secondValue: CGFloat { 100 - firstValue }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text("\(Int(firstValue))%")
                .Pro(size: 20)
                .padding(.trailing)
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color(red: 17/255, green: 117/255, blue: 226/255))
                        .frame(width: geometry.size.width * (firstValue / 100), height: 5)
                    
                    Rectangle()
                        .fill(Color(red: 239/255, green: 47/255, blue: 49/255))
                        .frame(width: geometry.size.width * (secondValue / 100), height: 5)
                }
                .cornerRadius(5)
            }
            .frame(height: 5)
            .padding(.horizontal)
        }
    }
}
