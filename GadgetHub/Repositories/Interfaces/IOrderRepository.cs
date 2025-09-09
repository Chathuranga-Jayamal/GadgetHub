using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GadgetHub.DTOs;
using GadgetHub.Models;

namespace GadgetHub.Repositories.Interfaces
{
    public interface IOrderRepository
    {
        void AddOrder(order order);
        List<OrderResponseDto> GetOrders(int userId);
        OrderResponseDto GetOrderById(int orderId, int userId);
        void MarkOrderItemAsConfirmed(quotation obj);
    }
}
