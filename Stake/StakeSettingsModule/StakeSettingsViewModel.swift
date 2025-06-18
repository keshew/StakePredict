import SwiftUI

class StakeSettingsViewModel: ObservableObject {
    let contact = StakeSettingsModel()
    @Published var isEdit = false
    @Published var isLog = false
    @Published var isSign = false
    @Published var isOnb = false
    @Published var showDeleteAlert = false
    @Published var isNotif: Bool {
        didSet {
            UserDefaults.standard.set(isNotif, forKey: "isNotif")
        }
    }
    @Published var isEmail: Bool {
        didSet {
            UserDefaults.standard.set(isEmail, forKey: "isEmail")
        }
    }
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    init() {
        self.isNotif = UserDefaults.standard.bool(forKey: "isNotif")
        self.isEmail = UserDefaults.standard.bool(forKey: "isEmail")
    }
    
    func logOut(completion: @escaping (Bool) -> Void) {
        guard
            let email = UserDefaultsManager().getEmail(),
            let password = UserDefaultsManager().getPassword()
        else {
            alertMessage = "Email or password not found."
            showAlert = true
            completion(false)
            return
        }
        
        NetworkManager.shared.logOut(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(true)
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    completion(false)
                }
            }
        }
    }
    
    func quit() {
        UserDefaultsManager().saveLoginStatus(false)
        UserDefaultsManager().deletePassword()
        UserDefaultsManager().deletePhone()
        UserDefaultsManager().deleteName()
        
        isOnb = true
    }
}
