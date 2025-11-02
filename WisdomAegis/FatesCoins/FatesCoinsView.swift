import SwiftUI

struct FatesCoinsView: View {
    @StateObject var viewModel =  FatesCoinsViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var isTail = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 70/255, green: 25/255, blue: 14/255),
                                    Color(red: 116/255, green: 62/255, blue: 14/255),
                                    Color(red: 70/255, green: 25/255, blue: 14/255)], startPoint: .top, endPoint: .bottom) .ignoresSafeArea()
            
            Image(.fateCoinBG)
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
                        
                        Text("Fate's Coin")
                            .FontRegular(size: 16, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                        
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
                
                Image(viewModel.rotationStep % 2 == 0 ? .heads : .tail)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .rotation3DEffect(
                        .degrees(Double(viewModel.rotationStep) * 360.0 / 2),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .animation(.easeInOut(duration: 0.1), value: viewModel.rotationStep)
                    .padding(.top)
                
                HStack(spacing: 20) {
                    Button(action: {
                        withAnimation {
                            isTail = false
                        }
                    }) {
                        Rectangle()
                            .fill(.clear)
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(isTail ? .white : Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: isTail ? 2 : 3)
                                    .overlay {
                                        VStack(spacing: 8) {
                                            Text("👑")
                                            
                                            Text("Heads")
                                                .FontRegular(size: 18, color: isTail ? .white : Color(red: 199/255, green: 168/255, blue: 106/255))
                                        }
                                    }
                            }
                            .frame(height: 128)
                            .shadow(color: isTail ? .clear : Color(red: 199/255, green: 168/255, blue: 106/255), radius: 4)
                    }
                    
                    Button(action: {
                        withAnimation {
                            isTail = true
                        }
                    }) {
                        Rectangle()
                            .fill(.clear)
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(!isTail ? .white : Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: !isTail ? 2 : 3)
                                    .overlay {
                                        VStack(spacing: 8) {
                                            Text("⚡")
                                            
                                            Text("Tails")
                                                .FontRegular(size: 18, color: !isTail ? .white : Color(red: 199/255, green: 168/255, blue: 106/255))
                                        }
                                    }
                            }
                            .frame(height: 128)
                            .shadow(color: !isTail ? .clear : Color(red: 199/255, green: 168/255, blue: 106/255), radius: 4)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
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
                        viewModel.startFlip(userChoice: isTail)
                       }
                }) {
                    Rectangle()
                        .fill(.clear)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 199/255, green: 168/255, blue: 106/255), lineWidth: 2)
                                .overlay {
                                    Text("Flip Coin - \(viewModel.bet) Obols")
                                        .FontSemiBold(size: 17, color: Color(red: 199/255, green: 168/255, blue: 106/255))
                                }
                        }
                        .frame(height: 64)
                        .padding(.horizontal)
                        .padding(.top, 15)
                }
                
                Text("Win: 2x your bet • Payout: \(viewModel.bet * 2) Obols")
                    .FontRegular(size: 14, color: Color(red: 246/255, green: 245/255, blue: 243/255))
                    .padding(.top, 15)
            }
        }
    }
}

#Preview {
    FatesCoinsView()
}

