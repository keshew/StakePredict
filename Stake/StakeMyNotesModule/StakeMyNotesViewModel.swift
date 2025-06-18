import SwiftUI

class StakeMyNotesViewModel: ObservableObject {
    let contact = StakeMyNotesModel()
    @Published var isAdd = false
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var notes: [MyNote] = []
    
    @Published var isBack = false
    
    var userEmail: String = UserDefaultsManager().getEmail() ?? "testuser@example.com"
    
    func fetchNotes() {
        NetworkManager.shared.getNotes(email: userEmail) { result in
            DispatchQueue.main.async {
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
}
