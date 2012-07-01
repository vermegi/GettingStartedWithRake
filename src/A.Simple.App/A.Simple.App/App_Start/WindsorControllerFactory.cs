using System.Web.Mvc;
using System.Web.Routing;
using System.Web.SessionState;
using Castle.Windsor;

namespace A.Simple.App.App_Start
{
    public class WindsorControllerFactory : IControllerFactory
    {
        WindsorContainer _container;

        public WindsorControllerFactory(WindsorContainer container)
        {
            _container = container;
        }

        public IController CreateController(RequestContext requestContext, string controllerName)
        {
            return _container.Resolve<IController>(string.Format("{0}Controller", controllerName));
        }

        public SessionStateBehavior GetControllerSessionBehavior(RequestContext requestContext, string controllerName)
        {
            return SessionStateBehavior.Default;
        }

        public void ReleaseController(IController controller)
        {
            _container.Release(controller);
        }
    }
}