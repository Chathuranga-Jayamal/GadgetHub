using GadgetHub.Repositories;
using GadgetHub.Repositories.Interfaces;
using GadgetHub.Services;
using GadgetHub.Services.Interfaces;
using System.Web.Http;
using Unity;
using Unity.WebApi;

namespace GadgetHub
{
    public static class UnityConfig
    {
        public static IUnityContainer RegisterComponents()
        {
			var container = new UnityContainer();

            // register all your components with the container here
            // it is NOT necessary to register your controllers

            // e.g. container.RegisterType<ITestService, TestService>();
            container.RegisterType<IAuthService, AuthService>();
            container.RegisterType<IUserRepository, UserRepository>();
            container.RegisterType<IProductService, ProductService>();
            container.RegisterType<IProductRepository, ProductRepository>();
            container.RegisterType<IOrderRepository, OrderRepository>();
            container.RegisterType<IOrderService, OrderService>();
            container.RegisterType<IQuotationService, QuotationService>();
            container.RegisterType<IQuotationRepository, QuotationRepository>();

            // We will set the dependency resolver in Startup.cs, so we comment it out here.
            // GlobalConfiguration.Configuration.DependencyResolver = new UnityDependencyResolver(container);

            return container;
        }
    }
}