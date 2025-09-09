using GadgetHub.Common;
using GadgetHub.DTOs;
using GadgetHub.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GadgetHub.DTOs.Quotation;

namespace GadgetHub.Services.Interfaces
{
    public interface IQuotationService
    {
        List<QuotationRequestDto> GetOrderItems(int userID);
        ServiceResult AddQuotation(quotation quotation, int userId);
        List<AcceptQuotationDto> GetAcceptedQuotation(int userId);
        ServiceResult OrderConfirmation(orderconfirmation obj, int userId);
    }
}
