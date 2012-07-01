using System.Web;
using System.Web.Mvc;
using A.Simple.App.App_Start;
using A.Simple.App.Controllers;
using A.Simple.App.Controllers.Interfaces;
using A.Simple.BackEnd;
using A.Simple.Backend.Definition;
using Castle.MicroKernel.Registration;
using Castle.Windsor;

[assembly: PreApplicationStartMethod(typeof(WindsorBootstrapper), "PreStart")]
namespace A.Simple.App.App_Start
{
    public static class WindsorBootstrapper
    {
        public static void PreStart()
        {
            var container = new WindsorContainer();

            container.Register(Component.For<IPeopleService>()
                                   .ImplementedBy<PeopleService>());

            container.Register(Classes.FromThisAssembly()
                                    .BasedOn<IController>()
                                    .WithServiceAllInterfaces()
                                    .Configure(c => c.Named(c.Implementation.Name))
                                    .LifestyleTransient());

            ControllerBuilder.Current.SetControllerFactory(new WindsorControllerFactory(container));
        }
    }
}