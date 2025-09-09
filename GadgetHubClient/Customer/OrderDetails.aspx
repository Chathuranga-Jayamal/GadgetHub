<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="GadgetHubClient.Customer.OrderDetails" Async="true" %>
<%@ Register Src="~/Controls/NavigationBar.ascx" TagPrefix="uc" TagName="NavigationBar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            line-height: 1.6;
        }
        
        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 0.75rem;
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.15);
        }
        
        .order-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }
        
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.12);
        }
        
        .status-message {
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
        }
        
        .order-header {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            color: white;
            margin: -1.5rem -1.5rem 1.5rem -1.5rem;
            padding: 1.5rem;
            border-radius: 0.75rem 0.75rem 0 0;
        }
        
        .order-info {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            padding: 1.25rem;
            margin-bottom: 1.5rem;
        }
        
        .info-label {
            color: #64748b;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .info-value {
            color: #1e293b;
            font-weight: 500;
            font-size: 1rem;
        }
        
        .items-section h4 {
            color: #1e293b;
            font-weight: 600;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .table {
            background: white;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        
        .table thead th {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-size: 0.75rem;
            border: none;
            padding: 1rem 0.75rem;
        }
        
        .table tbody td {
            padding: 0.875rem 0.75rem;
            border-color: #f1f5f9;
            font-weight: 500;
        }
        
        .table tbody tr:hover {
            background-color: #f8fafc;
        }
        
        @media (max-width: 768px) {
            .order-header {
                margin: -1rem -1rem 1rem -1rem;
                padding: 1rem;
            }
            
            .table-responsive {
                font-size: 0.875rem;
            }
            
            .table thead th,
            .table tbody td {
                padding: 0.625rem 0.5rem;
            }
        }
    </style>

    <div class="container-fluid py-4">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="page-header text-center py-4 px-3">
                    <h1 class="mb-0 fw-bold">Order Details</h1>
                    <p class="mb-0 opacity-90">View comprehensive information about your order</p>
                </div>
            </div>
        </div>

        <!-- Status Message -->
        <div class="row mb-3">
            <div class="col-12">
                <div class="status-message bg-light border-start border-4 border-info">
                    <asp:Literal ID="StatusMessage" runat="server" />
                </div>
            </div>
        </div>

        <!-- Order Details Panel -->
        <asp:Panel ID="pnlOrderDetails" runat="server" Visible="false">
            <div class="row justify-content-center">
                <div class="col-lg-10 col-xl-8">
                    <div class="order-card card border-0 rounded-4">
                        <div class="card-body p-4">
                            <!-- Order Header -->
                            <div class="order-header text-center">
                                <h2 class="mb-1 fw-bold">
                                    Order #<asp:Label ID="lblOrderID" runat="server" />
                                </h2>
                                <p class="mb-0 opacity-90">Thank you for your purchase!</p>
                            </div>

                            <!-- Order Information -->
                            <div class="order-info">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="d-flex flex-column">
                                            <span class="info-label">Order Date</span>
                                            <span class="info-value">
                                                <i class="fas fa-calendar-alt me-2 text-primary"></i>
                                                <asp:Label ID="lblOrderDate" runat="server" />
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="d-flex flex-column">
                                            <span class="info-label">Order Status</span>
                                            <span class="info-value">
                                                <i class="fas fa-info-circle me-2 text-success"></i>
                                                <asp:Label ID="lblOrderStatus" runat="server" />
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Items Section -->
                            <div class="items-section">
                                <h4>
                                    <i class="fas fa-shopping-cart me-2 text-primary"></i>
                                    Items in this Order
                                </h4>
                                
                                <div class="table-responsive">
                                    <asp:GridView ID="ItemsGridView" runat="server" 
                                        AutoGenerateColumns="False" 
                                        CssClass="table table-hover mb-0"
                                        HeaderStyle-CssClass="table-header"
                                        RowStyle-CssClass="table-row"
                                        GridLines="None">
                                        <Columns>
                                            <asp:BoundField DataField="OrderItemID" HeaderText="Item ID" 
                                                HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center fw-semibold" />
                                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" 
                                                HeaderStyle-CssClass="text-start" ItemStyle-CssClass="text-start" />
                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                                HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center fw-semibold" />
                                            <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" 
                                                DataFormatString="{0:C}" HeaderStyle-CssClass="text-end" 
                                                ItemStyle-CssClass="text-end fw-bold text-success" />
                                            <asp:BoundField DataField="Status" HeaderText="Item Status" 
                                                HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <div class="text-center py-5 text-muted">
                                                <i class="fas fa-inbox fa-3x mb-3 opacity-50"></i>
                                                <h5>No items found</h5>
                                                <p>This order doesn't contain any items.</p>
                                            </div>
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>

    <!-- Add Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</asp:Content>