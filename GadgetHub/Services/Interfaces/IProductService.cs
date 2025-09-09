using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GadgetHub.Common;
using GadgetHub.Models;

namespace GadgetHub.Services.Interfaces
{
    public interface IProductService
    {
        List<product> GetProducts();
        product GetProductById(int id);

        ServiceResult AddProduct(product product);

        ServiceResult UpdateProduct(product product);

        ServiceResult DeleteProduct(int id);


    }
}
