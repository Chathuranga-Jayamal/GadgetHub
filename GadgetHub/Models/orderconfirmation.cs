using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GadgetHub.Models
{
    [Table("orderconfirmation")]
    public class orderconfirmation
    {
        [Key]
        public int ConfirmedID { get; set; }

        public int QuotationID { get; set; }
        [ForeignKey("QuotationID")]
        public virtual quotation Quotation { get; set; }

        [StringLength(100)]
        public string DistributorOrderID { get; set; }

        public DateTime? ConfirmedAt { get; set; }
    }
}
