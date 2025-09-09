using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GadgetHub.Models;

namespace GadgetHub.Repositories.Interfaces
{
    public interface IProductRepository
    {
        List<product> GetAllProducts();
        product GetProductById(int id);
        void AddProduct(product product);
        void UpdateProduct(product product);
        void DeleteProduct(int id);

    }
}
