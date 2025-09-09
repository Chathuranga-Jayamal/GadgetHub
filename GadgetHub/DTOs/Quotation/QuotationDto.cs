using System;
using System.IdentityModel.Tokens;

namespace GadgetHub.DTOs.Quotation
{
    public class QuotationRequestDto
    {
        public int OrderItemID { get; set; }
        public int ProductID { get; set; }
        public int Quantity { get; set; }
        public string ProductName { get; set; }
        public DateTime OrderDate { get; set; }
    }

    public class QuotationDto
    {
        public bool IsAvailable { get; set; }
        public int OrderItemID { get; set; }
        public int AvailableUnits { get; set; }
        public decimal PricePerUnit { get; set; }
        public DateTime EstimatedDeliveryDate { get; set; }
    }

    public class AcceptQuotationDto
    {
        public int QuotationID { get; set; }
        public int OrderItemID { get; set; }
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public decimal PricePerUnit { get; set; }
        public DateTime OrderDate { get; set; }
    }

    public class ConfirmOrderDto
    {
        public int QuotationID { get; set; }
        public DateTime ConfirmAt { get; set; }
        public string DistributorOrderID { get; set; }
    }
}
