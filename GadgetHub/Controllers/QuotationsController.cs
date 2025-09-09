using GadgetHub.Common;
using GadgetHub.DTOs.Quotation;
using GadgetHub.Models;
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
    [RoutePrefix("api/quotations")]
    public class QuotationsController : ApiController
    {
        private readonly IQuotationService _quotationService;

        public QuotationsController(IQuotationService quotationService)
        {
            _quotationService = quotationService;
        }

       // [Authorize(Roles = "Distributor")]
        [HttpGet]
        [Route("requests")]
        public IHttpActionResult GetOrderItems()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("[API] GetOrderItems called");

                var identity = User.Identity as System.Security.Claims.ClaimsIdentity;
                var userIdClaim = identity?.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

                if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
                    return BadRequest("Invalid user identifier in token.");

                List<QuotationRequestDto> orderItems = _quotationService.GetOrderItems(userId);

                if (orderItems == null || orderItems.Count == 0)
                    return NotFound();

                return Ok(orderItems);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

      //  [Authorize(Roles = "Distributor")]
        [HttpPost]
        [Route("add")]
        public IHttpActionResult AddQuotation(QuotationDto dto)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("[API] AddQuotation called with data: " + dto.OrderItemID);

                var identity = User.Identity as System.Security.Claims.ClaimsIdentity;
                var userIdClaim = identity?.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

                if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
                    return BadRequest("Invalid user identifier in token.");

                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                var quotation = new quotation
                {
                    OrderItemID = dto.OrderItemID,
                    PricePerUnit = dto.PricePerUnit,
                    IsAvailable = dto.IsAvailable,
                    AvailableUnits = dto.AvailableUnits,
                    EstimatedDeliveryDate = dto.EstimatedDeliveryDate,
                    DistributorID = userId,
                    Status = "Pending"
                };

                ServiceResult result = _quotationService.AddQuotation(quotation, userId);

                if (!result.IsSuccess)
                    return Content(System.Net.HttpStatusCode.Conflict, new { message = result.Message });

                return Ok(new { message = "Quotation added successfully" });
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

       // [Authorize(Roles = "Distributor")]
        [HttpGet]
        [Route("accepted")]
        public IHttpActionResult GetAcceptedQuotations()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("[API] GetAcceptedQuotations called");

                var identity = User.Identity as System.Security.Claims.ClaimsIdentity;
                var userIdClaim = identity?.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

                if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
                    return BadRequest("Invalid user identifier in token.");

                List<AcceptQuotationDto> quotations = _quotationService.GetAcceptedQuotation(userId);

                if (quotations == null || quotations.Count == 0)
                    return NotFound();

                return Ok(quotations);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

      //  [Authorize(Roles = "Distributor")]
        [HttpPost]
        [Route("confirm")]
        public IHttpActionResult ConfirmOrder(ConfirmOrderDto dto)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("[API] ConfirmOrder called with data: " + dto.QuotationID);

                var identity = User.Identity as System.Security.Claims.ClaimsIdentity;
                var userIdClaim = identity?.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

                if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out int userId))
                    return BadRequest("Invalid user identifier in token.");

                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                var orderConfirmation = new orderconfirmation
                {
                    QuotationID = dto.QuotationID,
                    DistributorOrderID = dto.DistributorOrderID,
                    ConfirmedAt = DateTime.UtcNow
                };

                ServiceResult result = _quotationService.OrderConfirmation(orderConfirmation, userId);

                if (!result.IsSuccess)
                    return Content(System.Net.HttpStatusCode.Conflict, new { message = result.Message });

                return Ok(new { message = "Order confirmed successfully" });
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }
    }
}