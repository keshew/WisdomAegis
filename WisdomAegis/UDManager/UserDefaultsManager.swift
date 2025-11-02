import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let coinsKey = "coins_key"
    private let experienceKey = "experience_key"
    private let levelKey = "level_key"
    
    private let defaults = UserDefaults.standard
    
    private init() {
        if defaults.object(forKey: coinsKey) == nil {
            defaults.set(0, forKey: coinsKey)
        }
        if defaults.object(forKey: experienceKey) == nil {
            defaults.set(0, forKey: experienceKey)
        }
        if defaults.object(forKey: levelKey) == nil {
            defaults.set(1, forKey: levelKey)
        }
    }
    
    // MARK: - Работа с монетами
    
    var coins: Int {
        get {
            return defaults.integer(forKey: coinsKey)
        }
        set {
            defaults.set(newValue, forKey: coinsKey)
        }
    }
    
    func addCoins(_ amount: Int) {
        guard amount > 0 else { return }
        coins += amount
    }
    
    func subtractCoins(_ amount: Int) {
        guard amount > 0 else { return }
        coins = max(coins - amount, 0)
    }
    
    // MARK: - Работа с опытом
    
    var experience: Int {
        get {
            return defaults.integer(forKey: experienceKey)
        }
        set {
            defaults.set(newValue, forKey: experienceKey)
        }
    }
    
    func addExperience(_ amount: Int) {
        guard amount > 0 else { return }
        experience += amount
    }
    
    // MARK: - Работа с уровнем
    
    var level: Int {
        get {
            return max(defaults.integer(forKey: levelKey), 1)
        }
        set {
            defaults.set(max(newValue, 1), forKey: levelKey)
        }
    }
    
    func updateLevelIfNeeded() {
        let newLevel = experience / 1000 + 1
        if newLevel > level {
            level = newLevel
        }
    }
}
