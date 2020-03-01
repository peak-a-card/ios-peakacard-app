import SwiftUI

struct CardView: View {
    var card: Card
    @Binding var isFlipped: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Stylesheet.color(.background))
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(Stylesheet.color(.primary)))

            if isFlipped {
                Text(card.text)
                    .fontWeight(.medium)
                    .font(Stylesheet.font(.h3))
                    .foregroundColor(Stylesheet.color(.primary))
                    .padding()
                    .lineLimit(.none)
                    .multilineTextAlignment(.center)
            } else {
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
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(id: .one), isFlipped: .constant(false))
    }
}
