using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GadgetHub.Models
{
    [Table("distributor")]
    public class distributor
    {
        [Key, ForeignKey("User")]
        public int DistributorID { get; set; }

        [StringLength(255)]
        public string ApiEndpoint { get; set; }

        public virtual user User { get; set; }
    }
}
