import SwiftUI

class StakeEditViewModel: ObservableObject {
    let contact = StakeEditModel()
    @Published var name = ""
    @Published var email = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isBack = false
    
    var oldEmail: String? {
        UserDefaultsManager().getEmail()
    }
    
    func changeUser(completion: @escaping (Bool) -> Void) {
        guard let oldEmail = oldEmail else {
            alertMessage = "Current email not found."
            showAlert = true
            completion(false)
            return
        }
        if name.trimmingCharacters(in: .whitespaces).isEmpty || email.trimmingCharacters(in: .whitespaces).isEmpty {
            alertMessage = "All fields must be filled in."
            showAlert = true
            completion(false)
            return
        }
        
        NetworkManager.shared.changeUser(oldEmail: oldEmail, newUsername: name, newEmail: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    UserDefaultsManager().saveName(self.name)
                    UserDefaultsManager().saveCurrentEmail(self.email)
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
