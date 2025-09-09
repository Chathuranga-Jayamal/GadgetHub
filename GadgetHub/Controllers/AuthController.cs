using GadgetHub.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using GadgetHub.DTOs.Auth;
using GadgetHub.Common;
using Mysqlx;
using GadgetHub.Models;
using System.Threading.Tasks;
using System.Diagnostics;

using System.Web.Http.Cors;

namespace GadgetHub.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    [RoutePrefix("api/auth")]
    public class AuthController : ApiController
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        /// <summary>
        /// Registers a new customer using the provided registration data.
        /// </summary>
        /// <param name="dto">The registration data for the new user.</param>
        /// <returns>
        /// Returns 200 OK with a success message if registration is successful.
        /// Returns 409 Conflict with an error message if registration fails due to a conflict.
        /// Returns 400 Bad Request if the model state is invalid.
        /// </returns>
        [HttpPost]
        [Route("register")]
        [AllowAnonymous]
        public IHttpActionResult Register(RegisterUserDto dto)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"[API] Register called with data: {dto.Name}, {dto.Email}, {dto.Phone}, {dto.Address}, {dto.Password}");

                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                ServiceResult result = _authService.RegisterCustomer(dto);

                if (!result.IsSuccess)
                    return Content(System.Net.HttpStatusCode.Conflict, new { message = result.Message }); // Use Content with HttpStatusCode.Conflict to return a custom object

                return Ok(new { message = "User registered successfully"});
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"[AuthController] Registration error?",ex.ToString());
                return InternalServerError(ex); // Return 500 Internal Server Error for unexpected exceptions
            }
        }

        /// <summary>
        /// Login user using the provided login credentials.
        /// </summary>
        /// <param name="dto"></param>
        /// <returns>
        /// Returns 200 OK with a success message if login is successful.
        /// Returns 401 Unauthorized if login fails.
        /// eturns 400 Bad Request if the model state is invalid.
        /// </returns>
        [HttpPost]
        [Route("login")]
        [AllowAnonymous]
        public IHttpActionResult Login(LoginRequestDto dto)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"[API] Login called with data:  {dto.Email}, {dto.Password}");


                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                ServiceResult result = _authService.Login(dto);

                if (!result.IsSuccess)
                    return Content(System.Net.HttpStatusCode.Unauthorized, new { message = result.Message }); // Use Content with HttpStatusCode.Unauthorized to return a custom object
                
                Debug.WriteLine($"[API] Login successful, token: {result.Data}, UserID: {result.UserID}");
                return Ok(new { Token = result.Data, UserType = result.UserRole, UserId = result.UserID });
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.ToString());
                return InternalServerError(ex);
            }

        }
    }
}