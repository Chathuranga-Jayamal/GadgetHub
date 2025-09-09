<%@ Page Title="Accepted Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AcceptedOrders.aspx.cs" Inherits="GadgetHubClient.Distributor.AcceptedOrders" Async="true" %>
<%@ Register Src="~/Controls/NavigationBar.ascx" TagPrefix="uc" TagName="NavigationBar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<!-- Font Awesome CDN -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f0f2f5;
        margin: 0;
        padding: 0;
        color: #374151;
    }
    .container {
        max-width: 960px;
        margin: 2rem auto;
        padding: 0 1rem;
    }
    .page-header {
        background: linear-gradient(135deg, #4f46e5, #7c3aed);
        color: #fff;
        padding: 1.5rem 1rem;
        border-radius: 0.75rem;
        box-shadow: 0 8px 24px rgba(124, 58, 237, 0.3);
        text-align: center;
        margin-bottom: 2rem;
    }
    .page-header h1 {
        margin: 0;
        font-weight: 700;
        font-size: 2rem;
    }
    .page-header p {
        margin: 0.5rem 0 0;
        font-size: 1rem;
        opacity: 0.8;
    }
    .status-message {
        margin-bottom: 1.5rem;
        font-weight: 600;
        font-size: 1rem;
    }
    .order-card {
        background: #fff;
        border-radius: 0.75rem;
        box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        margin-bottom: 1.5rem;
        transition: transform 0.25s ease;
        padding: 1rem;
    }
    .order-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 30px rgba(0,0,0,0.15);
    }
    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
        color: #4f46e5;
        font-weight: 700;
        font-size: 1.25rem;
    }
    .order-date {
        background: #e0e7ff;
        color: #4338ca;
        padding: 0.25rem 0.75rem;
        border-radius: 9999px;
        font-weight: 600;
        font-size: 0.875rem;
    }
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit,minmax(160px,1fr));
        gap: 1rem;
        margin-bottom: 1rem;
        font-size: 0.9rem;
    }
    .info-label {
        color: #6b7280;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.75rem;
        margin-bottom: 0.25rem;
    }
    .info-value {
        font-weight: 600;
        color: #1e293b;
    }
    .price-value {
        color: #10b981;
        font-weight: 700;
        font-size: 1.1rem;
    }
    .fulfillment-section {
        background: #f9fafb;
        padding: 1rem;
        border-radius: 0.5rem;
        border: 1px solid #e5e7eb;
    }
    .fulfillment-pending {
        background: linear-gradient(135deg, #fef3c7 0%, #fbbf24 15%);
        border-color: #f59e0b;
    }
    .fulfillment-confirmed {
        background: linear-gradient(135deg, #d1fae5 0%, #10b981 15%);
        border-color: #059669;
    }
    .fulfillment-title {
        font-weight: 700;
        font-size: 1rem;
        color: #374151;
        margin-bottom: 0.75rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    .form-control {
        width: 100%;
        padding: 0.5rem 0.75rem;
        font-size: 0.9rem;
        border: 2px solid #e5e7eb;
        border-radius: 0.375rem;
        transition: border-color 0.3s ease;
    }
    .form-control:focus {
        border-color: #4f46e5;
        outline: none;
        box-shadow: 0 0 5px rgba(79,70,229,0.5);
    }
    .btn-confirm {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        font-weight: 700;
        border: none;
        border-radius: 0.375rem;
        padding: 0.5rem 1.25rem;
        cursor: pointer;
        font-size: 0.9rem;
        transition: background 0.3s ease, box-shadow 0.3s ease;
    }
    .btn-confirm:hover {
        background: linear-gradient(135deg, #059669 0%, #047857 100%);
        box-shadow: 0 4px 12px rgba(5, 150, 105, 0.5);
    }
    .confirmed-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        padding: 0.5rem 1rem;
        border-radius: 0.375rem;
        font-weight: 700;
        font-size: 0.9rem;
        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
    }
    .empty-state {
        text-align: center;
        color: #9ca3af;
        margin-top: 4rem;
    }
    .empty-state i {
        font-size: 4rem;
        margin-bottom: 1rem;
        opacity: 0.5;
    }
    @media (max-width: 600px) {
        .info-grid {
            grid-template-columns: 1fr;
        }
        .order-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.5rem;
        }
    }
</style>

<div class="container">

    <!-- Page Header -->
    <div class="page-header">
        <h1><i class="fas fa-check-circle me-2"></i> Accepted Orders</h1>
        <p>Manage and fulfill your accepted orders</p>
    </div>

    <!-- Status Message -->
    <div class="status-message">
        <asp:Literal ID="StatusMessage" runat="server" EnableViewState="false" />
    </div>

    <!-- Orders Repeater -->
    <asp:Repeater ID="AcceptedOrdersRepeater" runat="server" OnItemCommand="AcceptedOrdersRepeater_ItemCommand">
        <ItemTemplate>
            <div class="order-card">
                <div class="order-header">
                    <span><i class="fas fa-box me-2"></i><%# Eval("ProductName") %></span>
                    <span class="order-date"><%# ((DateTime)Eval("OrderDate")).ToString("MMM dd, yyyy") %></span>
                </div>

                <div class="info-grid">
                    <div>
                        <div class="info-label">Product Name</div>
                        <div class="info-value"><%# Eval("ProductName") %></div>
                    </div>
                    <div>
                        <div class="info-label">Quantity</div>
                        <div class="info-value"><%# Eval("Quantity") %> units</div>
                    </div>
                    <div>
                        <div class="info-label">Agreed Price/Unit</div>
                        <div class="price-value"><%# String.Format("{0:C}", Eval("PricePerUnit")) %></div>
                    </div>
                    <div>
                        <div class="info-label">Order Date</div>
                        <div class="info-value"><%# ((DateTime)Eval("OrderDate")).ToString("dddd, MMM dd, yyyy") %></div>
                    </div>
                </div>

                <asp:PlaceHolder runat="server" Visible='<%# string.IsNullOrEmpty(Eval("DistributorOrderID") as string) %>'>
                    <div class="fulfillment-section fulfillment-pending">
                        <div class="fulfillment-title">
                            <i class="fas fa-exclamation-triangle text-warning"></i>
                            Awaiting Fulfillment Confirmation
                        </div>
                        <asp:TextBox runat="server" ID="txtDistributorOrderID" CssClass="form-control" placeholder="Enter your internal order ID" />
                        <asp:Button runat="server" CommandName="ConfirmOrder" CommandArgument='<%# Eval("QuotationID") %>' Text="Confirm Order" CssClass="btn-confirm mt-3" />
                    </div>
                </asp:PlaceHolder>

                <asp:PlaceHolder runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("DistributorOrderID") as string) %>'>
                    <div class="fulfillment-section fulfillment-confirmed">
                        <div class="fulfillment-title">
                            <i class="fas fa-check-circle text-success"></i>
                            Order Confirmed & Fulfilled
                        </div>
                        <div class="confirmed-badge">
                            <i class="fas fa-clipboard-check"></i>
                            <span>Order ID: <%# Eval("DistributorOrderID") %></span>
                        </div>
                    </div>
                </asp:PlaceHolder>
            </div>
        </ItemTemplate>
    </asp:Repeater>

    <!-- Empty state panel -->
    <asp:Panel ID="RepeaterEmptyPanel" runat="server" Visible="false" CssClass="empty-state">
        <i class="fas fa-clipboard-list"></i>
        <h4>No Accepted Orders</h4>
        <p>You have no accepted orders at the moment.</p>
    </asp:Panel>

</div>

</asp:Content>
