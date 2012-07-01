using System.Collections.Generic;
using A.Simple.Backend.Definition;
using A.Simple.Backend.Definition.Domain;

namespace A.Simple.BackEnd
{
    public class PeopleService : IPeopleService
    {
        public List<Person> GetPeople()
        {
            return new List<Person>
                       {
                           new Person
                               {
                                   Name = "Joske"
                               },                           
                               new Person
                               {
                                   Name = "Jefke"
                               },                           
                               new Person
                               {
                                   Name = "Janneke"
                               },                           
                               new Person
                               {
                                   Name = "Mieke"
                               },
                       };
        }
    }
}