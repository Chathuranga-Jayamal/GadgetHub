using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GadgetHub.Models
{
    [Table("quotation")]
    public class quotation
    {
        [Key]
        public int QuotationID { get; set; }

        public int OrderItemID { get; set; }
        [ForeignKey("OrderItemID")]
        public virtual orderitem OrderItem { get; set; }

        public int DistributorID { get; set; }
        [ForeignKey("DistributorID")]
        public virtual distributor Distributor { get; set; }

        public decimal PricePerUnit { get; set; }

        public bool IsAvailable { get; set; }

        public int AvailableUnits { get; set; }

        public DateTime? EstimatedDeliveryDate { get; set; }

        public string Status { get; set; }
    }
}
