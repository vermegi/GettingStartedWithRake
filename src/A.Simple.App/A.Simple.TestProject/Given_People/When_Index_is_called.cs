using System.Collections.Generic;
using A.Simple.App.Controllers;
using A.Simple.App.Controllers.Interfaces;
using A.Simple.Backend.Definition;
using A.Simple.Backend.Definition.Domain;
using A.Simple.TestProject.Util;
using Moq;
using NUnit.Framework;
using MvcContrib.TestHelper;

namespace A.Simple.TestProject.Given_People
{
    public class When_Index_is_called : ControllerTest<IPeopleController>
    {
        Mock<IPeopleService> _peopleService;

        protected override void Arrange()
        {
            _peopleService = new Mock<IPeopleService>();

            List<Person> people = new List<Person>
                                      {
                                          new Person(),
                                          new Person(),
                                          new Person(),
                                          new Person(),
                                          new Person()
                                      };
            _peopleService.Setup(svc => svc.GetPeople())
                .Returns(people);

            _controller = new PeopleController(_peopleService.Object);
        }

        protected override void Act()
        {
            _result = _controller.Index();
        }

        [Test]
        public void Should_get_the_people_from_the_service()
        {
            _peopleService.Verify(svc => svc.GetPeople());
        }

        [Test]
        public void Should_return_the_view()
        {
            _result.AssertViewRendered();
        }

        [Test]
        public void Should_put_the_people_in_the_model()
        {
            _result.AssertViewRendered()
                .Model.ShouldBe<List<Person>>("wrong viewmodel type")
                .Count.ShouldBe(5);
        }
    }
}