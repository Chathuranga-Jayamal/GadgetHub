using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GadgetHubClient.App_Code.Models
{
    //For sending registration data to the server
    public class RegisterUserDto
    {
        public string Name { get; set; }    
        public string Email { get; set; }
        public string Password { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
    }

    //For sending login data to the server
    public class LoginUserDto
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }

    //For the response after login
    public class LoginResponseDto
    {
        public string Token { get; set; }
        public string UserType { get; set; }
        public string Email { get; set; }
        public int UserId { get; set; }
    }
}