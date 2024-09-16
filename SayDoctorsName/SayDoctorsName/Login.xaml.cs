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
    /// Логика взаимодействия для Login.xaml
    /// </summary>
    public partial class Login : Window
    {

        public Login()
        {
            InitializeComponent();       
        }
        public string connectString = "Server = (localdb)\\MSSQLLocalDB; Database = BaseForDoctors; Trusted_Connection=True";
        //public string connectString = "Server = DESKTOP-MTC2QH1\\SQLEXPRESS; Database = BaseForDoctors; Trusted_Connection=True";
        private void exit_bt_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (login_tb.Text.Length ==0 || pass_tb.Text.Length == 0)
            {
                eror_tv.Visibility = Visibility.Visible;
            }
            else
            {
                TryEnter();
            }
        }
        private void TryEnter()
        {
            try
            {
                string sqlEx = $"Select Doctor.root, Doctor.DoctorId, Doctor.Login, Doctor.Password,  Doctor.DateStartWork, Speciality.Speciality, Passport.LastName, Serial, Number, Issued, Gender, DateIssued, DateBirth, PlaceOfBirth, Passport.FirstName, Passport.SecondName from Doctor Inner join Passport on Doctor.Passport = Passport.PassportId Inner join Speciality on Doctor.Speciality = Speciality.SpecialityId where Doctor.Login = '{login_tb.Text}' and  Doctor.Password = '{pass_tb.Text}'";
                using (SqlConnection connection = new SqlConnection(connectString))
                {
                    connection.Open();
                    SqlCommand cmd = new SqlCommand(sqlEx, connection);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                Doctor doctor = new Doctor();
                                doctor.Root = reader.GetBoolean(0);
                                doctor.DoctorId = reader.GetInt32(1);
                                doctor.Login = reader.GetString(2);
                                doctor.Password = reader.GetString(3);
                                doctor.DateStartWork = Convert.ToDateTime(reader.GetDateTime(4));
                                doctor.Speciality = reader.GetString(5);
                                doctor.LastName = reader.GetString(6);
                                doctor.Serial = reader.GetString(7);
                                doctor.Number = reader.GetInt32(8);
                                doctor.Issued = reader.GetString(9);
                                doctor.Gender = reader.GetString(10);
                                doctor.DateIssued = Convert.ToDateTime(reader.GetDateTime(11));
                                doctor.DateBirth = Convert.ToDateTime(reader.GetDateTime(12));
                                doctor.PlaceOdBirth = reader.GetString(13);
                                doctor.FirstName = reader.GetString(14);
                                doctor.SecondName = reader.GetString(15);
                                MainMenu gom = new MainMenu(doctor, connectString);
                                gom.Show();
                                Close();
                            }
                        }
                        else
                        {
                            MessageBox.Show("Неправильный логин или пароль");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Возникла ошибка: {ex}");
            }
        }
    }
    
}
