using System;
using System.Web.UI;
using GadgetHubClient.App_Code.Models;

namespace GadgetHubClient.Customer
{
    public partial class OrderDetails : System.Web.UI.Page
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
                if (int.TryParse(Request.QueryString["OrderID"], out int orderId))
                {
                    RegisterAsyncTask(new PageAsyncTask(async () =>
                    {
                        var order = await ApiClient.GetAsync<OrderDto>($"orders/{orderId}");
                        if (order != null)
                        {
                            pnlOrderDetails.Visible = true;
                            lblOrderID.Text = order.OrderID.ToString();
                            lblOrderDate.Text = order.OrderDate.ToShortDateString();
                            lblOrderStatus.Text = order.Status;
                            ItemsGridView.DataSource = order.OrderItems;
                            ItemsGridView.DataBind();
                        }
                        else
                        {
                            StatusMessage.Text = "<p style='color:red;'>Order not found or you do not have permission to view it.</p>";
                        }
                    }));
                }
                else
                {
                    StatusMessage.Text = "<p style='color:red;'>Invalid Order ID.</p>";
                }
            }
        }
    }
}
