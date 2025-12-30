// MARK: - Empty Order View
struct EmptyOrderView:  View {
   var body : some View {
       VStack {
           Image(systemName: "tray")
               .resizable()
               .scaledToFit()
               .frame(width: 100, height: 100)
               .foregroundColor(.gray.opacity(0.5))
           Text("No orders yet!")
               .font(.title3)
               .foregroundStyle(.secondary)
               .bold()
               .padding()
       }
    }
}