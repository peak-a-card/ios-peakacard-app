import SwiftUI

struct CardBackView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Stylesheet.color(.background))
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(Stylesheet.color(.primary)))
            Rectangle()
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Stylesheet.color(.primary)))
                .padding(Stylesheet.margin(.medium))
            Image("Adevinta")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(Stylesheet.margin(.extraExtraLarge))
        }
    }
}

struct CardBackView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackView()
    }
}
