import SwiftUI

struct DeliveryPersonAccountView: View {
    var body: some View {
        Button{
            UserData.shared.clear()
        } label: {
            Text("Log out \(UserData.shared.user?.id ) ")
        }
    }
}

#Preview {
    ShopAccountView()
}
