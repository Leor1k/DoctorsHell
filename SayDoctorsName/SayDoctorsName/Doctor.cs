using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SayDoctorsName
{
    public class Doctor
    {
        public int DoctorId { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string SecondName { get; set; }
        public string LastName { get; set; }
        public DateTime DateStartWork { get; set; }
        public string Speciality { get; set; }
        public string Serial { get; set; }
        public int Number { get; set; }
        public string Issued { get; set; }
        public string Gender { get; set; }
        public string PlaceOdBirth { get; set; }
        public bool Root { get; set; }
        public DateTime DateIssued { get; set; }
        public DateTime DateBirth { get; set; }
        
    }
}
