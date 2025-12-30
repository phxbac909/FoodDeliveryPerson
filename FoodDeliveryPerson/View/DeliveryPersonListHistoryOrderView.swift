//
//  DeliveryPersonListHistoryOrder.swift
//  FoodDeliveryPerson
//
//  Created by TTC on 30/12/25.
//

import SwiftUI

struct DeliveryPersonListHistoryOrderView: View {
    @StateObject var viewModel = ShopListOrderViewModel()
    private var user = UserData.shared.user
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false){
                        tabOrder
                            .onChange(of: viewModel.selectedTab) { oldValue, newValue in
                                withAnimation {
                                    proxy.scrollTo(newValue, anchor: .center)
                                }
                        }
                    }
                }
                TabView(selection: $viewModel.selectedTab) {
                    ForEach(viewModel.tab, id: \.self) { statusTitle in
                        contentView(for: statusTitle)
                            .tag(statusTitle)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationTitle("Order History")
        }
        .onAppear{
            Task{
                await viewModel.loadOrder(shopId: user?.id ?? -1)
            }
        }
    }
    
    // Content cho mỗi tab
    @ViewBuilder
    private func contentView(for statusTitle: String) -> some View {
        let filteredOrders = viewModel.orders.filter { $0.status.title == statusTitle }
        
        ZStack {
            if filteredOrders.isEmpty {
                VStack{
                    Spacer()
                    emptyCart
                    Spacer()
                }
                .ignoresSafeArea()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(filteredOrders.sorted(by: {$0.id ?? 0 > $1.id ?? 0})) { order in
                            ShopOrderView(order: .constant(order))
                        }
                    }
                }
                .background(Color.gray.opacity(0.04))
            }
        }
    }
    
    private var emptyCart : some View {
        VStack {
            Image("empty-cart")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            Text("You have not order any food yet !")
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .bold()
                .padding()
        }
    }
    
    private var tabOrder : some View {
        HStack {
            HStack(spacing: 30){
                ForEach(viewModel.tab, id: \.self) { statusTitle in
                    VStack{
                        Button{
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.selectedTab = statusTitle
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Text(statusTitle)
                                    .font(.system(size: statusTitle == viewModel.selectedTab ? 16.5 : 16))
                                    .fontWeight(statusTitle == viewModel.selectedTab ? .bold : .regular)
                                    .foregroundColor(statusTitle != viewModel.selectedTab ? .secondary : Color.brandPrimaryColor)
                                
                                if let badgeColor = getStatusBadgeColor(for: statusTitle) {
                                    let count = getOrderCount(for: statusTitle)
                                        BadgeView(
                                            count: count,
                                            color: badgeColor
                                    )
                                    
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        .overlay(
                            Rectangle()
                                .frame(height: 2.5)
                                .foregroundColor(statusTitle != viewModel.selectedTab ? .white.opacity(0) : Color.brandPrimaryColor)
                                .animation(.easeInOut(duration: 0.2), value: viewModel.selectedTab)
                            , alignment: .bottom
                        )
                        .id(statusTitle)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    // Lấy số lượng orders cho status
    private func getOrderCount(for statusTitle: String) -> Int {
        viewModel.totalOrders.filter { $0.status.title == statusTitle }.count
    }
    
    // Lấy badge color từ enum OrderStatus
    private func getStatusBadgeColor(for statusTitle: String) -> Color? {
        OrderStatus.allCases.first { $0.title == statusTitle }?.badgeColor
    }
}

#Preview {
    DeliveryPersonListHistoryOrderView()
}
