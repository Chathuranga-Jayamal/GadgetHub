using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHub.DTOs.Order
{
    public class OrderItemResponseDto
    {
        public int OrderItemId { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int Quantity { get; set; }

        public decimal? UnitPrice { get; set; } // Added
        public string Status { get; set; }
    }

}