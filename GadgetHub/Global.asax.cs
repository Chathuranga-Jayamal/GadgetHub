using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace GadgetHub
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            
            AreaRegistration.RegisterAllAreas();
            UnityConfig.RegisterComponents();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            // Handle CORS preflight requests
            if (Request.HttpMethod == "OPTIONS")
            {
                Response.Headers.Add("Access-Control-Allow-Origin", "*");
                Response.Headers.Add("Access-Control-Allow-Headers", "Content-Type, Authorization");
                Response.Headers.Add("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
                Response.StatusCode = 200;
                Response.End();
                return;
            }

            var request = HttpContext.Current.Request;
            string method = request.HttpMethod;
            string url = request.Url.ToString();
            string ip = request.UserHostAddress;

            System.Diagnostics.Debug.WriteLine($"[API] from global.asax {DateTime.Now:u} {method} {url} from {ip}");

            try
            {
                string logPath = Server.MapPath("~/App_Data/api_request_log.txt");
                string logEntry = $"{DateTime.Now:u} {method} {url} from {ip}{Environment.NewLine}";
                System.IO.File.AppendAllText(logPath, logEntry);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("API logging error: " + ex.Message);
            }
        }
    protected void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();
            System.Diagnostics.Debug.WriteLine("[API] Unhandled exception: " + ex.ToString());
        }
    }
}
