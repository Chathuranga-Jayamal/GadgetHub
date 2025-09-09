<%@ Page Title="Browse Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BrowseProducts.aspx.cs" Inherits="GadgetHubClient.Customer.BrowseProducts" Async="true" %>
<%@ Register Src="~/Controls/NavigationBar.ascx" TagPrefix="uc" TagName="NavigationBar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .products-container {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            padding: 2rem 1rem;
        }

        .products-content {
            max-width: 1400px;
            margin: 0 auto;
        }

        .products-header {
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

        .products-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
        }

        .products-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 2;
        }

        .products-subtitle {
            font-size: 1.1rem;
            font-weight: 400;
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }

        .top-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .cart-link {
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
        }

        .cart-link:hover {
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.4);
        }

        .cart-link::before {
            content: "🛒";
            margin-right: 0.5rem;
            font-size: 1.1rem;
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

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        .product-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #3b82f6, #10b981, #f59e0b, #ef4444);
            border-radius: 20px 20px 0 0;
        }

        .product-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
        }

        .product-name::before {
            content: "📱";
            margin-right: 0.5rem;
            font-size: 1.2rem;
        }

        .product-description {
            color: #6b7280;
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 1rem;
            min-height: 3rem;
        }

        .product-category {
            display: inline-block;
            background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
            color: #374151;
            padding: 0.375rem 0.875rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
            border: 1px solid #d1d5db;
        }

        .add-to-cart-btn {
            width: 100%;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            border: none;
            padding: 0.875rem 1.5rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: inherit;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .add-to-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
        }

        .add-to-cart-btn:active {
            transform: translateY(0);
        }

        .add-to-cart-btn::before {
            content: "🛒";
            font-size: 1rem;
        }

        .no-products {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .no-products-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .no-products-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
        }

        .no-products-description {
            color: #6b7280;
            font-size: 1rem;
        }

        /* Category-specific styling */
        .category-electronics {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            color: #1e40af;
            border-color: #3b82f6;
        }

        .category-accessories {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
            border-color: #10b981;
        }

        .category-smart-devices {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #92400e;
            border-color: #f59e0b;
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
            .products-container {
                padding: 3rem 2rem;
            }
            
            .products-header {
                padding: 3rem;
            }
            
            .product-card {
                padding: 2.5rem;
            }
        }

        @media (min-width: 992px) {
            .products-container {
                padding: 4rem 2.5rem;
            }
            
            .products-title {
                font-size: 3rem;
            }
            
            .products-header {
                padding: 3.5rem;
            }
        }

        @media (min-width: 1200px) {
            .products-container {
                padding: 5rem 3rem;
            }
            
            .products-title {
                font-size: 3.5rem;
            }
        }
    </style>

    <div class="products-container">
        <div class="products-content">
            <%-- Header Section --%>
            <div class="products-header">
                <h1 class="products-title">Our Products</h1>
                <p class="products-subtitle">Discover amazing gadgets and technology at unbeatable prices</p>
            </div>

            <%-- Top Actions Bar --%>
            <div class="top-actions">
                <div></div> <%-- Empty div for spacing --%>
                <asp:HyperLink runat="server" NavigateUrl="~/Customer/PlaceOrder.aspx" CssClass="cart-link">
                    Go to Shopping Cart
                </asp:HyperLink>
            </div>

            <%-- Status Message --%>
            <asp:Literal runat="server" ID="StatusMessage" />

            <%-- Products Grid --%>
            <asp:Repeater ID="ProductRepeater" runat="server" ItemType="GadgetHubClient.App_Code.Models.ProductDto" OnItemCommand="ProductRepeater_ItemCommand">
                <HeaderTemplate>
                    <div class="products-grid">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="product-card">
                        <h3 class="product-name"><%# Item.Name %></h3>
                        <p class="product-description"><%# Item.Description %></p>
                        <span class="product-category category-<%# Item.Category.ToLower().Replace(" ", "-") %>">
                            <%# Item.Category %>
                        </span>
                        <asp:Button runat="server" 
                                   Text="Add to Cart" 
                                   CommandName="AddToCart" 
                                   CommandArgument="<%# Item.ProductID %>" 
                                   CssClass="add-to-cart-btn" />
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <%-- No Products Message (shown when repeater is empty) --%>
            <asp:Panel runat="server" ID="NoProductsPanel" Visible="false" CssClass="no-products">
                <div class="no-products-icon">📦</div>
                <h3 class="no-products-title">No Products Available</h3>
                <p class="no-products-description">We're currently updating our inventory. Please check back soon!</p>
            </asp:Panel>
        </div>
    </div>
</asp:Content>