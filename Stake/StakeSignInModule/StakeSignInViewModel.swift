import SwiftUI

class StakeSignInViewModel: ObservableObject {
    let contact = StakeSignInModel()
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var confirmPassword = ""
    @Published var isLog = false
    @Published var isSkip = false
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func register(completion: @escaping (Bool) -> Void) {
        if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "All fields must be filled in."
            showAlert = true
            completion(false)
            return
        }
        
        if password != confirmPassword {
            alertMessage = "Passwords do not match."
            showAlert = true
            completion(false)
            return
        }
        
        NetworkManager.shared.register(username: name, email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
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
