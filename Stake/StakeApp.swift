import SwiftUI

@main
struct StakeApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLogin() {
                StakeMainView()
            } else {
                StakeOnboardingView()
                    .onAppear {
                        UserDefaultsManager().quitQuest()
                    }
            }
        }
    }
}
