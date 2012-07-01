using System.Web.Mvc;

namespace A.Simple.TestProject.Util
{
    public abstract class ControllerTest<T> : AAATest
    {
        protected T _controller;
        protected ActionResult _result;
    }
}