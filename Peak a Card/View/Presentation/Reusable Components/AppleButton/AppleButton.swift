import SwiftUI

struct AppleButton: View {

    var body: some View {
        Button(action: {
            // Do something
        }) {
            HStack {
                Image("AppleIcon")
                    .foregroundColor(.white)
                Text("join_session_sign_in_with_Apple")
                    .font(Stylesheet.font(.m))
                    .foregroundColor(Color.white)
            }.frame(maxWidth: .infinity)
        }
        .padding(Stylesheet.margin(.medium))
        .background(Color.black)
        .cornerRadius(8.0)
    }
}
