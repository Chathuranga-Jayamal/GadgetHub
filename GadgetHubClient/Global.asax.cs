using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace GadgetHubClient
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            var authCookie = Context.Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie != null)
            {
                var authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                var roles = authTicket.UserData.Split(',');
                var userPrincipal = new System.Security.Principal.GenericPrincipal(new FormsIdentity(authTicket), roles);
                Context.User = userPrincipal;
            }
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            var request = HttpContext.Current.Request;
            string method = request.HttpMethod;
            string url = request.Url.ToString();
            string ip = request.UserHostAddress;

            System.Diagnostics.Debug.WriteLine($"[{DateTime.Now}] {method} {url} from {ip}");

            try
            {
                string logPath = Server.MapPath("~/App_Data/request_log.txt");
                string logEntry = $"{DateTime.Now:u} {method} {url} from {ip}{Environment.NewLine}";
                System.IO.File.AppendAllText(logPath, logEntry);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Logging error: " + ex.Message);
            }
        }
    }
}