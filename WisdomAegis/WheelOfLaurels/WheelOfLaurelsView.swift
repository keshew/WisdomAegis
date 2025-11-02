import SwiftUI

struct WheelGuess: Identifiable {
    var id = UUID()
    var text: String
    var color: Color
}

struct WheelOfLaurelsView: View {
    @StateObject var viewModel =  WheelOfLaurelsViewModel()
    @Environment(\.presentationMode) var presentationMode
    var array = [WheelGuess(text: "0.5x", color: Color(red: 43/255, green: 128/255, blue: 255/255)),
                 WheelGuess(text: "1x", color: Color(red: 0/255, green: 188/255, blue: 125/255)),
                 WheelGuess(text: "2x", color: Color(red: 254/255, green: 154/255, blue: 2/255)),
                 WheelGuess(text: "5x", color: Color(red: 139/255, green: 92/255, blue: 246/255)),
                 WheelGuess(text: "10x", color: Color(red: 251/255, green: 44/255, blue: 55/255))]
    @ObservedObject private var soundManager = SoundManager.shared
    @State private var rotation: Double = 0
    @State private var isSpinning = false
    @State private var selectedBetIndex: Int? = 0
    let segments = ["0.5x", "1x", "2x", "5x", "10x", "2x", "1x", "0.5x"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 70/255, green: 25/255, blue: 14/255),
                                    Color(red: 116/255, green: 62/255, blue: 14/255),
                                    Color(red: 70/255, green: 25/255, blue: 14/255)], startPoint: .top, endPoint: .bottom) .ignoresSafeArea()
            
            Image(.wheelBG)
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
                        
                        Text("Wheel\nof Laurels")
                            .FontRegular(size: 16, color: Color(red: 199/255, green: 168/255, blue: 106/255))
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
                }
                .padding(.top)
                
                ZStack(alignment: .top) {
                    Image(.wheel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 350)
                        .rotationEffect(.degrees(rotation))
                        .animation(.easeOut(duration: 2.5), value: rotation)
                    Image(.pin)
                        .resizable()
                        .frame(width: 16, height: 32)
                }
                
                Rectangle()
                    .fill(.clear)
                    .frame(height: 130)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white, lineWidth: 3)
                            .overlay {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("BET AMOUNT")
                                        .FontBold(size: 12, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                    
                                    HStack {
                                        Button(action: {
                                            if viewModel.bet >= 100 {
                                                viewModel.bet -= 50
                                            }
                                        }) {
                                            Image(.minus)
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                        }
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 15) {
                                            Image(.coins)
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                            
                                            Text("\(viewModel.bet)")
                                                .FontRegular(size: 24)
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            if (viewModel.bet + 50) <= viewModel.coins {
                                                viewModel.bet += 50
                                            }
                                        }) {
                                            Image(.plus)
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                    }
                    .cornerRadius(24)
                    .padding(.horizontal)
                    .padding(.top, 15)
                
                Button(action: {
                    withAnimation {
                        spinWheel(selectedBet: array[selectedBetIndex ?? 0].text)
                    }
                }) {
                    Rectangle()
                        .fill(.clear)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 2)
                                .overlay {
                                    Text("Spin the Wheel")
                                        .FontSemiBold(size: 17, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                }
                        }
                        .frame(height: 64)
                        .padding(.horizontal)
                        .padding(.top, 15)
                }
                .disabled(isSpinning)
                
                HStack {
                    ForEach(array.indices, id: \.self) { index in
                        let item = array[index]
                        Button(action: {
                            selectedBetIndex = index
                        }) {
                            Rectangle()
                                .fill(item.color.opacity(0.2))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(item.color.opacity(0.3), lineWidth: 4)
                                       
                                        .overlay {
                                            Text(item.text)
                                                .FontRegular(size: 14)
                                        }
                                }
                                .frame(height: 38)
                                .cornerRadius(4)
                        }
                        .shadow(color: selectedBetIndex == index ? item.color : .clear, radius: 5)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 15)
            }
        }
    }
    
    func spinWheel(selectedBet: String) {
        guard !isSpinning, viewModel.coins >= viewModel.bet else { return }
        soundManager.playWheel()
        UserDefaultsManager.shared.addExperience(50)
        UserDefaultsManager.shared.updateLevelIfNeeded()
        isSpinning = true
        UserDefaultsManager.shared.subtractCoins(viewModel.bet)
        viewModel.coins = UserDefaultsManager.shared.coins
        
        let segmentsCount = segments.count
        let perSegment = 360.0 / Double(segmentsCount)
        let winnerIndex = Int.random(in: 0..<segmentsCount)
        let fullRotations = 6.0
        let offsetDegrees = 5.0
        let targetAngle = fullRotations * 360 - Double(winnerIndex) * perSegment - perSegment / 2 + offsetDegrees
        let finalRotation = rotation + targetAngle
        
        withAnimation(.easeOut(duration: 3.0)) {
            rotation = finalRotation
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let normalizedAngle = finalRotation.truncatingRemainder(dividingBy: 360)
            let adjustedAngle = (normalizedAngle - offsetDegrees).truncatingRemainder(dividingBy: 360)
            var calculatedIndex = Int((360 - adjustedAngle) / perSegment)
            if calculatedIndex < 0 { calculatedIndex += segmentsCount }
            calculatedIndex = calculatedIndex % segmentsCount
            
            let winningSegment = segments[calculatedIndex]
            
            if winningSegment == selectedBet {
                UserDefaultsManager.shared.addCoins(viewModel.bet * 2)
                viewModel.coins = UserDefaultsManager.shared.coins
            } else {
                print("Выпало \(winningSegment), попробуйте ещё раз")
            }
            
            isSpinning = false
            soundManager.stopSoundEffects()
        }
    }
}

#Preview {
    WheelOfLaurelsView()
}
