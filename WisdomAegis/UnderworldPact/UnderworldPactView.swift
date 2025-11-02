import SwiftUI

struct UnderworldPactView: View {
    @StateObject var viewModel =  UnderworldPactViewModel()
    @State var isPaytable = false
    @Environment(\.presentationMode) var presentationMode
    let symbolArray = [Symbol(image: "pact2", value: "500"),
                       Symbol(image: "pact3", value: "100"),
                       Symbol(image: "pact4", value: "50"),
                       Symbol(image: "pact5", value: "10"),
                       Symbol(image: "pact6", value: "5")]
    
    var body: some View {
        ZStack {
            Image(.linearBG)
                .resizable()
                .ignoresSafeArea()
            
            Image(.pactBG)
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(spacing: 15) {
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
                                                
                                                Text("\(viewModel.coin)")
                                                    .FontRegular(size: 16)
                                            }
                                            .padding(.trailing, 10)
                                        }
                                }
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        
                        Text("Underworld Pact")
                            .FontSemiBold(size: 20, color: Color(red: 255/255, green: 0/255, blue: 0/255))
                    }
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 334)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white, lineWidth: 3)
                                .overlay {
                                    VStack {
                                        ForEach(0..<3, id: \.self) { row in
                                            HStack(spacing: 0) {
                                                ForEach(0..<3, id: \.self) { col in
                                                    Rectangle()
                                                        .fill(.clear)
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 14)
                                                                .stroke(.white, lineWidth: 3)
                                                                .overlay(
                                                                    Image(viewModel.slots[row][col])
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 80, height: 80)
                                                                )
                                                        }
                                                        .frame(width: 96, height: 96)
                                                        .cornerRadius(14)
                                                        .padding(.horizontal, 5)
                                                        .shadow(
                                                            color: viewModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? .red : .clear,
                                                            radius: viewModel.isSpinning ? 0 : 25
                                                        )
                                                }
                                            }
                                        }
                                    }
                                }
                        }
                        .cornerRadius(16)
                        .padding(.horizontal)
                    
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
                                                if (viewModel.bet + 50) <= viewModel.coin {
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
                        .padding(.horizontal, 40)
                        .padding(.top, 15)
                    
                    Button(action: {
                        viewModel.spin()
                    }) {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 88)
                            .overlay  {
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(red: 255/255, green: 0/255, blue: 0/255), lineWidth: 5)
                                    .overlay {
                                        Text("SPIN")
                                            .FontRegular(size: 24, color: Color(red: 255/255, green: 0/255, blue: 0/255))
                                    }
                            }
                            .cornerRadius(50)
                            .padding(.horizontal, 40)
                            .padding(.top, 5)
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isPaytable.toggle()
                        }
                    }) {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 40)
                            .overlay  {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 134/255, green: 101/255, blue: 182/255), lineWidth: 4)
                                    .overlay {
                                        Text("Show Paytable")
                                            .FontSemiBold(size: 14)
                                    }
                            }
                            .cornerRadius(16)
                            .padding(.horizontal, 40)
                            .padding(.top, 5)
                    }
                }
            }
            .blur(radius: isPaytable ? 3 : 0)
            .transition(.opacity)
            
            if isPaytable {
                Color.black.opacity(0.7).ignoresSafeArea()
                
                Rectangle()
                    .fill(.clear)
                    .frame(height: 546)
                    .overlay {
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color(red: 255/255, green: 0/255, blue: 0/255), lineWidth: 3)
                            .overlay {
                                VStack(alignment: .leading, spacing: 22) {
                                    HStack {
                                        Text("Paytable")
                                            .FontRegular(size: 16, color: Color(red: 255/255, green: 0/255, blue: 0/255))
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            isPaytable.toggle()
                                        }) {
                                            Image(.close)
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                                    .padding(.horizontal, 40)
                                    
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(height: 176)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.white, lineWidth: 1)
                                                .overlay {
                                                    VStack {
                                                        HStack {
                                                            Text("SPECIAL SYMBOLS")
                                                                .FontBold(size: 12, color: Color(red: 255/255, green: 0/255, blue: 0/255))
                                                            
                                                            Spacer()
                                                        }
                                                        .padding(.horizontal)
                                                        
                                                        Image(.pact1)
                                                            .resizable()
                                                            .frame(width: 82, height: 95)
                                                        
                                                        Text("Substitutes\nall symbols")
                                                            .FontRegular(size: 14)
                                                    }
                                                }
                                        }
                                        .padding(.horizontal, 40)
                                    
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(height: 242)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.white, lineWidth: 1)
                                                .overlay {
                                                    VStack(alignment: .leading) {
                                                        HStack {
                                                            Text("SYMBOL PAYOUTS")
                                                                .FontBold(size: 12, color: Color(red: 255/255, green: 0/255, blue: 0/255))
                                                            
                                                            Spacer()
                                                        }
                                                        .padding(.horizontal)
                                                        
                                                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                                            ForEach(symbolArray, id: \.id) { item in
                                                                HStack {
                                                                    Image(item.image)
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 50, height: 60)
                                                                    
                                                                    Text("\(item.value)x")
                                                                        .FontRegular(size: 14)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                        }
                                        .padding(.horizontal, 40)
                                }
                            }
                    }
                    .cornerRadius(32)
                    .padding(.horizontal)
                    .padding(.top, 80)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    UnderworldPactView()
}

