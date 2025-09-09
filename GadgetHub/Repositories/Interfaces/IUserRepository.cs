using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GadgetHub.Models;

namespace GadgetHub.Repositories.Interfaces
{
    public interface IUserRepository
    {
        /// <summary>
        /// This method retrieves a user by their email address.
        /// </summary>
        /// <param name="email"></param>
        /// <returns> User object if found, otherwise null. </returns>
        user GetUserByEmail(string email);

        /// <summary>
        /// This method registers a new customer in the system.
        /// </summary>
        /// /// <param name="customer">The customer object containing registration details.</param>
        void AddCustomer(customer customer);

        user GetUserById(int userId);
        int CountOfDistributors();
    }
}
