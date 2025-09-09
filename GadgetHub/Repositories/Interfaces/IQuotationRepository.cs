using GadgetHub.DTOs.Quotation;
using GadgetHub.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GadgetHub.Repositories.Interfaces
{
    public interface IQuotationRepository
    {
        List<QuotationRequestDto> GetOrderItems(int userID);
        quotation GetQuotationById(int quotationId);
        void AddQuotation(quotation quotation);
        List<AcceptQuotationDto> GetAcceptedQuotations(int userId);
        orderconfirmation GetOrderConfirmationById(int confiremID);
        void AddOrderConfirmation(orderconfirmation orderConfirmation);
        List<quotation>GetQuotationsByOrderItem(int orderItemId);
        bool MarkQuatationAsSelected(int quotationId);
        void UpdateOrderItem(int orderItemID, decimal unitPrice);


    }
}
