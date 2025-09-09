using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GadgetHub.Models;
using GadgetHub.Data;
using System.IdentityModel.Tokens;
using System.Data.Entity.Migrations;
using GadgetHub.Repositories.Interfaces;

namespace GadgetHub.Repositories
{
    public class ProductRepository : IProductRepository
    {
        readonly GadgetHubDbContext _context;

        public ProductRepository(GadgetHubDbContext context)
        {
            _context = context;
        }

        public List<product> GetAllProducts()
        {
            return _context.Products.ToList();
        }

        public product GetProductById(int id)
        {
            return _context.Products.FirstOrDefault(p => p.ProductID == id);
        }

        public void AddProduct(product product)
        {
            try
            {
                _context.Products.Add(product);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new Exception("Database Product Adding Failed", ex);
            }
        }

        public void UpdateProduct(product product)
        {
            try
            {
                _context.Products.AddOrUpdate(product);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw new Exception("Database Product Update Failed", ex);
            }
        }

        public void DeleteProduct(int id)
        {
            try
            {
                product product = _context.Products.FirstOrDefault(p => p.ProductID == id);
                if (product != null)
                {
                    _context.Products.Remove(product);
                    _context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Database Product Deletion Failed", ex);
            }
        }
    }
}