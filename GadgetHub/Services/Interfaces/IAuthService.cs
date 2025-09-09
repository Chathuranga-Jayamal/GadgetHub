using GadgetHub.DTOs.Auth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GadgetHub.Common;

namespace GadgetHub.Services.Interfaces
{
    public interface IAuthService
    {
        /// <summary>
        /// Registers a new customer.
        /// </summary>
        /// <returns> A ServiceResult indicating success or failure.</returns>
        ServiceResult RegisterCustomer(RegisterUserDto dto);

        /// <summary>
        /// Logs in a user.
        /// </summary>
        /// <returns> A ServiceResult containing the login status and user information.</returns>
        ServiceResult Login(LoginRequestDto dto);
    }
}

