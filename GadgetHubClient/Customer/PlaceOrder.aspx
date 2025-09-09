<%@ Page Title="Shopping Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlaceOrder.aspx.cs" Inherits="GadgetHubClient.Customer.PlaceOrder" Async="true" %>
<%@ Register Src="~/Controls/NavigationBar.ascx" TagPrefix="uc" TagName="NavigationBar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .cart-container {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            padding: 2rem 1rem;
        }

        .cart-content {
            max-width: 1200px;
            margin: 0 auto;
        }

        .cart-header {
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

        .cart-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
        }

        .cart-title {
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

        .cart-title::before {
            content: "🛒";
            font-size: 2.25rem;
        }

        .cart-subtitle {
            font-size: 1.1rem;
            font-weight: 400;
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }

        .status-message {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            border: 2px solid #0ea5e9;
            color: #0369a1;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            animation: slideIn 0.8s ease-out;
        }

        .status-message::before {
            content: "ℹ️";
            margin-right: 0.75rem;
            font-size: 1.2rem;
        }

        .cart-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-bottom: 2rem;
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cart-table th {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: #374151;
            padding: 1.25rem 1.5rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            border-bottom: 2px solid #e5e7eb;
        }

        .cart-table th:first-child {
            border-radius: 0;
        }

        .cart-table th:last-child {
            border-radius: 0;
        }

        .cart-table td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f3f4f6;
            color: #374151;
            font-size: 1rem;
        }

        .cart-table tr:hover {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        }

        .cart-table tr:last-child td {
            border-bottom: none;
        }

        .product-id-cell {
            font-weight: 600;
            color: #3b82f6;
        }

        .quantity-cell {
            font-weight: 500;
            color: #059669;
        }

        .cart-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .place-order-btn {
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: inherit;
            box-shadow: 0 6px 20px rgba(5, 150, 105, 0.3);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .place-order-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(5, 150, 105, 0.4);
            background: linear-gradient(135deg, #047857 0%, #065f46 100%);
        }

        .place-order-btn::before {
            content: "✅";
            font-size: 1.1rem;
        }

        .continue-shopping-link {
            display: inline-flex;
            align-items: center;
            background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%);
            color: white;
            text-decoration: none;
            padding: 0.875rem 1.75rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(107, 114, 128, 0.3);
            gap: 0.5rem;
        }

        .continue-shopping-link:hover {
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(107, 114, 128, 0.4);
        }

        .continue-shopping-link::before {
            content: "🛍️";
            font-size: 1rem;
        }

        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }

        .empty-cart-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .empty-cart-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
        }

        .empty-cart-description {
            color: #6b7280;
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        .cart-summary {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            border: 2px solid #0ea5e9;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .cart-summary-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #0369a1;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .cart-summary-title::before {
            content: "📊";
            font-size: 1.2rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            color: #0369a1;
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

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Responsive adjustments */
        @media (min-width: 768px) {
            .cart-container {
                padding: 3rem 2rem;
            }
            
            .cart-header {
                padding: 3rem;
            }
            
            .cart-actions {
                flex-wrap: nowrap;
            }
        }

        @media (min-width: 992px) {
            .cart-container {
                padding: 4rem 2.5rem;
            }
            
            .cart-title {
                font-size: 3rem;
            }
            
            .cart-header {
                padding: 3.5rem;
            }
        }

        @media (min-width: 1200px) {
            .cart-container {
                padding: 5rem 3rem;
            }
            
            .cart-title {
                font-size: 3.5rem;
            }
        }
    </style>

    <div class="cart-container">
        <div class="cart-content">
            <%-- Header Section --%>
            <div class="cart-header">
                <h1 class="cart-title">Your Shopping Cart</h1>
                <p class="cart-subtitle">Review your items and proceed to checkout</p>
            </div>

            <%-- Status Message --%>
            <asp:Literal runat="server" ID="StatusMessage" />

            <%-- Cart Summary (you can add this programmatically) --%>
            <div class="cart-summary">
                <h3 class="cart-summary-title">Order Summary</h3>
                <div class="summary-row">
                    <span>Total Items:</span>
                    <span id="totalItems">Loading...</span>
                </div>
                <div class="summary-row">
                    <span>Estimated Total:</span>
                    <span id="estimatedTotal">Calculating...</span>
                </div>
            </div>

            <%-- Cart Items --%>
            <div class="cart-card">
                <asp:GridView ID="CartGridView" runat="server" 
                             AutoGenerateColumns="False"
                             DataKeyNames="ProductID" 
                             CssClass="cart-table"
                             GridLines="None"
                             HeaderStyle-CssClass="cart-header-style"
                             RowStyle-CssClass="cart-row-style">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="Product ID" ItemStyle-CssClass="product-id-cell" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" ItemStyle-CssClass="quantity-cell" />
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-cart">
                            <div class="empty-cart-icon">🛒</div>
                            <h3 class="empty-cart-title">Your cart is empty</h3>
                            <p class="empty-cart-description">Add some amazing products to get started!</p>
                            <asp:HyperLink runat="server" NavigateUrl="~/Customer/BrowseProducts.aspx" CssClass="continue-shopping-link">
                                Start Shopping
                            </asp:HyperLink>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>

            <%-- Cart Actions --%>
            <div class="cart-actions">
                <asp:HyperLink runat="server" NavigateUrl="~/Customer/BrowseProducts.aspx" CssClass="continue-shopping-link">
                    Continue Shopping
                </asp:HyperLink>
                
                <asp:Button ID="btnPlaceOrder" runat="server" 
                           Text="Confirm and Place Order" 
                           OnClick="btnPlaceOrder_Click" 
                           CssClass="place-order-btn" />
            </div>
        </div>
    </div>

    <script>
        // Simple script to update cart summary (you can enhance this with server-side data)
        document.addEventListener('DOMContentLoaded', function() {
            // Count rows in the cart table (excluding header)
            const cartTable = document.querySelector('.cart-table');
            if (cartTable) {
                const rows = cartTable.querySelectorAll('tr');
                const itemCount = Math.max(0, rows.length - 1); // Subtract header row
                
                document.getElementById('totalItems').textContent = itemCount + ' item(s)';
                document.getElementById('estimatedTotal').textContent = 'Contact for pricing';
            } else {
                document.getElementById('totalItems').textContent = '0 items';
                document.getElementById('estimatedTotal').textContent = '$0.00';
            }
        });
    </script>
</asp:Content>