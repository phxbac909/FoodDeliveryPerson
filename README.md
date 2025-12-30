# Food Delivery Full-stack Ecosystem 🍔🚴‍♂️

A comprehensive, real-time food delivery system featuring a synchronized environment across four specialized platforms. This project demonstrates the integration of mobile clients with a robust backend to handle the complete order lifecycle.

---

## 📱 System Components & Repositories

The ecosystem consists of **4 separate repositories**:

* **[Customer App (iOS)](https://github.com/phxbac909/FoodDeliveryCustomer)**: Allows users to browse menus, place orders, and track delivery status in real-time.
* **[Shop Management App (iOS)](https://github.com/phxbac909/FoodDeliveryShop)**: Empowers merchants to manage inventory (CRUD), receive orders, and update preparation status.
* **[Delivery Person App (iOS)](https://github.com/phxbac909/FoodDeliveryPerson)**: Enables drivers to accept delivery requests and update real-time location/status.
* **[Centralized Backend (Spring Boot)](https://github.com/phxbac909/FoodDeliveryServer)**: The core engine managing REST APIs, WebSocket connections, and database persistence.

---

## 🛠 Tech Stack

- **Mobile:** Swift, Auto Layout (Responsive for iPhone & iPad).
- **Backend:** Java Spring Boot, MySQL.
- **Real-time:** WebSockets for instant status synchronization.
- **Communication:** RESTful APIs, JSON.
- **Version Control:** Git.

---

## 🚀 Key Features

- **Cross-Platform Sync:** Real-time data synchronization between Customer, Shop, and Driver apps.
- **Live Order Tracking:** Users can see the exact status of their food via WebSocket-powered updates.
- **Instant Alerts:** Push notifications for "New Order," "Order Accepted," and "Out for Delivery" events.
- **Merchant Dashboard:** Complete inventory management (CRUD) and sales statistics for shop owners.
- **Responsive UI:** Optimized layouts ensuring a seamless experience across all iOS device sizes.

---

## 🏗 System Architecture

```mermaid
graph TD
    A[Customer iOS App] <-->|REST / WebSocket| D(Spring Boot Backend)
    B[Shop iOS App] <-->|REST / WebSocket| D
    C[Driver iOS App] <-->|REST / WebSocket| D
    D <--> E[(MySQL Database)]
    F --> A
    F --> B
    F --> C
