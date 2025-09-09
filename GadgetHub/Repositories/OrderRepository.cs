using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GadgetHub.Models;
using GadgetHub.Repositories.Interfaces;
using GadgetHub.Data;
using System.Data.Entity;
using GadgetHub.DTOs.Order;
using GadgetHub.DTOs;
using System.Runtime.Remoting.Contexts;

namespace GadgetHub.Repositories
{
    public class OrderRepository : IOrderRepository
    {
        readonly GadgetHubDbContext _context;

        public OrderRepository(GadgetHubDbContext context)
        {
            _context = context;
        }

        public void AddOrder(order order)
        {
            try
            {
                _context.Orders.Add(order);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new Exception("Database Error while adding order", ex);
            }
        }

        public List<OrderResponseDto> GetOrders(int userId)
        {
            try
            {
                var orders = _context.Orders
                    .Where(o => o.CustomerID == userId)
                    .Include(o => o.OrderItems.Select(oi => oi.Product))
                    .Select(o => new OrderResponseDto
                    {
                        OrderId = o.OrderID,
                        OrderDate = o.OrderDate,
                        Status = o.Status,
                        TotalAmount = o.TotalAmount,
                        Items = o.OrderItems.Select(oi => new OrderItemResponseDto
                        {
                            OrderItemId = oi.OrderItemID,
                            ProductId = oi.ProductID,
                            ProductName = oi.Product.Name,
                            Quantity = oi.Quantity,
                            UnitPrice = oi.UnitPrice,
                            Status = oi.Status,
                        }).ToList()
                    }).ToList();

                return orders;

            }
            catch (Exception ex)
            {
                throw new Exception("Database Error while retrieving user's orders", ex);
            }
        }

        public OrderResponseDto GetOrderById(int orderId, int userId)
        {
            try
            {
                var order = _context.Orders
                    .Where(o => o.OrderID == orderId && o.CustomerID == userId)
                    .Include(o => o.OrderItems.Select(oi => oi.Product))
                    .Select(o => new OrderResponseDto
                    {
                        OrderId = o.OrderID,
                        OrderDate = o.OrderDate,
                        Status = o.Status,
                        TotalAmount = o.TotalAmount,
                        Items = o.OrderItems.Select(oi => new OrderItemResponseDto
                        {
                            OrderItemId = oi.OrderItemID,
                            ProductId = oi.ProductID,
                            ProductName = oi.Product.Name,
                            Quantity = oi.Quantity,
                            UnitPrice = oi.UnitPrice,
                            Status = oi.Status,
                        }).ToList()
                    });

                return order.FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw new Exception("Database Error while retrieving order by ID", ex);
            }
        }

        public void MarkOrderItemAsConfirmed(quotation obj)
        {
            try
            {
                var orderItem = _context.OrderItems
                    .Include("Order.OrderItems")
                    .FirstOrDefault(oi => oi.OrderItemID == obj.OrderItemID);

                if (orderItem == null)
                    throw new Exception("Order item not found");

                orderItem.Status = "Confirmed";

                var order = orderItem.Order;

                if (order == null)
                    throw new Exception("Order not found");

                bool allConfirmed = order.OrderItems.All(oi => oi.Status == "Confirmed");

                if (allConfirmed)
                {
                    order.Status = "Confirmed";
                    order.TotalAmount = order.OrderItems.Sum(oi => (oi.UnitPrice ?? 0) * oi.Quantity);
                }

                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[Repository] Error in MarkOrderItemAsConfirmed: {ex.Message}");
                throw new Exception("Database Error while marking order item as confirmed", ex);
            }
        }

    }
}