import SwiftUI

struct Card: View {
    var number: String

    var body: some View {
        ZStack {
            Rectangle()
            .foregroundColor(Stylesheet.color(.background))
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(Stylesheet.color(.primary)))

            Text(number)
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
        Card(number: "1")
    }
}
