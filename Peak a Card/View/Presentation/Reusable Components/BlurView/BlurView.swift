import SwiftUI

struct BlurView: UIViewRepresentable {

    @Environment (\.colorScheme) var colorScheme: ColorScheme

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView {
        let style: UIBlurEffect.Style = colorScheme == .light ?
            .dark :
            .light
        print(style.rawValue)
        let effect = UIBlurEffect(style: style)
        let view = UIVisualEffectView(effect: effect)

        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<BlurView>) {}
}
