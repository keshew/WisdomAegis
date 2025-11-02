import SwiftUI

class WisdomBooksViewModel: ObservableObject {
    @Published var slots: [[String]] = []
    @Published var coin =  UserDefaultsManager.shared.coins
    @Published var bet = 100
    let allFruits = ["wisdom1", "wisdom2","wisdom3", "wisdom4","wisdom5", "wisdom6"]
    @Published var winningPositions: [(row: Int, col: Int)] = []
    @Published var isSpinning = false
    @Published var isStopSpininng = false
    @Published var isWin = false
    @Published var win = 0
    var spinningTimer: Timer?
    @ObservedObject private var soundManager = SoundManager.shared
    init() {
        resetSlots()
    }
    @Published var betString: String = "10" {
        didSet {
            if let newBet = Int(betString), newBet > 0 {
                bet = newBet
            }
        }
    }
    let symbolArray = [
        Symbol(image: "wisdom1", value: "1000"),
        Symbol(image: "wisdom2", value: "500"),
        Symbol(image: "wisdom3", value: "100"),
        Symbol(image: "wisdom4", value: "50"),
        Symbol(image: "wisdom5", value: "10"),
        Symbol(image: "wisdom6", value: "5")
    ]
    
    func resetSlots() {
        slots = (0..<3).map { _ in
            (0..<3).map { _ in
                allFruits.randomElement()!
            }
        }
    }
    
    func spin() {
        guard coin >= bet else { return }
        soundManager.playSlots()
        UserDefaultsManager.shared.addExperience(50)
        UserDefaultsManager.shared.updateLevelIfNeeded()
        UserDefaultsManager.shared.subtractCoins(bet)
        coin = UserDefaultsManager.shared.coins
        isSpinning = true
        spinningTimer?.invalidate()
        winningPositions.removeAll()
        win = 0

        let columns = 3
        for col in 0..<columns {
            let delay = Double(col) * 0.4
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                var spinCount = 0
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    for row in 0..<3 {
                        self.slots[row][col] = self.allFruits.randomElement()!
                    }
                    spinCount += 1
                    if spinCount > 12 + col * 4 {
                        timer.invalidate()
                        if col == columns - 1 {
                            self.isSpinning = false
                            self.soundManager.stopSoundEffects()
                            self.checkWin()
                        }
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            }
        }
    }
    
    func checkWin() {
        winningPositions = []
        var totalWin = 0
        var maxMultiplier = 0
        let minCounts = [
            "wisdom1": 3,
            "wisdom2": 3,
            "wisdom3": 3,
            "wisdom4": 3,
            "wisdom5": 3,
            "wisdom6": 3
        ]
        let multipliers = [
            "wisdom1": 1000,
            "wisdom2": 500,
            "wisdom3": 100,
            "wisdom4": 50,
            "wisdom5": 10,
            "wisdom6": 5
        ]

        for row in 0..<3 {
            let rowContent = slots[row]
            var currentSymbol = rowContent[0]
            var count = 1
            for col in 1..<rowContent.count {
                if rowContent[col] == currentSymbol {
                    count += 1
                } else {
                    if let minCount = minCounts[currentSymbol], count >= minCount {
                        totalWin += multipliers[currentSymbol] ?? 0
                        if let multiplierValue = multipliers[currentSymbol], multiplierValue > maxMultiplier {
                            maxMultiplier = multiplierValue
                        }
                        let startCol = col - count
                        for c in startCol..<col {
                            winningPositions.append((row: row, col: c))
                        }
                    }
                    currentSymbol = rowContent[col]
                    count = 1
                }
            }
            if let minCount = minCounts[currentSymbol], count >= minCount {
                totalWin += multipliers[currentSymbol] ?? 0
                if let multiplierValue = multipliers[currentSymbol], multiplierValue > maxMultiplier {
                    maxMultiplier = multiplierValue
                }
                let startCol = rowContent.count - count
                for c in startCol..<rowContent.count {
                    winningPositions.append((row: row, col: c))
                }
            }
        }

        if totalWin != 0 {
            win = (totalWin + bet)
            UserDefaultsManager.shared.addCoins(win)
            coin = UserDefaultsManager.shared.coins
            isWin = true
        }
    }
}
