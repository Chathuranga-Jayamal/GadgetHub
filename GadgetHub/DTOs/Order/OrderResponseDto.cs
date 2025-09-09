using System;
using System.Collections.Generic;
using GadgetHub.DTOs.Order;

namespace GadgetHub.DTOs
{
    public class OrderResponseDto
    {
        public int OrderId { get; set; }
        public DateTime OrderDate { get; set; }
        public string Status { get; set; }
        public decimal TotalAmount { get; set; }

        public List<OrderItemResponseDto> Items { get; set; } 
    }
}
