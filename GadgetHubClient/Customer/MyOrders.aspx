<%@ Page Title="My Orders" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="GadgetHubClient.Customer.MyOrders" Async="true" %>
<%@ Register Src="~/Controls/NavigationBar.ascx" TagPrefix="uc" TagName="NavigationBar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .orders-container {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            padding: 2rem 1rem;
        }

        .orders-content {
            max-width: 1400px;
            margin: 0 auto;
        }

        .orders-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 2.5rem;
            border-radius: 20px;
            margin-bottom: 2rem;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
            animation: slideDown 0.8s ease-out;
        }

        .orders-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
        }

        .orders-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .orders-title::before {
            content: "📦";
            font-size: 2.25rem;
        }

        .orders-subtitle {
            font-size: 1.1rem;
            font-weight: 400;
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }

        .orders-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.05);
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }

        .orders-table th {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: #374151;
            padding: 1.25rem 1.5rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            border-bottom: 2px solid #e5e7eb;
            white-space: nowrap;
        }

        .orders-table td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f3f4f6;
            color: #374151;
            font-size: 1rem;
            vertical-align: middle;
        }

        .orders-table tr:hover {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        }

        .orders-table tr:last-child td {
            border-bottom: none;
        }

        .order-id-cell {
            font-weight: 600;
            color: #3b82f6;
            font-family: 'Monaco', 'Courier New', monospace;
        }

        .order-date-cell {
            color: #6b7280;
            font-weight: 500;
        }

        .total-amount-cell {
            font-weight: 700;
            color: #059669;
            font-size: 1.1rem;
        }

        .status-cell {
            font-weight: 600;
        }

        .status-pending {
            color: #d97706;
            background: linear-gradient(135deg, #fef3c7 0%, #fcd34d 100%);
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            display: inline-block;
            border: 1px solid #f59e0b;
        }

        .status-processing {
            color: #0369a1;
            background: linear-gradient(135deg, #dbeafe 0%, #93c5fd 100%);
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            display: inline-block;
            border: 1px solid #3b82f6;
        }

        .status-shipped {
            color: #7c3aed;
            background: linear-gradient(135deg, #ede9fe 0%, #c4b5fd 100%);
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            display: inline-block;
            border: 1px solid #8b5cf6;
        }

        .status-delivered {
            color: #065f46;
            background: linear-gradient(135deg, #d1fae5 0%, #6ee7b7 100%);
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            display: inline-block;
            border: 1px solid #10b981;
        }

        .status-cancelled {
            color: #dc2626;
            background: linear-gradient(135deg, #fee2e2 0%, #fca5a5 100%);
            padding: 0.375rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            display: inline-block;
            border: 1px solid #ef4444;
        }

        .view-details-link {
            display: inline-flex;
            align-items: center;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
            gap: 0.375rem;
        }

        .view-details-link:hover {
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
        }

        .view-details-link::after {
            content: "→";
            transition: transform 0.3s ease;
        }

        .view-details-link:hover::after {
            transform: translateX(2px);
        }

        .no-orders {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .no-orders-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .no-orders-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
        }

        .no-orders-description {
            color: #6b7280;
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        .start-shopping-btn {
            display: inline-flex;
            align-items: center;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            text-decoration: none;
            padding: 0.875rem 1.75rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.3);
            gap: 0.5rem;
        }

        .start-shopping-btn:hover {
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.4);
        }

        .start-shopping-btn::before {
            content: "🛍️";
            font-size: 1rem;
        }

        .orders-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            animation: fadeInUp 0.8s ease-out 0.1s both;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .stat-number {
            font-size: 1.75rem;
            font-weight: 700;
            color: #3b82f6;
            margin-bottom: 0.25rem;
        }

        .stat-label {
            color: #6b7280;
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Animations */
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .orders-table {
                font-size: 0.9rem;
            }
            
            .orders-table th,
            .orders-table td {
                padding: 0.875rem 0.75rem;
            }
            
            .view-details-link {
                padding: 0.375rem 0.75rem;
                font-size: 0.85rem;
            }
        }

        @media (min-width: 768px) {
            .orders-container {
                padding: 3rem 2rem;
            }
            
            .orders-header {
                padding: 3rem;
            }
        }

        @media (min-width: 992px) {
            .orders-container {
                padding: 4rem 2.5rem;
            }
            
            .orders-title {
                font-size: 3rem;
            }
            
            .orders-header {
                padding: 3.5rem;
            }
        }

        @media (min-width: 1200px) {
            .orders-container {
                padding: 5rem 3rem;
            }
            
            .orders-title {
                font-size: 3.5rem;
            }
        }
    </style>

    <div class="orders-container">
        <div class="orders-content">
            <%-- Header Section --%>
            <div class="orders-header">
                <h1 class="orders-title">My Order History</h1>
                <p class="orders-subtitle">Track your orders and view purchase history</p>
            </div>

            <%-- Order Statistics --%>
            <div class="orders-stats">
                <div class="stat-card">
                    <div class="stat-icon">📊</div>
                    <div class="stat-number" id="totalOrders">-</div>
                    <div class="stat-label">Total Orders</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">🚛</div>
                    <div class="stat-number" id="activeOrders">-</div>
                    <div class="stat-label">Active Orders</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">✅</div>
                    <div class="stat-number" id="completedOrders">-</div>
                    <div class="stat-label">Completed</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">💰</div>
                    <div class="stat-number" id="totalSpent">-</div>
                    <div class="stat-label">Total Spent</div>
                </div>
            </div>

            <%-- Orders Table --%>
            <div class="orders-card">
                <asp:GridView ID="OrdersGridView" runat="server" 
                             AutoGenerateColumns="False"
                             DataKeyNames="OrderID" 
                             CssClass="orders-table"
                             GridLines="None"
                             HeaderStyle-CssClass="orders-header-style"
                             RowStyle-CssClass="orders-row-style">
                    <Columns>
                        <asp:BoundField DataField="OrderID" HeaderText="Order ID" ItemStyle-CssClass="order-id-cell" />
                        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:MMM dd, yyyy}" ItemStyle-CssClass="order-date-cell" />
                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" DataFormatString="{0:C}" ItemStyle-CssClass="total-amount-cell" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# "status-" + Eval("Status").ToString().ToLower().Replace(" ", "-") %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:HyperLink runat="server" 
                                              NavigateUrl='<%# "~/Customer/OrderDetails.aspx?OrderID=" + Eval("OrderID") %>'
                                              Text="View Details"
                                              CssClass="view-details-link" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="no-orders">
                            <div class="no-orders-icon">📦</div>
                            <h3 class="no-orders-title">No Orders Yet</h3>
                            <p class="no-orders-description">You haven't placed any orders yet. Start shopping to see your order history here!</p>
                            <asp:HyperLink runat="server" NavigateUrl="~/Customer/BrowseProducts.aspx" CssClass="start-shopping-btn">
                                Start Shopping
                            </asp:HyperLink>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Calculate and display order statistics
            const ordersTable = document.querySelector('.orders-table');
            if (ordersTable) {
                const rows = ordersTable.querySelectorAll('tbody tr');
                let totalOrders = 0;
                let activeOrders = 0;
                let completedOrders = 0;
                let totalSpent = 0;

                rows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    if (cells.length >= 4) {
                        totalOrders++;
                        
                        // Parse total amount (remove currency symbols and commas)
                        const amountText = cells[2].textContent.replace(/[$,]/g, '');
                        const amount = parseFloat(amountText) || 0;
                        totalSpent += amount;
                        
                        // Check status
                        const statusElement = cells[3].querySelector('span');
                        if (statusElement) {
                            const status = statusElement.textContent.toLowerCase().trim();
                            if (status === 'delivered' || status === 'completed') {
                                completedOrders++;
                            } else if (status !== 'cancelled') {
                                activeOrders++;
                            }
                        }
                    }
                });

                // Update statistics
                document.getElementById('totalOrders').textContent = totalOrders;
                document.getElementById('activeOrders').textContent = activeOrders;
                document.getElementById('completedOrders').textContent = completedOrders;
                document.getElementById('totalSpent').textContent = '$' + totalSpent.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            } else {
                // No orders
                document.getElementById('totalOrders').textContent = '0';
                document.getElementById('activeOrders').textContent = '0';
                document.getElementById('completedOrders').textContent = '0';
                document.getElementById('totalSpent').textContent = '$0.00';
            }
        });
    </script>
</asp:Content>