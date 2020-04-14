import SwiftUI

struct LoadingView: View {
    @State var isAnimating = true
    var body: some View {
        ZStack {
            BlurView().cornerRadius(8.0)
            VStack {
                ActivityIndicator(isAnimating: $isAnimating, style: .large, color: Stylesheet.color(.background))
                Text("common_loading_title")
                    .foregroundColor(Stylesheet.color(.onPrimary))
                    .padding(.top, Stylesheet.margin(.medium))
            }
        }.frame(width: 110, height: 110)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
