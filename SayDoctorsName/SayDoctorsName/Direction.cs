using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SayDoctorsName
{
    public class Direction
    {
        public int Id { get; set; }
        public int AppointId { get; set; }
        public int? SeakId { get; set; }
        public string Diagnosis { get; set;}
        public string Rec { get; set; }
        public string Medicines { get; set; }
    }
}
