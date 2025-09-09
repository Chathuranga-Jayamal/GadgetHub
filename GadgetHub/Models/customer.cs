using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GadgetHub.Models
{
    [Table("customer")]
    public class customer
    {
        [Key, ForeignKey("User")]
        public int CustomerID { get; set; }

        public string Address { get; set; }

        public virtual user User { get; set; }
    }
}
