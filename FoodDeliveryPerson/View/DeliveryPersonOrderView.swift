import SwiftUI

// MARK: - DeliveryPersonOrderView
struct DeliveryPersonOrderView: View {
    let order: OrderDto
    @ObservedObject var viewModel = DeliveryPersonOrderViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Order ID
            HStack {
                Text("Order #\(order.id ?? 0)")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "point.topright.arrow.triangle.backward.to.point.bottomleft.filled.scurvepath")
                        .font(.caption)
                    Text(order.shop.distance)
                        .font(.title2)
                }
                .foregroundColor(.blue)
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Label("Shop", systemImage: "storefront.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(order.shop.name)
                    .font(.body)
                    .fontWeight(.medium)
                
                Spacer()
                Image(systemName: "map.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(order.shop.address)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
          
            Divider()

            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Label("Customer", systemImage: "person.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(order.customer.fullName)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
           
            
            
            // Shop Info
        
            // Action Buttons
            HStack(spacing: 12) {
                if !(order.status == .CANCELED || order.status == .DONE) {
                    Button(action: {
                        Task{
                            await viewModel.updateOrderStatus(id: order.id ?? 0, status: .CANCELED)
                        }
                    }) {
                        Text("Cancel")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                
                if (order.status == .CONFIRMED){
                    Button(action: {
                        Task{
                            await viewModel.assginOrderToDeliveryPerson(id: order.id ?? -1, deliveryPersonId: UserData.shared.user?.id ?? -1)
                        }
                    }) {
                        Text("Ship")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                if (order.status == .SHIPPING){
                    Button(action: {
                        Task{
                            await viewModel.updateOrderStatus(id: order.id ?? 0, status: .SHIP_SUCCESS)
                        }
                    }) {
                        Text("Ship Success !")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }

            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview
struct DeliveryPersonOrderView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryPersonOrderView(
            order: OrderDto(
                id: 1,
                customer: OrderDto.Customer(id: 1, fullName: "HaiNgonese"),
                shop: OrderDto.Shop(id: 1, name: "Ramua", distance: "4.5 km", address: "120 Yen Lang"),
                items: [],
                time: 0,
                status: .SHIPPING,
                rating: 0
            ),
            viewModel: DeliveryPersonOrderViewModel()
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
