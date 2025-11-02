import SwiftUI

struct WisdomMainView: View {
    @StateObject var viewModel =  WisdomMainViewModel()
    @State var isSettings = false
    let grid = [GridItem(.flexible()), GridItem(.flexible())]
    @State var isWisdom = false
    @State var isHeir = false
    @State var isOcean = false
    @State var isPact = false
    @State var isFateCoin = false
    @State var isWheel = false
    @State var isBolts = false
    @State var coins = UserDefaultsManager.shared.coins
    @State var level = UserDefaultsManager.shared.level
    @ObservedObject private var soundManager = SoundManager.shared
    @State private var showingAlert = false
    private var userDefaults = UserDefaultsManager.shared
    
    private let maxBarWidth: CGFloat = 122
    
    private var requiredExperience: Int {
        return userDefaults.level * 1000
    }
    
    private var experienceProgress: CGFloat {
        let progress = CGFloat(userDefaults.experience) / CGFloat(requiredExperience)
        return min(max(progress, 0), 1)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .top) {
                Image("bgMain")
                    .resizable()
                    .frame(height: 1650)
                
                LinearGradient(colors: [Color(red: 71/255, green: 46/255, blue: 107/255).opacity(0.7),
                                        Color(red: 71/255, green: 46/255, blue: 107/255).opacity(0.7)], startPoint: .top, endPoint: .bottom)
                VStack(spacing: 25) {
                    VStack(spacing: 15) {
                        HStack {
                            Rectangle()
                                .fill(.clear)
                                .frame(width: 107, height: 66)
                                .overlay  {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
                                        .overlay {
                                            HStack {
                                                Image(.coins)
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                
                                                VStack {
                                                    Text("OBOLS")
                                                        .FontBold(size: 12)
                                                    
                                                    Text("\(coins)")
                                                        .FontRegular(size: 16)
                                                }
                                            }
                                        }
                                }
                                .cornerRadius(16)
                            
                            Spacer()
                            
                            ZStack(alignment: .topTrailing) {
                                Circle()
                                    .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 2)
                                    .overlay {
                                        Text("\(level)")
                                            .FontRegular(size: 16, color: .black)
                                    }
                                    .frame(width: 52, height: 52)
                                
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(Color(red: 199/255, green: 168/255, blue: 106/255))
                                    .offset(x: 2, y: -6)
                            }
                            
                            VStack {
                                HStack {
                                    VStack {
                                        Text("LEVEL")
                                            .FontBold(size: 12)
                                        
                                        Text("\(level)")
                                            .FontBold(size: 12)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("\(userDefaults.experience)/\(requiredExperience)")
                                            .FontRegular(size: 12, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                        
                                        Text("XP")
                                            .FontRegular(size: 12, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                    }
                                }
                                .padding(.horizontal, 10)
                                
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color(red: 29/255, green: 43/255, blue: 74/255))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.white, lineWidth: 2)
                                        }
                                        .frame(width: maxBarWidth, height: 8)
                                        .cornerRadius(10)
                                    
                                    Rectangle()
                                        .fill(Color.red)
                                        .frame(width: maxBarWidth * experienceProgress, height: 5)
                                        .cornerRadius(10)
                                        .shadow(color: .yellow, radius: 1, x: 2, y: 0)
                                        .padding(.horizontal, 1)
                                }
                            }
                            
                            Button(action:{
                                withAnimation(.easeInOut) {
                                    isSettings.toggle()
                                }
                            }) {
                                Image(.settings)
                                    .resizable()
                                    .frame(width: 52, height: 52)
                            }
                        }
                        .padding(.top, 80)
                        .padding(.horizontal, UIScreen.main.bounds.width > 470 ? 20 : 10)
                        
                        Rectangle()
                            .fill(.white)
                            .frame(height: 2)
                    }
                    
                    ZStack(alignment: .bottom) {
                        ZStack(alignment: .top) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 33/255, green: 25/255, blue: 80/255),
                                                              Color(red: 64/255, green: 15/255, blue: 119/255),
                                                              Color(red: 33/255, green: 25/255, blue: 80/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay {
                                    VStack(spacing: 6) {
                                        Image(.wisdom)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                        
                                        VStack(spacing: 5) {
                                            Text("Wisdom's\nAegis")
                                                .FontSemiBold(size: 20)
                                                .multilineTextAlignment(.center)
                                            
                                            Text("Wield the power of Zeus in\nthis epic slot adventure.\nLightning strikes bring\nlegendary wins!")
                                                .FontRegular(size: 17)
                                                .multilineTextAlignment(.center)
                                                .lineSpacing(6)
                                        }
                                        
                                        Button(action: {
                                            isWisdom = true
                                        }) {
                                            Rectangle()
                                                .fill(.clear)
                                                .frame(width: 162, height: 60)
                                                .overlay  {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
                                                        .overlay {
                                                            HStack {
                                                                Image(.energy)
                                                                    .resizable()
                                                                    .frame(width: 20, height: 20)
                                                                
                                                                Text("Play Now")
                                                                    .FontRegular(size: 16, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                                            }
                                                        }
                                                }
                                                .cornerRadius(16)
                                        }
                                        .padding(.top)
                                    }
                                }
                                .frame(height: 400)
                                .cornerRadius(32)
                                .padding(.horizontal)
                            
                            HStack {
                                Image(.angle)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                
                                Spacer()
                                
                                Image(.angle)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .scaleEffect(x: -1, y: 1)
                            }
                            .padding(.top)
                            .padding(.horizontal, 40)
                        }
                        
                        HStack {
                            Image(.angle)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .scaleEffect(x: 1, y: -1)
                            
                            Spacer()
                            
                            Image(.angle)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .scaleEffect(x: -1, y: -1)
                        }
                        .padding(.bottom)
                        .padding(.horizontal, 40)
                    }
                    
                    Text("ALL GAMES")
                        .FontSemiBold(size: 24, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                        .padding(.top)
                    
                    LazyVGrid(columns: grid, spacing: 25) {
                        ForEach(0..<7, id: \.self) { index in
                            Button(action: {
                                switch index {
                                case 0:
                                    isHeir = true
                                case 1:
                                    isOcean = true
                                case 2:
                                    isWisdom = true
                                case 3:
                                    isPact = true
                                case 4:
                                    isFateCoin = true
                                case 5:
                                    isWheel = true
                                case 6:
                                    isBolts = true
                                default:
                                    isHeir = true
                                }
                            }) {
                                Image("game\(index + 1)")
                                    .resizable()
                                    .frame(width: 159, height: 212)
                            }
                        }
                    }
                    
//                    Text("FEATURED EVENTS")
//                        .FontSemiBold(size: 24, color: Color(red: 119/255, green: 84/255, blue: 172/255))
//                        .padding(.top)
//                    
//                    Rectangle()
//                        .fill(.clear)
//                        .frame(height: 174)
//                        .overlay  {
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(Color(red: 121/255, green: 82/255, blue: 172/255), lineWidth: 3)
//                                .overlay {
//                                    HStack {
//                                        VStack(alignment: .leading, spacing: 12) {
//                                            Text("DAILY REWARD")
//                                                .FontBold(size: 12, color: Color(red: 199/255, green: 168/255, blue: 106/255))
//                                            
//                                            Text("Day 5 Bonus")
//                                                .FontRegular(size: 16)
//                                            
//                                            Text("Login today to claim 5,000 Obols!")
//                                                .FontRegular(size: 16)
//                                            
//                                            Button(action: {
//                                                
//                                            }) {
//                                                Rectangle()
//                                                    .fill(Color(red: 24/255, green: 29/255, blue: 53/255))
//                                                    .frame(width: 135, height: 44)
//                                                    .overlay  {
//                                                        RoundedRectangle(cornerRadius: 16)
//                                                            .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
//                                                            .overlay {
//                                                                Text("Claim reward!")
//                                                                    .FontRegular(size: 16)
//                                                            }
//                                                    }
//                                                    .cornerRadius(16)
//                                            }
//                                        }
//                                        .padding(.horizontal)
//                                        
//                                        Spacer()
//                                    }
//                                }
//                        }
//                        .cornerRadius(16)
//                        .padding(.horizontal)
//                    
//                    Rectangle()
//                        .fill(.clear)
//                        .frame(height: 174)
//                        .overlay  {
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(Color(red: 28/255, green: 126/255, blue: 118/255), lineWidth: 3)
//                                .overlay {
//                                    HStack {
//                                        VStack(alignment: .leading, spacing: 12) {
//                                            Text("LEADERBOARD")
//                                                .FontBold(size: 12, color: Color(red: 28/255, green: 126/255, blue: 118/255))
//                                            
//                                            Text("Weekly Challenge")
//                                                .FontRegular(size: 16)
//                                            
//                                            Text("Compete for the top spot and win big!")
//                                                .FontRegular(size: 16)
//                                            
//                                            HStack {
//                                                Text("Ends in 2d 14h")
//                                                    .FontRegular(size: 14)
//                                                
//                                                Spacer()
//                                                
//                                                Button(action: {
//                                                    
//                                                }) {
//                                                    Rectangle()
//                                                        .fill(Color(red: 24/255, green: 29/255, blue: 53/255))
//                                                        .frame(width: 135, height: 44)
//                                                        .overlay  {
//                                                            RoundedRectangle(cornerRadius: 16)
//                                                                .stroke(Color(red: 28/255, green: 126/255, blue: 118/255), lineWidth: 3)
//                                                                .overlay {
//                                                                    Text("View Ranks")
//                                                                        .FontRegular(size: 16)
//                                                                }
//                                                        }
//                                                        .cornerRadius(16)
//                                                }
//                                            }
//                                        }
//                                        .padding(.horizontal)
//                                        
//                                        Spacer()
//                                    }
//                                }
//                        }
//                        .cornerRadius(16)
//                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .blur(radius: isSettings ? 3 : 0)
                .transition(.opacity)
                
                if isSettings {
                    ZStack(alignment: .top) {
                        Color.black.opacity(0.7)
                        
                        VStack(spacing: 25) {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 1187)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 32)
                                        .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 3)
                                        .overlay {
                                            VStack(alignment: .leading, spacing: 22) {
                                                HStack {
                                                    Text("Settings")
                                                        .FontRegular(size: 16, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                                    
                                                    Spacer()
                                                    
                                                    Button(action: {
                                                        isSettings.toggle()
                                                    }) {
                                                        Image(.close)
                                                            .resizable()
                                                            .frame(width: 40, height: 40)
                                                    }
                                                }
                                                .padding(.horizontal, 40)
                                                
                                                Rectangle()
                                                    .fill(.white)
                                                    .frame(height: 2)
                                                
                                                Text("Audio")
                                                    .FontRegular(size: 16, color: Color(red: 119/255, green: 84/255, blue: 172/255))
                                                    .padding(.leading, 40)
                                                
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 140)
                                                    .overlay  {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 54/255, green: 77/255, blue: 125/255), lineWidth: 1)
                                                            .overlay {
                                                                VStack(alignment: .leading, spacing: 16) {
                                                                    HStack {
                                                                        Text("Sound Effects")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Spin sounds, wins, and UI\nfeedback")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Button(action: {
                                                                            viewModel.isSounds.toggle()
                                                                        }) {
                                                                            Circle()
                                                                                .fill(viewModel.isSounds ? Color(red: 199/255, green: 168/255, blue: 106/255) : .white)
                                                                                .frame(width: 24, height: 24)
                                                                        }
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Volume")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Text(viewModel.isSounds ? "On" : "Off")
                                                                            .FontRegular(size: 14)
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                    }
                                                    .padding(.horizontal, 40)
                                                
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 140)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 54/255, green: 77/255, blue: 125/255), lineWidth: 1)
                                                            .overlay {
                                                                VStack(alignment: .leading, spacing: 16) {
                                                                    HStack {
                                                                        Text("Background Music")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Ambient soundtrack")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Button(action: {
                                                                            viewModel.isOn.toggle()
                                                                        }) {
                                                                            Circle()
                                                                                .fill(viewModel.isOn ? Color(red: 199/255, green: 168/255, blue: 106/255) : .white)
                                                                                .frame(width: 24, height: 24)
                                                                        }
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Volume")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Text(viewModel.isOn ? "On" : "Off")
                                                                            .FontRegular(size: 14)
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                    }
                                                    .padding(.horizontal, 40)
                                                
                                                Text("Notifications")
                                                    .FontRegular(size: 16, color: Color(red: 119/255, green: 84/255, blue: 172/255))
                                                    .padding(.leading, 40)
                                                
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 97)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 54/255, green: 77/255, blue: 125/255), lineWidth: 1)
                                                            .overlay {
                                                                VStack(alignment: .leading, spacing: 16) {
                                                                    HStack {
                                                                        Text("Push Notifications")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Receive alerts about events\nand rewards")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Button(action: {
                                                                            viewModel.isNotifOn.toggle()
                                                                        }) {
                                                                            Circle()
                                                                                .fill(viewModel.isNotifOn ? Color(red: 199/255, green: 168/255, blue: 106/255) : .white)
                                                                                .frame(width: 24, height: 24)
                                                                        }
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                    }
                                                    .padding(.horizontal, 40)
                                                
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 97)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 54/255, green: 77/255, blue: 125/255), lineWidth: 1)
                                                            .overlay {
                                                                VStack(alignment: .leading, spacing: 16) {
                                                                    HStack {
                                                                        Text("Haptic Feedback")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Vibration on interactions\n(mobile only)")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                        
                                                                        Button(action: {
                                                                            viewModel.isVib.toggle()
                                                                        }) {
                                                                            Circle()
                                                                                .fill(viewModel.isVib ? Color(red: 199/255, green: 168/255, blue: 106/255) : .white)
                                                                                .frame(width: 24, height: 24)
                                                                        }
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                    }
                                                    .padding(.horizontal, 40)
                                                
                                                Text("Support")
                                                    .FontRegular(size: 16, color: Color(red: 119/255, green: 84/255, blue: 172/255))
                                                    .padding(.leading, 40)
                                                
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 77)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 54/255, green: 77/255, blue: 125/255), lineWidth: 1)
                                                            .overlay {
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    HStack {
                                                                        Text("Help Center")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("FAQs and guides")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                    }
                                                    .padding(.horizontal, 40)
                                                
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 77)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 54/255, green: 77/255, blue: 125/255), lineWidth: 1)
                                                            .overlay {
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    HStack {
                                                                        Text("Contact Support")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Get help from our team")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                    }
                                                    .padding(.horizontal, 40)
                                                
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 77)
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 54/255, green: 77/255, blue: 125/255), lineWidth: 1)
                                                            .overlay {
                                                                VStack(alignment: .leading, spacing: 10) {
                                                                    HStack {
                                                                        Text("About")
                                                                            .FontRegular(size: 16)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                    
                                                                    HStack {
                                                                        Text("Version 1.0.0 - Terms & Conditions")
                                                                            .FontRegular(size: 14)
                                                                        
                                                                        Spacer()
                                                                    }
                                                                }
                                                                .padding(.horizontal)
                                                            }
                                                    }
                                                    .padding(.horizontal, 40)
                                                
                                                Rectangle()
                                                    .fill(Color(red: 54/255, green: 77/255, blue: 125/255))
                                                    .frame(height: 2)
                                                    .padding(.horizontal, 40)
                                                
                                                Button(action: {
                                                    showingAlert = true
                                                }) {
                                                    Rectangle()
                                                        .fill(.clear)
                                                        .frame(height: 52)
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color(red: 251/255, green: 44/255, blue: 55/255).opacity(0.5), lineWidth: 1)
                                                                .overlay {
                                                                    Text("Reset data")
                                                                        .FontSemiBold(size: 16, color: Color(red: 251/255, green: 44/255, blue: 55/255).opacity(0.5))
                                                                }
                                                        }
                                                        .padding(.horizontal, 40)
                                                }
                                                .alert("Are you sure?", isPresented: $showingAlert) {
                                                         Button("Reset", role: .destructive) {
                                                             let manager = UserDefaultsManager.shared
                                                             manager.coins = 5000
                                                             manager.experience = 0
                                                             manager.level = 1
                                                             NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                                                         }
                                                         Button("Cancel", role: .cancel) { }
                                                     } message: {
                                                         Text("This action cannot be undone.")
                                                     }
                                            }
                                        }
                                }
                                .cornerRadius(32)
                                .padding(.horizontal)
                                .padding(.top, 80)
                        }
                    }
                    .transition(.opacity)
                    .zIndex(1)
                }
            }
            .padding(.top, -8)
            .padding(.bottom, -8)
            
        }
        .ignoresSafeArea()
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                self.coins = UserDefaultsManager.shared.coins
                self.level = UserDefaultsManager.shared.level
            }
            
            soundManager.playBackgroundMusic()
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: Notification.Name("RefreshData"), object: nil)
        }
        .fullScreenCover(isPresented: $isHeir) {
            ThunderHeirView()
        }
        .fullScreenCover(isPresented: $isOcean) {
            OceanOathView()
        }
        .fullScreenCover(isPresented: $isWisdom) {
            WisdomBooksView()
        }
        .fullScreenCover(isPresented: $isPact) {
            UnderworldPactView()
        }
        .fullScreenCover(isPresented: $isFateCoin) {
            FatesCoinsView()
        }
        .fullScreenCover(isPresented: $isWheel) {
            WheelOfLaurelsView()
        }
        .fullScreenCover(isPresented: $isBolts) {
            BoltDropView()
        }
    }
}

#Preview {
    WisdomMainView()
}
