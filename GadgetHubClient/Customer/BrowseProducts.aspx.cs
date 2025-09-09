using System;
using System.Web.UI;
using GadgetHubClient.App_Code.Models;
using System.Collections.Generic;

namespace GadgetHubClient.Customer
{
    public partial class BrowseProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!AuthHelper.IsLoggedIn())
            {
                Response.Redirect("~/Account/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                RegisterAsyncTask(new PageAsyncTask(async () =>
                {
                    var products = await ApiClient.GetAsync<List<ProductDto>>("products/all");
                    ProductRepeater.DataSource = products;
                    ProductRepeater.DataBind();
                }));
            }
        }

        protected void ProductRepeater_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                ShoppingCartHelper.AddItem(productId, 1); // Add one item
                StatusMessage.Text = "<p style='color:green;'>Item added to cart!</p>";
            }
        }
    }
}
