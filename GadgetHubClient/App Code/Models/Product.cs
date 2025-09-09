using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHubClient.App_Code.Models
{
    public class ProductDto
    {
        public int ProductID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
    }
}