import SwiftUI

struct BoltDropView: View {
    @StateObject var viewModel =  BoltDropViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var gameSceneID = UUID()
    @State private var score = 0
    @State private var combo = 0
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = UIScreen.main.bounds.size
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 70/255, green: 25/255, blue: 144/255),
                                    Color(red: 116/255, green: 62/255, blue: 154/255),
                                    Color(red: 70/255, green: 25/255, blue: 154/255)], startPoint: .top, endPoint: .bottom) .ignoresSafeArea()
            
            Image(.boltDropBG)
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Rectangle()
                                .fill(.clear)
                                .frame(width: 106, height: 52)
                                .overlay  {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
                                        .overlay {
                                            HStack {
                                                Text("← Back")
                                                    .FontBold(size: 16)
                                            }
                                        }
                                }
                                .cornerRadius(16)
                        }
                        
                        Spacer()
                        
                        Text("Bolt Drop")
                            .FontRegular(size: 16, color: Color(red: 81/255, green: 162/255, blue: 255/255))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 138, height: 56)
                            .overlay  {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
                                    .overlay {
                                        HStack(spacing: 15) {
                                            Image(.coins)
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                            
                                            Text("\(viewModel.coins)")
                                                .FontRegular(size: 16)
                                        }
                                        .padding(.trailing, 10)
                                    }
                            }
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    
                        HStack(spacing: 15) {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 90)
                                .overlay  {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 43/255, green: 128/255, blue: 255/255), lineWidth: 3)
                                        .overlay {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 10) {
                                                    Text("TIME")
                                                        .FontBold(size: 12, color: Color(red: 81/255, green: 162/255, blue: 255/255))
                                                    
                                                    Text("\(viewModel.timeRemaining / 60)m \(viewModel.timeRemaining % 60)s")
                                                        .FontRegular(size: 20)
                                                }
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                        }
                                }
                                .cornerRadius(16)
                            
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 90)
                                .overlay  {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
                                        .overlay {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 10) {
                                                    Text("SCORE")
                                                        .FontBold(size: 12, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                                    
                                                    Text("\(score)")
                                                        .FontRegular(size: 24)
                                                }
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                        }
                                }
                                .cornerRadius(16)
                            
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 90)
                                .overlay  {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 172/255, green: 70/255, blue: 255/255), lineWidth: 3)
                                        .overlay {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 10) {
                                                    Text("COMBO")
                                                        .FontBold(size: 12, color: Color(red: 172/255, green: 70/255, blue: 255/255))
                                                    
                                                    Text("x\(combo)")
                                                        .FontRegular(size: 24)
                                                }
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                        }
                                }
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .opacity(viewModel.isEnd ? 0 : 1)
                    
                    if !viewModel.isEnd {
                        ZStack(alignment: .bottom) {
                            ZStack(alignment: .top) {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(height: 500)
                                    .overlay  {
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(red: 43/255, green: 128/255, blue: 255/255), lineWidth: 3)
                                            .overlay {
                                                
                                            }
                                    }
                                    .cornerRadius(16)
                                
                                
                                SpriteView(scene: scene, options: .allowsTransparency)
                                    .ignoresSafeArea()
                                    .id(gameSceneID)
                                    .frame(height: 450)
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            Text("Tap the bolts!")
                                .FontRegular(size: 14)
                                .padding(.bottom)
                        }
                    } else {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 364)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
                                    .overlay {
                                        VStack(spacing: 16) {
                                            Text("Game Over!")
                                                .FontRegular(size: 16, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                            
                                            VStack(spacing: 10) {
                                                Text("FINAL SCORE")
                                                    .FontBold(size: 12)
                                                
                                                Text("\(score)")
                                                    .FontRegular(size: 36)
                                            }
                                            
                                            VStack(spacing: 10) {
                                                Text("You Won")
                                                    .FontBold(size: 12)
                                                
                                                HStack {
                                                    Image(.coins)
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                    
                                                    Text("\(score * 2)")
                                                        .FontRegular(size: 30, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                                }
                                            }
                                            
                                            HStack(spacing: 16) {
                                                Button(action: {
                                                    viewModel.isEnd = false
                                                    score = 0
                                                    combo = 0
                                                    viewModel.startTimer()
                                                }) {
                                                    Rectangle()
                                                        .fill(.clear)
                                                        .frame(height: 52)
                                                        .overlay  {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
                                                                .overlay {
                                                                    HStack {
                                                                        Text("Play Again")
                                                                            .FontBold(size: 16)
                                                                    }
                                                                }
                                                        }
                                                        .cornerRadius(16)
                                                }
                                                
                                                Button(action: {
                                                    presentationMode.wrappedValue.dismiss()
                                                }) {
                                                    Rectangle()
                                                        .fill(.clear)
                                                        .frame(height: 52)
                                                        .overlay  {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color(red: 54/255, green: 77/255, blue: 125/255), lineWidth: 3)
                                                                .overlay {
                                                                    HStack {
                                                                        Text("Exit")
                                                                            .FontBold(size: 16)
                                                                    }
                                                                }
                                                        }
                                                        .cornerRadius(16)
                                                }
                                            }
                                            .padding(.horizontal, 20)
                                            .padding(.top)
                                        }
                                    }
                            }
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .padding(.top)
                            .onAppear() {
                                UserDefaultsManager.shared.addCoins(score * 2)
                                viewModel.coins = UserDefaultsManager.shared.coins
                                UserDefaultsManager.shared.addExperience(50)
                                UserDefaultsManager.shared.updateLevelIfNeeded()
                            }
                    }
                }
                .padding(.top)
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: .boltCollected, object: nil, queue: .main) { notification in
                       score += 1
                       if let info = notification.userInfo, let newCombo = info["combo"] as? Int {
                           combo = newCombo
                       }
                   }

                   NotificationCenter.default.addObserver(forName: .boltMissed, object: nil, queue: .main) { _ in
                       combo = 0
                   }
            
            viewModel.startTimer()
        }
        .onDisappear {
                  NotificationCenter.default.removeObserver(self, name: .boltCollected, object: nil)
                  NotificationCenter.default.removeObserver(self, name: .boltMissed, object: nil)
              }
    }
}

#Preview {
    BoltDropView()
}

import SpriteKit

extension Notification.Name {
    static let boltCollected = Notification.Name("boltCollected")
    static let boltMissed = Notification.Name("boltMissed")
}

class GameScene: SKScene {
    let boltName = "bolts"
    private var comboCount = 0

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        let createBolt = SKAction.run { [weak self] in self?.spawnBolt() }
        let wait = SKAction.wait(forDuration: 1.0)
        run(SKAction.repeatForever(SKAction.sequence([createBolt, wait])))
    }

    func spawnBolt() {
        let bolt = SKSpriteNode(imageNamed: boltName)
        bolt.size = CGSize(width: 40, height: 40)
        bolt.name = boltName

        let randomX = CGFloat.random(in: 0...size.width)
        bolt.position = CGPoint(x: randomX, y: size.height + bolt.size.height/2)
        addChild(bolt)

        let moveDown = SKAction.moveTo(y: -bolt.size.height/2, duration: 5.0)
        let removeAction = SKAction.run { [weak self, weak bolt] in
            // Если bolt не собран и ушел вниз, комбо сбрасываем, отправляем уведомление
            guard let self = self, let bolt = bolt else { return }
            if bolt.parent != nil { // еще не удален значит пропущен
                self.comboCount = 0
                NotificationCenter.default.post(name: .boltMissed, object: nil)
            }
        }
        let remove = SKAction.removeFromParent()
        bolt.run(SKAction.sequence([moveDown, removeAction, remove]))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodesAtPoint = nodes(at: location)
            for node in nodesAtPoint where node.name == boltName {
                node.removeFromParent()
                comboCount += 1
                NotificationCenter.default.post(name: .boltCollected, object: nil, userInfo: ["combo": comboCount])
            }
        }
    }
}
