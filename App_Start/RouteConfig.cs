using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace WebDemo
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute("Product", "{type}/{meta}",
                new { controller = "Product", action = "Index", meta = UrlParameter.Optional },
                new RouteValueDictionary(new { type = "san-pham" }),
                new[] { "WebDemo.Controllers" });

            routes.MapRoute("Detail", "{type}/{meta}/{id}",
               new { controller = "Product", action = "getDetailProduct", meta = UrlParameter.Optional },
               new RouteValueDictionary(new { type = "san-pham" }),
               new[] { "WebDemo.Controllers" });

            routes.MapRoute("Contact", "{type}/{meta}",
               new { controller = "Contact", action = "Index", meta = UrlParameter.Optional },
               new RouteValueDictionary(new { type = "lien-he" }),
               new[] { "WebDemo.Controllers" });

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Default", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
