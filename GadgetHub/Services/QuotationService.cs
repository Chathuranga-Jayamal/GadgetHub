using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GadgetHub.Models;
using GadgetHub.Services.Interfaces;
using GadgetHub.Common;
using GadgetHub.Repositories.Interfaces;
using GadgetHub.DTOs.Quotation;
using System.Threading.Tasks;

namespace GadgetHub.Services
{
    public class QuotationService : IQuotationService
    {
        readonly IQuotationRepository _quotationRepository;
        readonly IUserRepository _userRepository;
        readonly IOrderRepository _orderRepository;

        public QuotationService(IQuotationRepository quotationRepository, IUserRepository userRepository, IOrderRepository orderRepository)
        {
            _quotationRepository = quotationRepository;
            _userRepository = userRepository;
            _orderRepository = orderRepository;
        }

        //GetOrderItems method retrieves all order items with AwaitingQuote status from the repository
        public List<QuotationRequestDto> GetOrderItems(int userID)
        {
            List<QuotationRequestDto> orderItems = _quotationRepository.GetOrderItems(userID);

            if (orderItems == null)
                return new List<QuotationRequestDto>();

            return orderItems;
        }

        //AddQuotation method adds a new quotation to the repository
        public ServiceResult AddQuotation(quotation quotation, int userId)
        {
            if (quotation == null)
                return new ServiceResult { IsSuccess = false, Message = "Quotation not found" };

            user user = _userRepository.GetUserById(userId);

            if (user == null)
                return new ServiceResult { IsSuccess = false, Message = "User not found" };

            quotation existingQuotation = _quotationRepository.GetQuotationById(quotation.QuotationID);

            if (existingQuotation != null)
                return new ServiceResult { IsSuccess = false, Message = "Quotation already exists" };

            _quotationRepository.AddQuotation(quotation);

            bool result = SelectQuotation(quotation.OrderItemID); // Automatically select the best quotation after adding

            if (result)
                return new ServiceResult { IsSuccess = true, Message = "Quotation added and selected successfully" };
            else
                return new ServiceResult { IsSuccess = true, Message = "Quotation added successfully" };
        }

        public List<AcceptQuotationDto> GetAcceptedQuotation(int userId)
        {
            System.Diagnostics.Debug.WriteLine($"[Service] GetAcceptedQuotation called for User ID: {userId}");

            if (userId <= 0)
                throw new Exception("Invalid User ID");
            user user = _userRepository.GetUserById(userId);
            if (user == null)
                throw new Exception("User not found");
            List<AcceptQuotationDto> quotations = _quotationRepository.GetAcceptedQuotations(userId);
            return quotations;
        }

        public ServiceResult OrderConfirmation(orderconfirmation obj, int userId)
        {
            if (obj == null)
                return new ServiceResult { IsSuccess = false, Message = "Order Confirmation not found" };
            user user = _userRepository.GetUserById(userId);
            if (user == null)
                return new ServiceResult { IsSuccess = false, Message = "User not found" };
            orderconfirmation existingOrderConfirmation = _quotationRepository.GetOrderConfirmationById(obj.ConfirmedID);
            if (existingOrderConfirmation != null)
                return new ServiceResult { IsSuccess = false, Message = "Order Confirmation already exists" };
            _quotationRepository.AddOrderConfirmation(obj);

            // Update the OrderItem & Order status to "Confirmed"
            quotation quotation  = _quotationRepository.GetQuotationById(obj.QuotationID);
            
            _orderRepository.MarkOrderItemAsConfirmed(quotation);

            return new ServiceResult { IsSuccess = true, Message = "Order Confirmation added successfully" };
        }

        public bool SelectQuotation(int orderItemId)
        {
            List<quotation> quotations = _quotationRepository.GetQuotationsByOrderItem(orderItemId);

            if (quotations == null || quotations.Count == 0)
                return false;

            int NumberOfDistributors = _userRepository.CountOfDistributors();

            System.Diagnostics.Debug.WriteLine($"[Service] Number of distributors: {NumberOfDistributors}");

            if (quotations.Count != NumberOfDistributors)
                return false;
            
            var availableQuotation = quotations
                .Where(q => q.IsAvailable)
                .OrderBy(q => q.PricePerUnit)
                .ToList();

            if (availableQuotation.Count == 0)
                return false;

            quotation bestQuotation = availableQuotation.FirstOrDefault();

            System.Diagnostics.Debug.WriteLine($"[Service] Best Quotation ID: {bestQuotation.QuotationID}, Price: {bestQuotation.PricePerUnit}");

            bool result = _quotationRepository.MarkQuatationAsSelected(bestQuotation.QuotationID);
            if (!result)
                return false;

            if (result)
                _quotationRepository.UpdateOrderItem(bestQuotation.OrderItemID, bestQuotation.PricePerUnit);
            return result;
        }
    }    
}