import SwiftUI

/// 말풍선 모양의 툴팁 path
struct TooltipBubble: Shape {
    var cornerRadius: CGFloat = 8
    var tailSize: CGFloat = 8
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let bodyRect = CGRect(
            x: rect.minX,
            y: rect.minY,
            width: rect.width,
            height: rect.height - tailSize
        )
        path.addRoundedRect(
            in: bodyRect,
            cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        path.move(to: CGPoint(x: rect.midX - tailSize, y: bodyRect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: bodyRect.maxY + tailSize))
        path.addLine(to: CGPoint(x: rect.midX + tailSize, y: bodyRect.maxY))
        
        path.closeSubpath()
        return path
    }
}

public struct TooltipModifier: ViewModifier {
    @State private var isPresented = false
    let text: String
    let backgroundColor: Color
    let textColor: Color
    
    private let tailSize: CGFloat = 8
    private let verticalGap: CGFloat = 20
    
    public func body(content: Content) -> some View {
        content
            .overlay(tooltipOverlay, alignment: .top)
            .onTapGesture {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                    isPresented.toggle()
                }
            }
    }
    
    private var tooltipOverlay: some View {
        Group {
            if isPresented {
                Text(text)
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(textColor)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .padding(.bottom, tailSize / 2) // extra space below text so it sits in bubble centre
                    .background(
                        TooltipBubble(tailSize: tailSize)
                            .fill(backgroundColor)
                    )
                    .fixedSize() // bubble size == text size
                    .shadow(color: .black.opacity(0.2),
                            radius: 6, x: 0, y: 4)
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
                    .offset(y: -(verticalGap + tailSize / 2)) // lift above anchor
            }
        }
    }
}

public extension View {
    func tooltip(_ text: String,
                 backgroundColor: Color = Color(red: 0.15, green: 0.15, blue: 0.15),
                 textColor: Color = .white) -> some View
    {
        modifier(
            TooltipModifier(
                text: text,
                backgroundColor: backgroundColor,
                textColor: textColor
            )
        )
    }
}
