import SwiftUI

struct CardView: View {
    var card: Card

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Stylesheet.color(.background))
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(Stylesheet.color(.primary)))

            Text(card.text)
                .fontWeight(.medium)
                .font(Stylesheet.font(.h3))
                .foregroundColor(Stylesheet.color(.primary))
                .padding()
                .lineLimit(.none)
                .multilineTextAlignment(.center)
        }
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(id: .one))
    }
}
