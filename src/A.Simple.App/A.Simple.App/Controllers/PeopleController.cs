using System.Web.Mvc;
using A.Simple.App.Controllers.Interfaces;
using A.Simple.Backend.Definition;

namespace A.Simple.App.Controllers
{
    public class PeopleController : Controller, IPeopleController
    {
        IPeopleService _peopleService;

        public PeopleController(IPeopleService peopleService)
        {
            _peopleService = peopleService;
        }

        public ActionResult Index()
        {
            var people = _peopleService.GetPeople();
            return View(people);
        }
    }
}