import SwiftUI

extension Text {
    func FontRegular(size: CGFloat,
                     color: Color = .white)  -> some View {
        self.font(.custom("SFProText-Regular", size: size))
            .foregroundColor(color)
    }
    
    func FontMedium(size: CGFloat,
                    color: Color = .white)  -> some View {
        self.font(.custom("SFProText-Medium", size: size))
            .foregroundColor(color)
    }
    
    func FontSemiBold(size: CGFloat,
                   color: Color = .white)  -> some View {
        self.font(.custom("SFProText-Semibold", size: size))
            .foregroundColor(color)
    }
    
    func FontBold(size: CGFloat,
                   color: Color = .white)  -> some View {
        self.font(.custom("SFProText-Semibold", size: size))
            .foregroundColor(color)
    }
    
    func FontHeavy(size: CGFloat,
                   color: Color = .white)  -> some View {
        self.font(.custom("SFProText-Heavy", size: size))
            .foregroundColor(color)
    }
    
    func FontLight(size: CGFloat,
                   color: Color = .white)  -> some View {
        self.font(.custom("SFProText-Light", size: size))
            .foregroundColor(color)
    }
}
