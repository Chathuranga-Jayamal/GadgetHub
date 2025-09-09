using GadgetHubClient.App_Code;
using GadgetHubClient.App_Code.Models;
using System;
using System.Web;
using System.Web.UI;

namespace GadgetHubClient.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Show User redirected from registration
            if (!IsPostBack && Request.QueryString["RegistrationSuccess"] == "true")
            {
                SuccessMessage.Visible = true;
            }
        }

        protected void LogIn_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var loginRequest = new LoginUserDto
                {
                    Email = Email.Text.Trim(),
                    Password = Password.Text.Trim(),
                };

                RegisterAsyncTask(new PageAsyncTask(async () =>
                {
                    var loginResponse = await ApiClient.PostAsync<LoginResponseDto>("auth/login", loginRequest);

                    if (loginResponse != null && !string.IsNullOrEmpty(loginResponse.Token))
                    {
                        // Store token and userId in cookies
                        AuthHelper.SetAuthCookies(loginResponse.Token, loginResponse.UserId, loginResponse.UserType);

                        // Redirect user based on role
                        switch (loginResponse.UserType)
                        {
                            case "Admin":
                                Response.Redirect("~/Admin/Dashboard.aspx");
                                break;
                            case "Distributor":
                                Response.Redirect("~/Distributor/QuotationRequests.aspx");
                                break;
                            case "Customer":
                                Response.Redirect("~/Customer/BrowseProducts.aspx");
                                break;
                            default:
                                Response.Redirect("~/Default.aspx");
                                break;
                        }
                    }
                    else
                    {
                        FailureText.Text = "Invalid login attempt. Please check your email and password.";
                        ErrorMessage.Visible = true;
                    }
                }));
            }
        }
    }
}
