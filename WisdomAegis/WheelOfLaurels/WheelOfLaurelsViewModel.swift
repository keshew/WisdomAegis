import SwiftUI

class WheelOfLaurelsViewModel: ObservableObject {
    let contact = WheelOfLaurelsModel()
    @Published var coins =  UserDefaultsManager.shared.coins
    @Published var bet = 50
    @ObservedObject private var soundManager = SoundManager.shared
}
