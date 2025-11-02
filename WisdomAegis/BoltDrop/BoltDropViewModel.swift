import SwiftUI
import Combine

class BoltDropViewModel: ObservableObject {
    @Published var coins: Int = UserDefaultsManager.shared.coins
    @Published var timeRemaining: Int = 120
    @Published var isEnd: Bool = false
    
    private var timer: AnyCancellable?
    
    func startTimer() {
        isEnd = false
        timeRemaining = 120
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.isEnd = true
                    self.timer?.cancel()
                }
            }
    }
    
    func stopTimer() {
        timer?.cancel()
    }
}

