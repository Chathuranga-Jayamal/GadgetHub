using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace GadgetHub.Models
{
    [Table("product")]
    public class product
    {
        [Key]
        public int ProductID { get; set; }

        [StringLength(100)]
        public string Name { get; set; }

        [StringLength(50)]
        public string Category { get; set; }

        public string Description { get; set; }
    }
}
