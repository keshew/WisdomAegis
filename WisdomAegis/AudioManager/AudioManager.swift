import AVFoundation
import SwiftUI

class SoundManager: ObservableObject {
    static let shared = SoundManager()
    
    private var bgPlayer: AVAudioPlayer?
    private var slotsPlayer: AVAudioPlayer?
    private var wheelPlayer: AVAudioPlayer?
    
    @Published var isBgOn: Bool = UserDefaults.standard.bool(forKey: "isOns") {
        didSet {
            UserDefaults.standard.set(isBgOn, forKey: "isOns")
            if isBgOn {
                playBackgroundMusic()
            } else {
                stopBackgroundMusic()
            }
        }
    }
    
    @Published var isSoundsOn: Bool = UserDefaults.standard.bool(forKey: "isSoundOn") {
        didSet {
            UserDefaults.standard.set(isSoundsOn, forKey: "isSoundOn")
            if !isSoundsOn {
                stopSoundEffects()
            }
        }
    }
    
    private init() {
        loadSounds()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    private func loadSounds() {
        bgPlayer = loadSound(resource: "bg", type: "mp3", loops: -1)
        slotsPlayer = loadSound(resource: "slots", type: "mp3")
        wheelPlayer = loadSound(resource: "wheel", type: "mp3")
    }
    
    private func loadSound(resource: String, type: String, loops: Int = 0) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: resource, withExtension: type) else {
            print("Звук \(resource).\(type) не найден")
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = loops
            player.volume = 1.0
            player.prepareToPlay()
            return player
        } catch {
            print("Ошибка загрузки звука \(resource): \(error)")
            return nil
        }
    }
    
    func playBackgroundMusic() {
        guard isBgOn else { return }
        if bgPlayer?.isPlaying != true {
            bgPlayer?.play()
        }
    }
    
    func stopBackgroundMusic() {
        bgPlayer?.stop()
    }
    
    func playSlots() {
        guard isSoundsOn else { return }
        slotsPlayer?.play()
    }
    
    func playWheel() {
        guard isSoundsOn else { return }
        wheelPlayer?.play()
    }
    
    func stopSoundEffects() {
        slotsPlayer?.stop()
        wheelPlayer?.stop()
    }
    
    @objc private func userDefaultsDidChange() {
        let bgState = UserDefaults.standard.bool(forKey: "isOns")
        if bgState != isBgOn {
            isBgOn = bgState
        }
        let soundState = UserDefaults.standard.bool(forKey: "isSoundOn")
        if soundState != isSoundsOn {
            isSoundsOn = soundState
            if !soundState {
                stopSoundEffects()
            }
        }
    }
}
