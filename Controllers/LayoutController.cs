using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebDemo.Models;
using System.Web.Mvc;

namespace WebDemo.Controllers
{
    public class LayoutController : Controller
    {
        ShopOnlineEntities db = new ShopOnlineEntities();
        // GET: Layout
        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult getCategory()
        {
            ViewBag.meta = "san-pham";
            var model = db.ListCategories.Where(x => x.hide == false).OrderByDescending(x => x.order).ToList();
            return PartialView(model);
        }
        
        public ActionResult getMenu()
        {
            var model = db.menu.Where(x => x.hide == true).OrderByDescending(x => x.order).ToList();
            return PartialView(model);
        }
        public ActionResult getAboutInFooter()
        {
            var model = db.PersonalInfo.Where(x => x.hide == false).OrderByDescending(x => x.order).FirstOrDefault();
            return PartialView(model);
        }

        public ActionResult getUsefulLinksInFooter()
        {
            var model = db.UsefulLinks.Where(x => x.hide == false).OrderByDescending(x => x.order).ToList();
            return PartialView(model);
        }
    }
}