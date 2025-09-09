using GadgetHub.Common;
using GadgetHub.DTOs.Product;
using GadgetHub.Models;
using GadgetHub.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.ModelBinding;

namespace GadgetHub.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [RoutePrefix("api/products")]
    public class ProductsController : ApiController
    {
        readonly IProductService _productService;

        public ProductsController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet]
        [Route("all")]
        public IHttpActionResult GetAllProducts()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("[API] GetAllProducts called");

                List<product> products = _productService.GetProducts();

                if (products == null || products.Count == 0)
                    return NotFound(); // Return 404 Not Found if no products are found

                return Ok(products); // Return 200 OK with the list of products
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[API] Error in GetAllProducts: {ex.Message}");
                return InternalServerError(ex); // Return 500 Internal Server Error for unexpected exceptions
            }
        }

        [HttpGet]
        [Route("product/{id:int}")]
        public IHttpActionResult GetProductById(int id)
        {
            try
            {
                product product = _productService.GetProductById(id);
                if (product == null)
                    return NotFound(); // Return 404 Not Found if the product does not exist
                return Ok(product); // Return 200 OK with the product details
            }
            catch (Exception ex)
            {
                return InternalServerError(ex); // Return 500 Internal Server Error for unexpected exceptions
            }
        }

        [HttpPost]
        [Route("product")]
        public IHttpActionResult AddProduct(ProductDto dto)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState); // Return 400 Bad Request if the model state is invalid

                product product = new product
                {
                    ProductID = dto.ProductID,
                    Name = dto.Name,
                    Category = dto.Category,
                    Description = dto.Description,
                };

                ServiceResult result = _productService.AddProduct(product);

                if (!result.IsSuccess) 
                    return Content(System.Net.HttpStatusCode.Conflict, new { message = result.Message }); //return 409 Conflict with an error message

                return Ok(new { message = "Product added successfully" }); // Return 200 OK with a success message
            }
            catch (Exception ex)
            {
                return InternalServerError(ex); // Return 500 Internal Server Error for unexpected exceptions
            }
        }

        [HttpPut]
        [Route("product")]
        public IHttpActionResult UpdateProduct(ProductDto dto)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState); // Return 400 Bad Request if the model state is invalid
                product product = new product
                {
                    ProductID = dto.ProductID,
                    Name = dto.Name,
                    Category = dto.Category,
                    Description = dto.Description,
                };
                ServiceResult result = _productService.UpdateProduct(product);
                if (!result.IsSuccess) 
                    return Content(System.Net.HttpStatusCode.Conflict, new { message = result.Message }); //return 409 Conflict with an error message
                return Ok(new { message = "Product updated successfully" }); // Return 200 OK with a success message
            }
            catch (Exception ex)
            {
                return InternalServerError(ex); // Return 500 Internal Server Error for unexpected exceptions
            }
        }

        [HttpDelete]
        [Route("product/{id:int}")]
        public IHttpActionResult DeleteProduct(int id)
        {
            try
            {
                ServiceResult result = _productService.DeleteProduct(id);
                if (!result.IsSuccess)
                    return Content(System.Net.HttpStatusCode.Conflict, new { message = result.Message }); //return 409 Conflict with an error message
                return Ok(new { message = "Product deleted successfully" }); // Return 200 OK with a success message
            }
            catch (Exception ex)
            {
                return InternalServerError(ex); // Return 500 Internal Server Error for unexpected exceptions
            }
        }
    }
}