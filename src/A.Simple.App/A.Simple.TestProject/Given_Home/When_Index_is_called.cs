using System.Web.Mvc;
using A.Simple.App.Controllers;
using A.Simple.App.Controllers.Interfaces;
using A.Simple.TestProject.Util;
using NUnit.Framework;
using MvcContrib.TestHelper;

namespace A.Simple.TestProject.Given_Home
{
    [TestFixture]
    public class When_Index_is_called : ControllerTest<IHomeController>
    {
        protected override void Arrange()
        {
            _controller = new HomeController();
        }

        protected override void Act()
        {
            _result = _controller.Index();
        }

        [Test]
        public void Should_return_the_view()
        {
            _result.AssertViewRendered();
        }
    }
}