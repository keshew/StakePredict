import SwiftUI

class StakeCreateTeamNoteViewModel: ObservableObject {
    let contact = StakeCreateTeamNoteModel()
    @Published var name = ""
    @Published var desc = ""
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isNoteSaved: Bool = false
    @Published var isBack = false
    
    func saveTeamNote(image: UIImage?, completion: @escaping (Bool) -> Void) {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            desc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "All fields must be filled in."
            showAlert = true
            completion(false)
            return
        }
        
        var imageString: String? = nil
        if let image = image {
            if let data = image.jpegData(compressionQuality: 0.7) {
                imageString = data.base64EncodedString()
            }
        }
        
        NetworkManager.shared.addWholeNote(
            title: name,
            textOfNote: desc,
            image: imageString,
            username: UserDefaultsManager().getName() ?? "testuser@example.com"
        ) { result in
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
