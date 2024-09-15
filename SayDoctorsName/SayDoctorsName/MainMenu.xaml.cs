using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace SayDoctorsName
{
    /// <summary>
    /// Логика взаимодействия для MainMenu.xaml
    /// </summary>
    public partial class MainMenu : Window
    {
        public Doctor DoctorWho { get; set; }
        public MainMenu(Doctor doctor)
        {
            InitializeComponent();
            dat_tv.Text = DateTime.Now.ToString("dd/MM dddd");
            DoctorWho = doctor;
            fio_tv.Text = $"{fio_tv.Text} {DoctorWho.LastName.Trim()} {DoctorWho.FirstName.Trim()} {DoctorWho.SecondName.Trim()}  ";
        }

        private void exit_bt_Click(object sender, RoutedEventArgs e)
        {
            this.Close();

        }
    }
}
