using GadgetHub.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GadgetHub.Models;
using GadgetHub.DTOs;


namespace GadgetHub.Services.Interfaces
{
    public interface IOrderService
    {
        ServiceResult NewOrder(order order, int userId);
        List<OrderResponseDto> GetOrders(int userId);
        OrderResponseDto GetOrderById(int orderId, int userId);
    }
}
