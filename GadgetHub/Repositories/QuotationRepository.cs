using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GadgetHub.Repositories.Interfaces;
using GadgetHub.Data;
using GadgetHub.Models;
using GadgetHub.DTOs.Quotation;

namespace GadgetHub.Repositories
{
    public class QuotationRepository : IQuotationRepository
    {
        private readonly GadgetHubDbContext _context;

        public QuotationRepository(GadgetHubDbContext context)
        {
            _context = context;
        }

        //Get all order items with AwaitingQuote status
        public List<QuotationRequestDto> GetOrderItems(int userID)
        {
            try
            {
                var quotationReqOrderItems = _context.OrderItems
                .Where(oi => oi.Status == "AwaitingQuote"
                && !_context.Quotations
                .Any(q => q.OrderItemID == oi.OrderItemID
                    && q.DistributorID == userID))
                .Select(oi => new QuotationRequestDto
                {
                    OrderItemID = oi.OrderItemID,
                    ProductID = oi.ProductID,
                    Quantity = oi.Quantity,
                    ProductName = oi.Product.Name,
                    OrderDate = oi.Order.OrderDate
                })
                .ToList();


                if (quotationReqOrderItems == null)
                    return new List<QuotationRequestDto>();

                return quotationReqOrderItems;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[Repository] Error in GetOrderItems: {ex.Message}");
                return new List<QuotationRequestDto>();
            }
        }

        //Get quotation by QuotationID
        public quotation GetQuotationById(int quotationId)
        {
            return _context.Quotations.FirstOrDefault(q => q.QuotationID == quotationId);
        }

        //Add a new quotation to the database
        public void AddQuotation(quotation quotation)
        {
            if (quotation == null)
                throw new ArgumentNullException(nameof(quotation), "Quotation cannot be null");
            try
            {
                _context.Quotations.Add(quotation);
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[Repository] Error in AddQuotation: {ex.Message}");
                throw new Exception("Database Error while adding quotation", ex);
            }
        }

        //Get all accepted quotations for a specific distributor
        public List<AcceptQuotationDto> GetAcceptedQuotations(int userID)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"[Repository] GetAcceptQuotations called for User ID: {userID}");

                var acceptedQuotations = _context.Quotations
                    .Where(q => q.DistributorID == userID && q.Status == "Accepted")
                    .Select(q => new AcceptQuotationDto
                    {
                        QuotationID = q.QuotationID,
                        OrderItemID = q.OrderItemID,
                        ProductID = q.OrderItem.ProductID,
                        ProductName = q.OrderItem.Product.Name,
                        Quantity = q.AvailableUnits,
                        PricePerUnit = q.PricePerUnit,
                        OrderDate = q.EstimatedDeliveryDate ?? DateTime.MinValue

                    })
                    .ToList();

                System.Diagnostics.Debug.WriteLine($"[Repository] Found {acceptedQuotations.Count} accepted quotations for User ID: {userID}");

                if (acceptedQuotations == null || acceptedQuotations.Count == 0)
                    throw new Exception("No accepted quotations found for the distributor");

                return acceptedQuotations;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[Repository] Error in GetAcceptQuotations: {ex.Message}");
                throw new Exception("Error retrieving accepted quotations", ex);
            }
        }

        //Add order confirmation to the quotation
        public void AddOrderConfirmation(orderconfirmation orderconfirmation)
        {
            if (orderconfirmation == null)
                throw new ArgumentNullException(nameof(orderconfirmation), "Order confirmation cannot be null");
            try
            {
                _context.OrderConfirmations.Add(orderconfirmation);
                _context.Quotations.Where(q => q.QuotationID == orderconfirmation.QuotationID)
                    .ToList()
                    .ForEach(q => q.Status = "Confirmed");
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[Repository] Error in AddOrderConfirmation: {ex.Message}");
                throw new Exception("Database Error while adding order confirmation", ex);
            }
        }

        //Get order confirmation by ID
        public orderconfirmation GetOrderConfirmationById(int id)
        {
            return _context.OrderConfirmations.FirstOrDefault(oc => oc.ConfirmedID == id);
        }

        //Get quotations by OrderItemID

        public List<quotation> GetQuotationsByOrderItem(int orderItemId)
        {
            return _context.Quotations
                .Where(q => q.OrderItemID == orderItemId)
                .ToList();
        }

        //Mark quotation as selected
        public bool MarkQuatationAsSelected(int quotationId)
        {
            try
            {
                var quotation = _context.Quotations.FirstOrDefault(q => q.QuotationID == quotationId);
                if (quotation == null)
                    throw new Exception("Quotation not found");
                quotation.Status = "Accepted";
                _context.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[Repository] Error in MarkQuotationAsSelected: {ex.Message}");
                throw new Exception("Error marking quotation as selected", ex);
            }
        }

        public void UpdateOrderItem(int orderItemID, decimal unitPrice)
        {
            try
            {
                var orderItem = _context.OrderItems.FirstOrDefault(oi => oi.OrderItemID == orderItemID);

                if (orderItem == null)
                    throw new Exception("Order item not found");

                orderItem.Status = "Quoted";
                orderItem.UnitPrice = unitPrice;
                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[Repository] Error in MarkOrderItemAsQueted: {ex.Message}");
                throw new Exception("Error marking order item as quoted", ex);
            }
        }
    }
}