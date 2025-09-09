using GadgetHub.Repositories.Interfaces;
using GadgetHub.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GadgetHub.Models;
using GadgetHub.Common;
using MySqlX.XDevAPI.Common;

namespace GadgetHub.Services
{
    public class ProductService : IProductService
    {
        readonly IProductRepository _productRepository;

        // Constructor injection for the product repository
        public ProductService(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        }

        // GetProducts method retrieves all products from the repository
        public List<product> GetProducts()
        {
            List<product> products = _productRepository.GetAllProducts();
            return products;
        }

        public product GetProductById(int id)
        {
            product product = _productRepository.GetProductById(id);
            return product;
        }

        // AddProduct method adds a new product to the repository
        public ServiceResult AddProduct(product product)
        {
            if (product == null)
                return new ServiceResult { IsSuccess = false, Message = "Product not found" };

            product existingProduct = _productRepository.GetProductById(product.ProductID);

            if (existingProduct != null)
                return new ServiceResult { IsSuccess = false, Message = "Product already exists" };

            _productRepository.AddProduct(product);

            return new ServiceResult { IsSuccess = true, Message = "Product added successfully" };
        }

        // UpdateProduct method updates an existing product in the repository
        public ServiceResult UpdateProduct(product product)
        {
            if (product == null)
                return new ServiceResult { IsSuccess = false, Message = "Product not found" };

            product existingProduct = _productRepository.GetProductById(product.ProductID);

            if (existingProduct == null)
                return new ServiceResult { IsSuccess = false, Message = "Product does not exist" };

            _productRepository.UpdateProduct(product);

            return new ServiceResult { IsSuccess = true, Message = "Product updated successfully" };
        }

        // DeleteProduct method deletes a product from the repository by its ID
        public ServiceResult DeleteProduct (int id)
        {
            product product = _productRepository.GetProductById(id);

            if (product == null)
                return new ServiceResult { IsSuccess = false, Message = "Product not found" };

            _productRepository.DeleteProduct(id);

            return new ServiceResult { IsSuccess = true, Message = "Product deleted successfully" };
        }

    }
}