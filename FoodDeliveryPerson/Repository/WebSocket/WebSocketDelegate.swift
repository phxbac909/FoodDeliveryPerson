//import SwiftUI
//import Combine
//import Starscream
//

//class WebSocketManager: ObservableObject {
//    
//    public static let shared = WebSocketManager()    
//    @Published var orderUpdates: [OrderUpdateStatus] = []
//    private var socket: WebSocket!
//    
//    init() {
//        setupWebSocket()
//    }
//    
//    private func setupWebSocket() {
//        guard let url = URL(string: "ws://192.168.0.100:8080/ws") else { return }
//        socket = WebSocket(request: URLRequest(url: url))
//        socket.delegate = self
//        socket.connect()
//    }
//    
//    func disconnect() {
//        socket.disconnect()
//    }
//    // Hàm tạo frame STOMP CONNECT
//        private func sendConnectFrame() {
//            let connectFrame = """
//            CONNECT
//            accept-version:1.0,1.1,1.2
//            heart-beat:10000,10000
//
//            \0
//            """
//            socket.write(string: connectFrame)
//        }
//        
//        // Hàm tạo frame STOMP SUBSCRIBE
//        private func sendSubscribeFrame() {
//            let subscribeFrame = """
//            SUBSCRIBE
//            id:sub-0
//            destination:/topic/orderStatus
//
//            \0
//            """
//            socket.write(string: subscribeFrame)
//        }
//}
//
//extension WebSocketManager: WebSocketDelegate {
//    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
//        switch event {
//        case .connected(_):
//            print("WebSocket Connected")
//            sendConnectFrame()
//        case .text(let string):
//            print(string)
//            if string.contains("CONNECTED") {
//                print("STOMP Connected, sending SUBSCRIBE")
//                sendSubscribeFrame()
//            }
//            else
//              if string.contains("MESSAGE"){
//                if let range = string.range(of: #"\{.*\}"#, options: .regularExpression) {
//                    if let data = string[range].data(using: .utf8) {
//                            do {
//                                let decoder = JSONDecoder()
//                                let update = try decoder.decode(OrderUpdateStatus.self, from: data)
//                                DispatchQueue.main.async {
////                                    self.orderUpdates.append(update)
//                                    let userInfo: [String: OrderUpdateStatus] = ["updatedOrder": update]
//                                    NotificationCenter.default.post(name: .orderUpdated, object: nil, userInfo: userInfo)
//                                }
//                            } catch {
//                                print("Error decoding message: \(error)")
//                            }
//                        }
//                    }
//                }
//        case .disconnected(_, _):
//            print("WebSocket Disconnected")
//            
//        case .error(let error):
//            print("WebSocket Error: \(error?.localizedDescription ?? "Unknown error")")
//            
//        default:
//            break
//        }
//    }
//}
//
//class StatusViewModel : ObservableObject {
//    
//    @Published var orders : [OrderDto] = []
//    private var cancellables = Set<AnyCancellable>()
//    
//    init()  {
//        Task{
//            await getOrdersByCustomer(customerId: 1)
//        }
//        NotificationCenter.default.publisher(for: .orderUpdated)
//                    .sink { [weak self] notification in
//                        // Lấy updatedOrder từ userInfo (nếu cần)
//                        if let updatedOrder = notification.userInfo?["updatedOrder"] as? OrderUpdateStatus {
//                            if let index = self?.orders.firstIndex(where: { $0.id == updatedOrder.id }){
//                                self?.orders[index].status = updatedOrder.status
//                            }
//                        }
//                    }
//                    .store(in: &cancellables)
//    }
//    func getOrdersByCustomer(customerId : Int64) async {
//        let orderClient = OrderAPIClient()
//        
//        do {
//            let fetchOrders = try await orderClient.getOrdersByCustomerId(customerId)
//            orders.removeAll()
//            self.orders.append(contentsOf: fetchOrders)
//        } catch APIError.noContent {
//            print("No orders found for customer")
//
//        } catch {
//            print("Error: \(error)")
//        }
//    }
//
//}
//struct StatusView: View {
//    
//    @StateObject var viewModel = StatusViewModel()
//    
//    var body: some View {
//        NavigationView {
//            List(viewModel.orders) { update in
//                VStack(alignment: .leading) {
//                    Text("Order: \(update.id)")
//                        .font(.headline)
//                    Text("Status: \(update.status)")
//                }
//                .padding(.vertical, 4)
//            }
//            .navigationTitle("Order Updates")
//        }
//        .onDisappear {
////            webSocketManager.disconnect()
//        }
//    }
//}
//
//// Add Starscream dependency in Package.swift
//// .package(url: "https://github.com/daltoniam/Starscream.git", from: "4.0.4")
//#Preview {
//    StatusView()
//}
