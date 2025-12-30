import SwiftUI

struct DeliveryPersonListHistoryOrderView: View {
    
    @StateObject var viewModel = DeliveryPersonListHistoryOrderViewModel()
    @State private var selectedTab: String = OrderStatus.DONE.title
    private let tabs = [OrderStatus.DONE.title, OrderStatus.CANCELED.title]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                tabBar
                
                TabView(selection: $selectedTab) {
                    listDoneOrderView
                        .tag(OrderStatus.DONE.title)
                    
                    listCanceledOrderView
                        .tag(OrderStatus.CANCELED.title)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .onAppear{
                Task{
                    await viewModel.loadListOrder()
                }
            }
            .navigationTitle("Order History")
        }
    }
    
    // MARK: - List Done Order View
    private var listDoneOrderView: some View {
        ZStack {
            if viewModel.doneOrder.isEmpty {
                emptyOrderView
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.doneOrder.sorted(by: { $0.id ?? 0 > $1.id ?? 0 })) { order in
                            DeliveryPersonOrderView(order: order, viewModel: DeliveryPersonOrderViewModel())
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.04))
            }
        }
    }
    
    // MARK: - List Canceled Order View
    private var listCanceledOrderView: some View {
        ZStack {
            if viewModel.cancelOrder.isEmpty {
                emptyOrderView
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.cancelOrder.sorted(by: { $0.id ?? 0 > $1.id ?? 0 })) { order in
                            DeliveryPersonOrderView(order: order, viewModel: DeliveryPersonOrderViewModel())
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.04))
            }
        }
    }
    
    // MARK: - Empty Order View
    private var emptyOrderView: some View {
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
    
    private var tabBar: some View {
        HStack(spacing: 30) {
            ForEach(tabs, id: \.self) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 0) {
                        Text(tab)
                            .font(.system(size: tab == selectedTab ? 16.5 : 16))
                            .fontWeight(tab == selectedTab ? .bold : .regular)
                            .foregroundColor(tab == selectedTab ? .brandPrimaryColor : .secondary)
                            .padding(.vertical, 10)
                        
                        Rectangle()
                            .frame(height: 2.5)
                            .foregroundColor(tab == selectedTab ? .brandPrimaryColor : .clear)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}



// MARK: - Preview
#Preview {
    DeliveryPersonListHistoryOrderView()
}
