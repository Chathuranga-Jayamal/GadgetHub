using GadgetHub.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GadgetHub.Models;
using GadgetHub.Common;
using GadgetHub.Repositories.Interfaces;
using GadgetHub.DTOs;

namespace GadgetHub.Services
{
    public class OrderService : IOrderService
    {
        readonly IOrderRepository _orderRepository;
        readonly IUserRepository _userRepository;

        // Constructor initializes the user repository and order repository
        public OrderService(IOrderRepository orderRepository, IUserRepository userRepository)
        {
            _orderRepository = orderRepository;
            _userRepository = userRepository;
        }

        // NewOrder method adds a new order to the repository
        public ServiceResult NewOrder(order order, int userId)
        {
            if (order == null)
                return new ServiceResult { IsSuccess = false, Message = "Order not found" };

            user user = _userRepository.GetUserById(userId);

            if (user == null)
                return new ServiceResult { IsSuccess = false, Message = "User not found" };

            OrderResponseDto existingOrder = _orderRepository.GetOrderById(order.OrderID, userId);
            if (existingOrder != null)
                return new ServiceResult { IsSuccess = false, Message = "Order already exists" };

            _orderRepository.AddOrder(order);
            return new ServiceResult { IsSuccess = true, Message = "Order added successfully" };
        }

        // GetOrders method retrieves all orders from the repository
        public List<OrderResponseDto> GetOrders(int userId)
        {
            if (userId<=0)
                throw new Exception("Invalid User ID");

            user user = _userRepository.GetUserById(userId);

            if (user == null)
                throw new Exception("User not found");

            List<OrderResponseDto> orders = _orderRepository.GetOrders(userId);
            return orders;
        }

        // GetOrderById method retrieves a specific order by its ID
        public OrderResponseDto GetOrderById(int orderId, int userId)
        {
            if (orderId <= 0)
                throw new Exception("Invalid Order ID");

            user user = _userRepository.GetUserById(userId);

            if (user == null)
                throw new Exception("User not found");

            OrderResponseDto order = _orderRepository.GetOrderById(orderId, userId);
            return order;
        }
    }
}