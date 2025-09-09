<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavigationBar.ascx.cs" Inherits="GadgetHubClient.Controls.NavigationBar" %>

<style>
    .navbar-container {
        background: linear-gradient(90deg, #1f2937, #3b82f6);
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        padding: 0.75rem 1.5rem;
        position: sticky;
        top: 0;
        z-index: 1000;
        font-family: 'Segoe UI', sans-serif;
    }

    .navbar-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        max-width: 1200px;
        margin: auto;
        flex-wrap: wrap;
    }

    .navbar-brand {
        color: white;
        font-size: 1.6rem;
        font-weight: bold;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: color 0.3s ease;
    }

    .navbar-brand:hover {
        color: #dbeafe;
    }

    /* Hamburger */
    .navbar-toggle {
        display: none;
        font-size: 1.5rem;
        color: white;
        background: none;
        border: none;
        cursor: pointer;
    }

    .navbar-links {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        flex-wrap: wrap;
    }

    .nav-link {
        color: rgba(255, 255, 255, 0.9);
        padding: 0.5rem 1rem;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .nav-link:hover {
        background: rgba(255, 255, 255, 0.15);
        color: white;
    }

    .logout-link {
        color: #fca5a5 !important;
        background: rgba(239, 68, 68, 0.15);
        border: 1px solid rgba(239, 68, 68, 0.3);
    }

    .logout-link:hover {
        background: rgba(239, 68, 68, 0.25);
        color: white !important;
    }

    /* Role-based accent */
    .customer-panel .nav-link:hover {
        background: rgba(16, 185, 129, 0.2);
    }

    .distributor-panel .nav-link:hover {
        background: rgba(245, 158, 11, 0.2);
    }

    .admin-panel .nav-link:hover {
        background: rgba(239, 68, 68, 0.2);
    }

    /* Responsive */
    @media (max-width: 768px) {
        .navbar-toggle {
            display: block;
        }
        .navbar-links {
            display: none;
            flex-direction: column;
            width: 100%;
            background: #1f2937;
            padding: 1rem;
            border-radius: 0.5rem;
            margin-top: 0.5rem;
        }
        .navbar-links.show {
            display: flex;
        }
        .nav-link {
            width: 100%;
        }
    }
</style>

<div class="navbar-container">
    <div class="navbar-content">
        <asp:HyperLink runat="server" NavigateUrl="~/Default.aspx" Text="The Gadget Hub" CssClass="navbar-brand" />

        <!-- Hamburger Button -->
        <button type="button" class="navbar-toggle" onclick="document.querySelector('.navbar-links').classList.toggle('show')">
            ☰
        </button>

        <div class="navbar-links">
            <%-- Guest --%>
            <asp:Panel runat="server" ID="pnlGuest" Visible="false" CssClass="auth-links d-flex gap-3 align-items-center">
                <asp:HyperLink runat="server" NavigateUrl="~/Account/Login.aspx" CssClass="nav-link">Log In</asp:HyperLink>
                <asp:HyperLink runat="server" NavigateUrl="~/Account/Register.aspx" CssClass="nav-link" Style="background:rgba(59,130,246,0.2);">Register</asp:HyperLink>
            </asp:Panel>

            <%-- Customer --%>
            <asp:Panel runat="server" ID="pnlCustomer" Visible="false" CssClass="customer-panel">
                <asp:HyperLink runat="server" NavigateUrl="~/Customer/BrowseProducts.aspx" CssClass="nav-link">Browse Products</asp:HyperLink>
                <asp:HyperLink runat="server" NavigateUrl="~/Customer/MyOrders.aspx" CssClass="nav-link">My Orders</asp:HyperLink>
            </asp:Panel>

            <%-- Distributor --%>
            <asp:Panel runat="server" ID="pnlDistributor" Visible="false" CssClass="distributor-panel">
                <asp:HyperLink runat="server" NavigateUrl="~/Distributor/QuotationRequests.aspx" CssClass="nav-link">Quotation Requests</asp:HyperLink>
                <asp:HyperLink runat="server" NavigateUrl="~/Distributor/AcceptedOrders.aspx" CssClass="nav-link">Accepted Orders</asp:HyperLink>
            </asp:Panel>

            <%-- Admin --%>
            <asp:Panel runat="server" ID="pnlAdmin" Visible="false" CssClass="admin-panel">
                <asp:HyperLink runat="server" NavigateUrl="~/Admin/Dashboard.aspx" CssClass="nav-link">Dashboard</asp:HyperLink>
                <asp:HyperLink runat="server" NavigateUrl="~/Admin/Products.aspx" CssClass="nav-link">Manage Products</asp:HyperLink>
                <asp:HyperLink runat="server" NavigateUrl="~/Admin/Orders.aspx" CssClass="nav-link">Manage Orders</asp:HyperLink>
                <asp:HyperLink runat="server" NavigateUrl="~/Admin/Users.aspx" CssClass="nav-link">Manage Users</asp:HyperLink>
            </asp:Panel>

            <%-- Logout --%>
            <asp:Panel runat="server" ID="pnlLogout" Visible="false">
                <asp:LinkButton runat="server" ID="btnLogout" OnClick="Logout_Click" CssClass="nav-link logout-link">Log Out</asp:LinkButton>
            </asp:Panel>
        </div>
    </div>
</div>
