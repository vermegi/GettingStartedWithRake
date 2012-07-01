using NUnit.Framework;

namespace A.Simple.TestProject.Util
{
    [TestFixture]
    public abstract class AAATest
    {
        [TestFixtureSetUp]
        public void Setup()
        {
            Arrange();
            Act();
        }

        protected abstract void Act();

        protected abstract void Arrange();
    }
}