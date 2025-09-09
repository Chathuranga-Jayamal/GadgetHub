using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace GadgetHub.Controllers
{
    public class HomeController : ApiController
    {
        [HttpGet]
        [Route("")]
        public HttpResponseMessage Home()
        {
            return Request.CreateResponse(HttpStatusCode.OK, "Gadget Hub API is running.");
        }
    }
}