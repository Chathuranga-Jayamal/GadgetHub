using GadgetHub.Common;
using GadgetHub.DTOs;
using GadgetHub.DTOs.Order;
using GadgetHub.Models;
using GadgetHub.Repositories.Interfaces;
using GadgetHub.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;

namespace GadgetHub.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [RoutePrefix("api/orders")]
    public class OrdersController : ApiController
    {
        readonly IOrderService _orderService;
        readonly IUserRepository _userRepository;

        public OrdersController(IOrderService orderService, IUserRepository userRepository)
        {
            _orderService = orderService;
            _userRepository = userRepository;
        }

        [Authorize(Roles = "Customer")]
        [HttpPost]
        [Route("place")]
        public IHttpActionResult CreateOrder(CreateOrderDto dto)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"[API] CreateOrder called with data: {dto.Items.Count} items");

                var identity = User.Identity as System.Security.Claims.ClaimsIdentity;
                var userIdClaim = identity?.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

                if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
                    return BadRequest("Invalid user identifier in token.");

                if (!ModelState.IsValid)
                    return BadRequest(ModelState);
                var order = new order
                {
                    OrderDate = DateTime.UtcNow,
                    Status = "Pending",
                    CustomerID = userId,
                    OrderItems = dto.Items.Select(item => new orderitem
                    {
                        ProductID = item.ProductId,
                        Quantity = item.Quantity,
                        UnitPrice = 0,
                        Status = "AwaitingQuote"
                    }).ToList(),
                };
                ServiceResult result = _orderService.NewOrder(order, userId);
                if (!result.IsSuccess)
                    return Content(System.Net.HttpStatusCode.Conflict, new { message = result.Message });

                return Ok(new { message = "Order added successfully" });
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[API] Error in CreateOrder: {ex.Message}");
                return InternalServerError(ex);
            }
        }

        [HttpGet]
        [Route("myorders")]
        public IHttpActionResult GetOrders()
        {
            try
            {
                var identity = User.Identity as System.Security.Claims.ClaimsIdentity;
                var userIdClaim = identity?.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

                if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
                    return BadRequest("Invalid user identifier in token.");

                List<OrderResponseDto> orders = _orderService.GetOrders(userId);

                if (orders == null || orders.Count == 0)
                    return NotFound();

                return Ok(orders);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        [HttpGet]
        [Route("{orderId:int}")]
        public IHttpActionResult GetOrderById(int orderId)
        {
            try
            {
                var identity = User.Identity as System.Security.Claims.ClaimsIdentity;
                var userIdClaim = identity?.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

                if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
                    return BadRequest("Invalid user identifier in token.");

                OrderResponseDto order = _orderService.GetOrderById(orderId, userId);
                if (order == null)
                    return NotFound();
                return Ok(order);
            }
            catch
            {
                return InternalServerError();
            }
        }
    }
}