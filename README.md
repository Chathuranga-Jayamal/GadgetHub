# GadgetHub

# GadgetHub - A Service-Oriented E-commerce Web Application

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![.NET Framework](https://img.shields.io/badge/.NET-4.7.2-blue)
![MySQL](https://img.shields.io/badge/Database-MySQL-green)
![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey)

## 📦 Project Overview

**GadgetHub** is a service-oriented web application that functions as a digital marketplace for electronic gadgets. Unlike traditional e-commerce platforms, GadgetHub does not maintain its own inventory. Instead, it collaborates with multiple distributors (e.g., TechWorld, ElectroCom, Gadget Central) to fulfill customer orders.

The platform automatically fetches quotations from distributors, compares them, and selects the best option for the customer. The entire architecture follows a **Service-Oriented Architecture (SOA)** approach to ensure high scalability, modularity, and fault tolerance.

---

## 🛠️ Technologies Used

| Component            | Technology               |
|---------------------|--------------------------|
| Language            | C#                       |
| Backend             | ASP.NET Web API (.NET 4.7.2) |
| Frontend            | ASP.NET Web Forms        |
| Database            | MySQL                    |
| Authentication      | JWT                      |
| IDE                 | Visual Studio 2022       |
| Version Control     | Git & GitHub             |

---

## 🌐 System Architecture

This system consists of independent services:

- **Authentication Service** – Handles JWT-based login and registration.
- **Product Service** – Manages product CRUD operations.
- **Order Service** – Handles customer orders and order items.
- **Quotation Service** – Manages distributor quotations and confirmations.

> 📌 Each service follows RESTful principles and can be deployed independently.

---

## 💻 Features

### Customer
- Register and log in with JWT
- Browse and search products
- Add products to cart and place orders
- View order status and history

### Distributor
- View quotation requests
- Submit quotations
- Confirm orders if their quotation is selected

### Admin
- Manage products (CRUD)
- Manage distributor accounts

---

## 🔒 Security

- JWT for all API authentication
- Passwords stored with **bcrypt**
- Role-based access for Customers, Distributors, and Admin

---
