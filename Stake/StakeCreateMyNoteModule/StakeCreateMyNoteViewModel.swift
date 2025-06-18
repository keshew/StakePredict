import SwiftUI

class StakeCreateMyNoteViewModel: ObservableObject {
    let contact = StakeCreateMyNoteModel()
    @Published var name = ""
    @Published var desc = ""
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isNoteSaved: Bool = false
    @Published var isBack = false
    
    var userEmail: String = UserDefaultsManager().getEmail() ?? "testuser@example.com"
    
    func saveNote(completion: @escaping (Bool) -> Void) {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            desc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "All fields must be filled in."
            showAlert = true
            completion(false)
            return
        }
        
        NetworkManager.shared.addNote(email: userEmail, title: name, textOfNote: desc) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isNoteSaved = true
                    completion(true)
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    completion(false)
                }
            }
        }
    }
}
