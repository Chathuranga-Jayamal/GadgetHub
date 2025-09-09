using GadgetHubClient.App_Code.Models;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHubClient.Distributor
{
    public partial class AcceptedOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAcceptedOrders();
            }
        }

        private void BindAcceptedOrders()
        {
            RegisterAsyncTask(new PageAsyncTask(async () =>
            {
                var orders = await ApiClient.GetAsync<List<AcceptQuotationDto>>("quotations/accepted");

                AcceptedOrdersRepeater.DataSource = orders;
                AcceptedOrdersRepeater.DataBind();

                RepeaterEmptyPanel.Visible = (orders == null || orders.Count == 0);
            }));
        }

        protected void AcceptedOrdersRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ConfirmOrder")
            {
                var quotationId = Convert.ToInt32(e.CommandArgument);
                var txtDistributorOrderID = (TextBox)e.Item.FindControl("txtDistributorOrderID");

                if (txtDistributorOrderID == null || string.IsNullOrWhiteSpace(txtDistributorOrderID.Text))
                {
                    StatusMessage.Text = "<p style='color:red'>Please enter your internal order ID to confirm.</p>";
                    return;
                }

                var confirmation = new ConfirmOrderDto
                {
                    QuotationID = quotationId,
                    DistributorOrderID = txtDistributorOrderID.Text,
                    ConfirmAt = DateTime.UtcNow
                };

                RegisterAsyncTask(new PageAsyncTask(async () =>
                {
                    bool success = await ApiClient.PostWithoutResponse("quotations/confirm", confirmation);
                    if (success)
                    {
                        StatusMessage.Text = "<p style='color:green'>Order confirmed successfully!</p>";
                        BindAcceptedOrders(); // refresh
                    }
                    else
                    {
                        StatusMessage.Text = "<p style='color:red'>There was an error confirming the order.</p>";
                    }
                }));
            }
        }
    }
}
