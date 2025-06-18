import SwiftUI

class StakeCreatePredictionViewModel: ObservableObject {
    let contact = StakeCreatePredictionModel()
    @Published var name = ""
    @Published var desc = ""
    @Published var date = Date()
    @Published var firstTeamName: String = ""
    @Published var secondTeamName: String = ""
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isSaved: Bool = false

    @Published var isBack = false
    
    func savePrediction(
        firstTeamImage: UIImage?,
        secondTeamImage: UIImage?,
        completion: @escaping (Bool) -> Void
    ) {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            firstTeamName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            secondTeamName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            desc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertMessage = "Fill in all required fields!"
            showAlert = true
            completion(false)
            return
        }
        
        var firstImageString: String? = nil
        if let image = firstTeamImage, let data = image.jpegData(compressionQuality: 0.7) {
            firstImageString = data.base64EncodedString()
        }
        var secondImageString: String? = nil
        if let image = secondTeamImage, let data = image.jpegData(compressionQuality: 0.7) {
            secondImageString = data.base64EncodedString()
        }
        
        NetworkManager.shared.addPrediction(
            email: UserDefaultsManager().getEmail() ?? "testuser@example.com",
            firstTeamName: firstTeamName,
            secondTeamName: secondTeamName,
            firstTeamImage: firstImageString ?? "",
            secondTeamImage: secondImageString ?? "",
            date: date,
            textOfPrediction: desc
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isSaved = true
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
