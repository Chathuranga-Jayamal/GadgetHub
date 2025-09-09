using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHubClient.App_Code.Models
{
    // Used when creating a new order
    public class CreateOrderDto
    {
        public List<CreateOrderItemDto> Items { get; set; }
    }

    public class CreateOrderItemDto
    {
        public int ProductID { get; set; }
        public int Quantity { get; set; }
    }

    // Used when retrieving order details from the API
    public class OrderDto
    {
        public int OrderID { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string Status { get; set; }
        public int CustomerID { get; set; }
        public List<OrderItemDto> OrderItems { get; set; }
    }

    public class OrderItemDto
    {
        public int OrderItemID { get; set; }
        public int ProductID { get; set; }
        public string ProductName { get; set; } 
        public int Quantity { get; set; }
        public decimal UnitPrice { get; set; }
        public string Status { get; set; }
    }

}