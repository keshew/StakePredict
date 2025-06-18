import SwiftUI

class StakeMainViewModel: ObservableObject {
    let contact = StakeMainModel()
    @Published var isMyNotes = false
    @Published var isMyPredictions = false
    @Published var isTeamNotes = false
    @Published var isSettings = false
    
    @Published var lastMyNote: MyNote?
    @Published var lastPrediction: MyPrediction?
    @Published var lastTeamNote: WholeNote?
    @Published var isLoadingPrediction = false
    @Published var isLoadingMyNote = false
    @Published var isLoadingTeamNote = false
    @Published var isGuestTapped = false
    
    func fetchLastPrediction(email: String) {
        isLoadingPrediction = true
        NetworkManager.shared.getPredictions(email: email) { result in
            DispatchQueue.main.async {
                self.isLoadingPrediction = false
                switch result {
                case .success(let predictions):
                    self.lastPrediction = predictions.last
                case .failure:
                    self.lastPrediction = nil
                }
            }
        }
    }
    
    func fetchLastMyNote(email: String) {
        isLoadingMyNote = true
        NetworkManager.shared.getNotes(email: email) { result in
            DispatchQueue.main.async {
                self.isLoadingMyNote = false
                switch result {
                case .success(let notes):
                    self.lastMyNote = notes.last
                case .failure:
                    self.lastMyNote = nil
                }
            }
        }
    }

    func fetchLastTeamNote() {
        isLoadingTeamNote = true
        NetworkManager.shared.getWholeNotes { result in
            DispatchQueue.main.async {
                self.isLoadingTeamNote = false
                switch result {
                case .success(let notes):
                    self.lastTeamNote = notes.last
                case .failure:
                    self.lastTeamNote = nil
                }
            }
        }
    }

    
    func fetchAllLast() {
        fetchLastMyNote(email: UserDefaultsManager().getEmail() ?? "testuser@example.com")
        fetchLastPrediction(email: UserDefaultsManager().getEmail() ?? "testuser@example.com")
        fetchLastTeamNote()
    }
}
