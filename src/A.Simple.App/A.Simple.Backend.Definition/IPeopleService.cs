using System.Collections.Generic;
using A.Simple.Backend.Definition.Domain;

namespace A.Simple.Backend.Definition
{
    public interface IPeopleService
    {
        List<Person> GetPeople();
    }
}