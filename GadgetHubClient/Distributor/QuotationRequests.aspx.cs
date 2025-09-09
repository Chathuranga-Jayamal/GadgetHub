using GadgetHubClient.App_Code;
using GadgetHubClient.App_Code.Models;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHubClient.Distributor
{
    public partial class QuotationRequests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRequests();
            }
        }

        private void BindRequests()
        {
            RegisterAsyncTask(new PageAsyncTask(async () =>
            {
                // FIX: Use DTO instead of page class to avoid type conflict
                var requests = await ApiClient.GetAsync<List<QuotationRequestDto>>("quotations/requests");

                pnlEmptyState.Visible = (requests == null || requests.Count == 0);
                RequestsRepeater.Visible = !pnlEmptyState.Visible;

                RequestsRepeater.DataSource = requests;
                RequestsRepeater.DataBind();
            }));
        }

        protected void RequestsRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SubmitQuote")
            {
                var hdnOrderItemID = (HiddenField)e.Item.FindControl("hdnOrderItemID");
                var ddlIsAvailable = (DropDownList)e.Item.FindControl("ddlIsAvailable");
                var txtPrice = (TextBox)e.Item.FindControl("txtPrice");
                var txtAvailable = (TextBox)e.Item.FindControl("txtAvailable");
                var txtDeliveryDate = (TextBox)e.Item.FindControl("txtDeliveryDate");

                // Validation
                if (string.IsNullOrWhiteSpace(txtPrice.Text) ||
                    string.IsNullOrWhiteSpace(txtAvailable.Text) ||
                    string.IsNullOrWhiteSpace(txtDeliveryDate.Text))
                {
                    StatusMessage.Text = "<p style='color:red'>All fields are required to submit a quote.</p>";
                    return;
                }

                var quotation = new QuotationDto
                {
                    OrderItemID = Convert.ToInt32(hdnOrderItemID.Value),
                    IsAvailable = Convert.ToBoolean(ddlIsAvailable.SelectedValue),
                    PricePerUnit = Convert.ToDecimal(txtPrice.Text),
                    AvailableUnits = Convert.ToInt32(txtAvailable.Text),
                    EstimatedDeliveryDate = Convert.ToDateTime(txtDeliveryDate.Text)
                };

                RegisterAsyncTask(new PageAsyncTask(async () =>
                {
                    bool success = await ApiClient.PostWithoutResponse("quotations/add", quotation);
                    if (success)
                    {
                        StatusMessage.Text = "<p style='color:green'>Quotation submitted successfully!</p>";
                        BindRequests();
                    }
                    else
                    {
                        StatusMessage.Text = "<p style='color:red'>There was an error submitting the quotation.</p>";
                    }
                }));
            }

        }
    }
}
