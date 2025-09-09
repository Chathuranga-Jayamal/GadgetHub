using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GadgetHub.Models
{
    [Table("orderitem")]
    public class orderitem
    {
        [Key]
        public int OrderItemID { get; set; }

        public int OrderID { get; set; }
        [ForeignKey("OrderID")]
        public virtual order Order { get; set; }

        public int ProductID { get; set; }
        [ForeignKey("ProductID")]
        public virtual product Product { get; set; }

        public int Quantity { get; set; }

        public decimal? UnitPrice { get; set; }

        public string Status { get; set; }
    }
}
