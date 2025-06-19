import SwiftUI

class StakeOnboardingViewModel: ObservableObject {
    let contact = StakeOnboardingModel()
    @Published var isStart = false
    @Published var isLogin = false
    @Published var isSign = false
}
