import SwiftUI

class StakeLoginViewModel: ObservableObject {
    let contact = StakeLoginModel()
    @Published var email = ""
    @Published var password = ""
    @Published var isSkip = false
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func login(completion: @escaping (Bool) -> Void) {
        if email.isEmpty || password.isEmpty {
            alertMessage = "All fields must be filled in."
            showAlert = true
            completion(false)
            return
        }
        NetworkManager.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    UserDefaultsManager().saveName(response.username)
                    UserDefaultsManager().savePassword(self.password)
                    UserDefaultsManager().saveCurrentEmail(self.email)
                    UserDefaultsManager().saveLoginStatus(true)
                    completion(true)
                case .failure(let error):
                    self.alertMessage = "Something went wrong."
                    self.showAlert = true
                    completion(false)
                    print(error)
                }
            }
        }
    }

}
