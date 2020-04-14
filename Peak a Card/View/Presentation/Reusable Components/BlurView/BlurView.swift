import SwiftUI

struct BlurView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)

        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<BlurView>) {}
}
