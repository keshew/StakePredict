import SwiftUI

class StakePredictionsViewModel: ObservableObject {
    let contact = StakePredictionsModel()
    @Published var isAdd = false
    @Published var predictions: [MyPrediction] = []
    @Published var isLoading = false
    @Published var isBack = false
    
    func fetchPredictions() {
        isLoading = true
        NetworkManager.shared.getPredictions(email: UserDefaultsManager().getEmail() ?? "testuser@example.com") { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let predictions):
                    self.predictions = predictions
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
    }
}
