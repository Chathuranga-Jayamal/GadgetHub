<%@ Page Title="Quotation Requests" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuotationRequests.aspx.cs" Inherits="GadgetHubClient.Distributor.QuotationRequests" Async="true" %>
<%@ Register Src="~/Controls/NavigationBar.ascx" TagPrefix="uc" TagName="NavigationBar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    :root {
        --primary: #4f46e5;
        --primary-dark: #3730a3;
        --secondary: #10b981;
        --secondary-dark: #059669;
        --bg-light: #f9fafb;
        --text-dark: #1f2937;
        --text-muted: #6b7280;
        --radius-lg: 0.75rem;
        --radius-md: 0.5rem;
        --shadow-soft: 0 4px 20px rgba(0,0,0,0.05);
    }

    body {
        background: var(--bg-light);
        font-family: 'Inter', sans-serif;
        color: var(--text-dark);
    }

    .container-fluid {
        max-width: 1100px;
        margin: auto;
        padding: 2rem 1rem;
    }

    /* Page Header */
    .page-header {
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
        color: white;
        padding: 2rem 1.5rem;
        border-radius: var(--radius-lg);
        text-align: center;
        box-shadow: var(--shadow-soft);
    }
    .page-header h1 {
        font-weight: 700;
        font-size: 1.8rem;
        margin-bottom: 0.5rem;
    }
    .page-header p {
        font-size: 1rem;
        opacity: 0.9;
    }

    /* Status Message */
    .status-message {
        background: #ecfdf5;
        border-left: 4px solid var(--secondary);
        padding: 1rem 1.2rem;
        border-radius: var(--radius-md);
        margin-bottom: 1.5rem;
        font-weight: 500;
    }

    /* Cards */
    .quote-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(8px);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow-soft);
        overflow: hidden;
        transition: transform 0.2s ease;
    }
    .quote-card:hover {
        transform: translateY(-3px);
    }

    /* Header inside card */
    .quote-header {
        background: linear-gradient(135deg, var(--primary), var(--primary-dark));
        color: white;
        padding: 1rem 1.25rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
    }
    .quote-header h4 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0;
    }

    /* Body */
    .quote-body {
        padding: 1.25rem;
    }

    /* Product info */
    .product-info {
        background: #f3f4f6;
        padding: 1rem;
        border-radius: var(--radius-md);
        margin-bottom: 1.25rem;
    }
    .info-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 0.5rem;
        flex-wrap: wrap;
    }
    .info-label {
        font-size: 0.85rem;
        color: var(--text-muted);
        font-weight: 600;
        text-transform: uppercase;
    }
    .info-value {
        font-weight: 500;
    }

    /* Form */
    .quote-form h5 {
        font-size: 1rem;
        font-weight: 600;
        color: var(--primary);
        margin-bottom: 1rem;
    }
    .form-control-modern {
        width: 100%;
        padding: 0.7rem;
        border: 2px solid #e5e7eb;
        border-radius: var(--radius-md);
        font-size: 0.9rem;
        transition: 0.2s;
        background: #f9fafb;
    }
    .form-control-modern:focus {
        border-color: var(--primary);
        outline: none;
        background: white;
        box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
    }

    /* Button */
    .btn-submit {
        background: linear-gradient(135deg, var(--secondary), var(--secondary-dark));
        color: white;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: var(--radius-md);
        font-weight: 600;
        cursor: pointer;
        transition: 0.2s;
    }
    .btn-submit:hover {
        background: linear-gradient(135deg, var(--secondary-dark), var(--secondary));
        transform: translateY(-1px);
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 3rem 2rem;
        color: var(--text-muted);
    }
    .empty-state i {
        font-size: 2.5rem;
        margin-bottom: 0.5rem;
        opacity: 0.6;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .quote-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.5rem;
        }
        .info-row {
            flex-direction: column;
            align-items: flex-start;
        }
    }
</style>

<div class="container-fluid">
    <!-- Header -->
    <div class="page-header">
        <h1><i class="fas fa-quote-right me-2"></i>Quotation Requests</h1>
        <p>Review and respond to new quotation requests</p>
    </div>

    <!-- Status -->
    <div class="status-message">
        <asp:Literal ID="StatusMessage" runat="server" />
    </div>

    <!-- Empty State -->
    <asp:Panel ID="pnlEmptyState" runat="server" Visible="false">
        <div class="quote-card">
            <div class="empty-state">
                <i class="fas fa-inbox"></i>
                <h4>No New Quotation Requests</h4>
                <p>There are no new quotation requests at this time. Check back later.</p>
            </div>
        </div>
    </asp:Panel>

    <!-- Requests -->
    <asp:Repeater ID="RequestsRepeater" runat="server" OnItemCommand="RequestsRepeater_ItemCommand">
        <HeaderTemplate><div class="requests-container"></HeaderTemplate>
        <ItemTemplate>
            <div class="mb-4">
                <div class="quote-card">
                    <div class="quote-header">
                        <h4><i class="fas fa-box me-2"></i><%# Eval("ProductName") %></h4>
                        <span class="badge bg-light text-dark px-3 py-2 rounded-pill">
                            <i class="fas fa-calendar-alt me-1"></i>
                            <%# String.Format("{0:MMM dd, yyyy}", Eval("OrderDate")) %>
                        </span>
                    </div>
                    <div class="quote-body">
                        <!-- Info -->
                        <div class="product-info">
                            <div class="info-row">
                                <span class="info-label">Product Name</span>
                                <span class="info-value"><%# Eval("ProductName") %></span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Quantity Needed</span>
                                <span class="info-value"><%# Eval("Quantity") %> units</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Order Date</span>
                                <span class="info-value"><%# String.Format("{0:dddd, MMMM dd, yyyy}", Eval("OrderDate")) %></span>
                            </div>
                        </div>

                        <!-- Form -->
                      <div class="quote-form">
    <h5><i class="fas fa-edit me-2"></i>Submit Your Quote</h5>
    <asp:HiddenField runat="server" ID="hdnOrderItemID" Value='<%# Eval("OrderItemID") %>' />

    <div class="row g-3 align-items-end">
        <div class="col-md-3">
            <label>Availability</label>
            <asp:DropDownList runat="server" ID="ddlIsAvailable" CssClass="form-control-modern">
                <asp:ListItem Text="Available" Value="true"></asp:ListItem>
                <asp:ListItem Text="Not Available" Value="false"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col-md-3">
            <label>Price per Unit</label>
            <asp:TextBox runat="server" ID="txtPrice" CssClass="form-control-modern" placeholder="0.00" />
        </div>
        <div class="col-md-3">
            <label>Available Units</label>
            <asp:TextBox runat="server" ID="txtAvailable" CssClass="form-control-modern" placeholder="0" />
        </div>
        <div class="col-md-3">
            <label>Delivery Date</label>
            <asp:TextBox runat="server" ID="txtDeliveryDate" CssClass="form-control-modern" TextMode="Date" />
        </div>
    </div>

    <div class="d-flex justify-content-end mt-3">
        <asp:Button runat="server" Text="Submit Quote" CommandName="SubmitQuote" CssClass="btn-submit" />
    </div>
</div>

                    </div>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate></div></FooterTemplate>
    </asp:Repeater>
</div>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</asp:Content>
