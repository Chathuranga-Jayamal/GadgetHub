<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GadgetHubClient.Account.Login" Async="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - GadgetHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            padding: 3rem;
            width: 100%;
            max-width: 500px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            animation: slideUp 0.8s ease-out;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 0.5rem;
        }

        .login-header .subtitle {
            color: #64748b;
            font-size: 1.1rem;
            font-weight: 400;
        }

        .divider {
            height: 3px;
            background: linear-gradient(90deg, transparent, #3b82f6, transparent);
            margin: 2rem 0;
            border: none;
            border-radius: 2px;
        }

        .success-message {
            background: linear-gradient(135deg, #f0fdf4, #dcfce7);
            border: 2px solid #4ade80;
            color: #16a34a;
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 1rem;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .success-message::before {
            content: "✅";
            margin-right: 0.75rem;
            font-size: 1.2rem;
        }

        .error-message {
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            border: 2px solid #f87171;
            color: #dc2626;
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 1rem;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .error-message::before {
            content: "⚠️";
            margin-right: 0.75rem;
            font-size: 1.2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
            font-size: 1rem;
        }

        .form-input {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid #d1d5db;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #ffffff;
            font-family: inherit;
        }

        .form-input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
            transform: translateY(-1px);
        }

        .form-input:hover {
            border-color: #9ca3af;
        }

        .validation-error {
            color: #dc2626;
            font-size: 0.9rem;
            margin-top: 0.375rem;
            font-weight: 500;
            display: block;
        }

        .login-button {
            width: 100%;
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            border: none;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
            font-family: inherit;
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.3);
        }

        .login-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(59, 130, 246, 0.4);
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
        }

        .login-button:active {
            transform: translateY(-1px);
        }

        .login-button:focus {
            outline: none;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.3);
        }

        .register-link-container {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
        }

        .register-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }

        .register-link:hover {
            color: #1d4ed8;
            text-decoration: none;
            transform: translateY(-1px);
        }

        .register-link::after {
            content: "→";
            margin-left: 0.5rem;
            transition: transform 0.3s ease;
        }

        .register-link:hover::after {
            transform: translateX(3px);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive adjustments for different screen sizes */
        @media (min-width: 768px) {
            .login-container {
                max-width: 550px;
                padding: 3.5rem;
            }
        }

        @media (min-width: 992px) {
            .login-container {
                max-width: 600px;
                padding: 4rem;
            }
            
            .login-header h1 {
                font-size: 3rem;
            }
        }

        @media (min-width: 1200px) {
            .login-container {
                max-width: 650px;
                padding: 4.5rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-header">
                <h1>Welcome Back</h1>
                <p class="subtitle">Sign in to your GadgetHub account</p>
            </div>
            
            <hr class="divider" />
            
            <asp:PlaceHolder runat="server" ID="SuccessMessage" Visible="false">
                <div class="success-message">
                    Registration successful! Please log in.
                </div>
            </asp:PlaceHolder>

            <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                <div class="error-message">
                    <asp:Literal runat="server" ID="FailureText" />
                </div>
            </asp:PlaceHolder>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Email" CssClass="form-label">Email Address</asp:Label>
                <asp:TextBox runat="server" ID="Email" TextMode="Email" CssClass="form-input" placeholder="Enter your email address" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" CssClass="validation-error" ErrorMessage="Email address is required." Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Password" CssClass="form-label">Password</asp:Label>
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-input" placeholder="Enter your password" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="validation-error" ErrorMessage="Password is required." Display="Dynamic" />
            </div>

            <asp:Button runat="server" OnClick="LogIn_Click" Text="Sign In" CssClass="login-button" />

            <div class="register-link-container">
                <asp:HyperLink runat="server" ID="RegisterHyperLink" NavigateUrl="~/Account/Register.aspx" CssClass="register-link">
                    Don't have an account? Register here
                </asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>