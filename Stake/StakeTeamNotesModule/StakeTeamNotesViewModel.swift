import SwiftUI

class StakeTeamNotesViewModel: ObservableObject {
    let contact = StakeTeamNotesModel()
    @Published var isAdd = false
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var notes: [WholeNote] = []
    @Published var isLoading = false
    @Published var isBack = false
    func fetchTeamNotes() {
        isLoading = true
        NetworkManager.shared.getWholeNotes { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let notes):
                    self.notes = notes
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }
    
    func firstLetter(from username: String?) -> String {
        guard let username = username, let first = username.first else {
            return "?"
        }
        return String(first).uppercased()
    }

}
