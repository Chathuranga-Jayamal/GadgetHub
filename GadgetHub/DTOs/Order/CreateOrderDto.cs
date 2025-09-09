using System.Collections.Generic;

namespace GadgetHub.DTOs
{
    public class CreateOrderDto
    {
        public List<OrderItemDto> Items { get; set; }

        public CreateOrderDto()
        {
            Items = new List<OrderItemDto>();
        }
    }

    public class OrderItemDto
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; }
    }
}
