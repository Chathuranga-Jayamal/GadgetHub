using System;
using System.Web.UI;
using GadgetHubClient.App_Code.Models;

namespace GadgetHubClient.Customer
{
    public partial class PlaceOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCart();
            }
        }

        private void BindCart()
        {
            var cart = ShoppingCartHelper.GetCart();
            CartGridView.DataSource = cart;
            CartGridView.DataBind();

            // Only show the place order button if the cart is not empty
            btnPlaceOrder.Visible = cart.Count > 0;
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            var cart = ShoppingCartHelper.GetCart();
            if (cart.Count == 0)
            {
                StatusMessage.Text = "<p style='color:red;'>Your cart is empty.</p>";
                return;
            }

            var newOrder = new CreateOrderDto
            {
                Items = cart
            };

            RegisterAsyncTask(new PageAsyncTask(async () =>
            {
                bool success = await ApiClient.PostWithoutResponse("orders/place", newOrder);
                if (success)
                {
                    ShoppingCartHelper.ClearCart();
                    StatusMessage.Text = "<p style='color:green;'>Order placed successfully!</p>";
                    btnPlaceOrder.Visible = false;
                    BindCart(); // Re-bind to show empty cart
                }
                else
                {
                    StatusMessage.Text = "<p style='color:red;'>There was an error placing your order.</p>";
                }
            }));
        }
    }
}
