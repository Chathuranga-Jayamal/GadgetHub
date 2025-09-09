using Microsoft.IdentityModel.Tokens;
using Microsoft.Owin;
using Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Jwt;
using System;
using System.Text;
using System.Web.Http;
using Unity.WebApi;

[assembly: OwinStartup(typeof(GadgetHub.Startup))]

namespace GadgetHub
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            HttpConfiguration config = new HttpConfiguration();

            var container = UnityConfig.RegisterComponents();
            config.DependencyResolver = new UnityDependencyResolver(container);

            // Apply Web API routes
            WebApiConfig.Register(config);

            app.Use((context, next) =>
            {
                System.Diagnostics.Debug.WriteLine("[OWIN] Request received: " + context.Request.Path);
                return next.Invoke();
            });

            app.UseJwtBearerAuthentication(new JwtBearerAuthenticationOptions
            {
                AuthenticationMode = AuthenticationMode.Active,
                TokenValidationParameters = JwtHelper.GetValidationParameters(),
                Provider = new Microsoft.Owin.Security.OAuth.OAuthBearerAuthenticationProvider
                {
                    OnValidateIdentity = context =>
                    {
                        System.Diagnostics.Debug.WriteLine("[OWIN] Token validated.");
                        return System.Threading.Tasks.Task.FromResult<object>(null);
                    },
                    OnRequestToken = context =>
                    {
                        System.Diagnostics.Debug.WriteLine("[OWIN] Token received.");
                        return System.Threading.Tasks.Task.FromResult<object>(null);
                    }
                }
            });

            app.Use((context, next) =>
            {
                System.Diagnostics.Debug.WriteLine("[OWIN] JWT middleware passed.");
                return next.Invoke();
            });

            // Use Web API
            app.UseWebApi(config);

            System.Diagnostics.Debug.WriteLine("[OWIN] JWT middleware configured.");
        }
    }
}
