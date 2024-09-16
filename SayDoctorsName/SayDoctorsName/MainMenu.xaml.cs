using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
        public string ConnectString { get; set; }
        public MainMenu(Doctor doctor, string connectionString)
        {
            InitializeComponent();
            dat_tv.Text = DateTime.Now.ToString("dd/MM dddd");
            DoctorWho = doctor;
            ConnectString = connectionString;
            fio_tv.Text = $"{fio_tv.Text} {DoctorWho.LastName.Trim()} {DoctorWho.FirstName.Trim()} {DoctorWho.SecondName.Trim()}  ";
            GetPacientData();
        }
        private void exit_bt_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        public void GetPacientData ()
        {
            try
            {
                string sqlEx = $"select Appointment.AppointmentId, Appointment.DateTemeAppoinment, Patient.HealthInsuranceNumber, Passport.FirstName, Passport.LastName, Passport.SecondName from Appointment \r\ninner join Patient on Appointment.Patient = Patient.HealthInsuranceNumber \r\ninner join Passport on Patient.PassportId = Passport.PassportId\r\nwhere Appointment.Doctor = {DoctorWho.DoctorId}";
                using (SqlConnection connection = new SqlConnection(ConnectString))
                {
                    List<Zapic> pricol = new List<Zapic>();
                    connection.Open();
                    SqlCommand cmd = new SqlCommand(sqlEx, connection);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                Zapic col = new Zapic();
                                col.Appointmet = reader.GetInt32(0);
                                col.DateTimeAppoiment =Convert.ToDateTime(reader.GetDateTime(1));
                                col.Health = reader.GetString(2);
                                col.PatientName = reader.GetString(3);
                                col.PatientLastName = reader.GetString(4);
                                col.PatientSecondName = reader.GetString(5);
                                pricol.Add(col);
                            }
                        }
                        else
                        {
                            MessageBox.Show("Неправильный логин или пароль");
                        }
                    }
                    zapic_today.ItemsSource = pricol;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Возникла ошибка: {ex}");
            }
        }
    }
}
