using System.Web.Mvc;
using A.Simple.App.Controllers.Interfaces;

namespace A.Simple.App.Controllers
{
    public class HomeController : Controller, IHomeController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}