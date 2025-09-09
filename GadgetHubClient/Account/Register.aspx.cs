using GadgetHubClient.App_Code.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHubClient.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var newUser = new RegisterUserDto
                {
                    Name = Name.Text.Trim(),
                    Email = Email.Text.Trim(),
                    Password = Password.Text.Trim(),
                    Phone = Phone.Text.Trim(),
                    Address = Address.Text.Trim()
                };

                RegisterAsyncTask(new PageAsyncTask(async () =>{
                    bool success = await ApiClient.PostWithoutResponse("auth/register", newUser);

                    if (success)
                    {
                        Response.Redirect("~/Account/Login.aspx?registered=true");
                    }
                    else
                    {
                        FailureText.Text = "Registration failed. Please try again.";
                        ErrorMessage.Visible = true;
                    }                       
                }));
            }

        }
    }
}