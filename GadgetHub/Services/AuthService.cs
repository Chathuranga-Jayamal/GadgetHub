using GadgetHub.DTOs;
using GadgetHub.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GadgetHub.Common;
using GadgetHub.DTOs.Auth;
using System.Data.Entity.Infrastructure;
using GadgetHub.Repositories.Interfaces;
using Org.BouncyCastle.Crypto.Generators;
using GadgetHub.Models;

namespace GadgetHub.Services
{
    public class AuthService : IAuthService
    {
        private readonly IUserRepository _userRepository;
        public AuthService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }
        public ServiceResult RegisterCustomer(RegisterUserDto dto)
        {
            var existingUser = _userRepository.GetUserByEmail(dto.Email);
            
            if(existingUser != null)
                return new ServiceResult { IsSuccess = false, Message = "User with this email already exists" };

            
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(dto.Password); // Hash the password before saving

            var user = new user
            {
                Name = dto.Name,
                Email = dto.Email,
                Phone = dto.Phone,
                Password = hashedPassword, // Store the hashed password
                Role = "Customer" // Default role for new users
            };

            var customer = new customer
            {
                User = user,
                Address = dto.Address
            };

             _userRepository.AddCustomer(customer);// Add the new customer (and its related User) to the context

            System.Diagnostics.Debug.WriteLine($"[AuthService] RegisterCustomer called with data: {dto.Name}, {dto.Email}, {dto.Phone}, {dto.Address}");

            return new ServiceResult { IsSuccess = true};
        }

        public ServiceResult Login(LoginRequestDto dto)
        {
            var user = _userRepository.GetUserByEmail(dto.Email);

            if(user == null)
                return new ServiceResult { IsSuccess = false, Message = "User Not Exist" };

            if(!BCrypt.Net.BCrypt.Verify(dto.Password, user.Password)) // Verify the hashed password
                return new ServiceResult { IsSuccess = false, Message = "Invalid Password" };

            var token = JwtHelper.GenerateToken(user.Email, user.Role, user.UserID);

            return new ServiceResult { IsSuccess = true, Message = "Login Successful.", Data = token, UserID = user.UserID, UserRole = user.Role };
        }
    }
} 