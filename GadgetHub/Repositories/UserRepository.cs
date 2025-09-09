using GadgetHub.Data;
using GadgetHub.Models;
using GadgetHub.Repositories.Interfaces;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace GadgetHub.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly GadgetHubDbContext _context;

        public UserRepository(GadgetHubDbContext context)
        {
            _context = context;
        }

        public user GetUserByEmail(string email)
        {
            return _context.Users.FirstOrDefault(u => u.Email == email);
        }

        public user GetUserById(int userId)
        {
            return _context.Users.FirstOrDefault(u => u.UserID == userId);
        }

        public void AddCustomer(customer customer)
        {
            try
            {
                _context.Customers.Add(customer);//Add the new customer (and its related User) to the context

                _context.SaveChanges();
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Database Error while adding customer",ex.ToString());
                throw new Exception("Database Error while adding customer", ex);
            }
        }

        public int CountOfDistributors()
        {
            return _context.Users.Count(u => u.Role == "Distributor");
        }
    }
}