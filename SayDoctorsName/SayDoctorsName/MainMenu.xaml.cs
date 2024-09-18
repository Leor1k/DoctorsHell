using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;


namespace SayDoctorsName
{
    /// <summary>
    /// Логика взаимодействия для MainMenu.xaml
    /// </summary>
    public partial class MainMenu : Window
    {
        public Doctor DoctorWho { get; set; }
        public string ConnectString { get; set; }
        public List<Direction> Direc { get; set; }
        List<Zapic> pricol { get; set; }
        List<SickLeavr> dates { get; set; }
        List<Doctor> specialists { get; set; }
        List <patient> patients { get; set; }
        public int ApId { get; set; }
        public patient SelectedPacient { get; set; }

        public MainMenu(Doctor doctor, string connectionString)
        {
            InitializeComponent();
            dat_tv.Text = DateTime.Now.ToString("dd/MM dddd");
            DoctorWho = doctor;
            ConnectString = connectionString;
            root_grid.Visibility = Visibility.Hidden;
            if (DoctorWho.Root == false)
            {
                root_tv.Visibility = Visibility.Hidden;
                add_specialist.Visibility = Visibility.Hidden;
            }
            fio_tv.Text = $"{fio_tv.Text} {DoctorWho.LastName.Trim()} {DoctorWho.FirstName.Trim()} {DoctorWho.SecondName.Trim()}  ";
            GetPacientData();
            Sick();
            Direction();
            DirectionGrid.Visibility = Visibility.Hidden;
            getAllDoctors();
            appointment_grid.Visibility = Visibility.Hidden;
            new_zapic_to_doctor_grid.Visibility = Visibility.Hidden;
            loadPacient();
        }
        private void exit_bt_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        public void getAllDoctors()
        {
            string sqlEx = $"Select Doctor.root, Doctor.DoctorId, Doctor.Login, Doctor.Password,  Doctor.DateStartWork, Speciality.Speciality, Passport.LastName, Serial, Number, Issued, Gender, DateIssued, DateBirth, PlaceOfBirth, Passport.FirstName, Passport.SecondName from Doctor Inner join Passport on Doctor.Passport = Passport.PassportId Inner join Speciality on Doctor.Speciality = Speciality.SpecialityId";
            using (SqlConnection connection = new SqlConnection(ConnectString))
            {

                connection.Open();
                SqlCommand cmd = new SqlCommand(sqlEx, connection);
                specialists = new List<Doctor>();
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
                            specialists.Add(doctor);
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
        public void Direction()
        {
            string sqlEx = $"Select * from Direction";
            using (SqlConnection connection = new SqlConnection(ConnectString))
            {              
                connection.Open();
                Direc = new List<Direction>();
                SqlCommand cmd = new SqlCommand(sqlEx, connection);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Direction dir = new Direction();
                            dir.Id = reader.GetInt32(0);
                            dir.AppointId = reader.GetInt32(1);
                            try
                            {
                                dir.SeakId = reader.GetInt32(2);
                            }
                            catch 
                            {
                                dir.SeakId = 0;
                            }
                            try
                            {
                                dir.Diagnosis = reader.GetString(3);
                            }
                            catch
                            {
                                dir.Diagnosis = "нет";
                            }
                            try
                            {
                                dir.Rec = reader.GetString(4);
                            }
                            catch
                            {
                                dir.Rec = "нет";
                            }
                            try
                            {
                                dir.Medicines = reader.GetString(5);
                            }
                            catch
                            {
                                dir.Medicines = "нет";
                            }
                            Direc.Add(dir);
                        }
                        dir_grid.ItemsSource = Direc;
                    }
                    else
                    {
                        MessageBox.Show("Неправильный логин или пароль");
                    }
                }
            }
        }
        public void Sick()
        {
            string sqlEx = $"Select * from SickLeave";
            using (SqlConnection connection = new SqlConnection(ConnectString))
            {
                connection.Open();
                dates = new List<SickLeavr>();
                SqlCommand cmd = new SqlCommand(sqlEx, connection);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            SickLeavr sss = new SickLeavr();
                            sss.Id = reader.GetInt32(0);
                            sss.DateStart = Convert.ToDateTime(reader.GetDateTime(1));
                            sss.DateEnd = Convert.ToDateTime(reader.GetDateTime(2));
                            dates.Add(sss);
                        }
                    }
                    else
                    {
                        MessageBox.Show("Неправильный логин или пароль");
                    }
                }
            }
        }
        public void GetPacientData ()
        {
            try
            {
                string sqlEx = $"select Appointment.AppointmentId, Appointment.DateTemeAppoinment, Patient.HealthInsuranceNumber, Passport.FirstName, Passport.LastName, Passport.SecondName from Appointment \r\ninner join Patient on Appointment.Patient = Patient.HealthInsuranceNumber \r\ninner join Passport on Patient.PassportId = Passport.PassportId\r\nwhere Appointment.Doctor = {DoctorWho.DoctorId}";
                using (SqlConnection connection = new SqlConnection(ConnectString))
                {
                    
                    connection.Open();
                    SqlCommand cmd = new SqlCommand(sqlEx, connection);
                    pricol = new List<Zapic>();
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
        private void new_zapic_bt_Click(object sender, RoutedEventArgs e)
        {
            if (pacient_tv.Text == "Пациент: не выбран")
            {
                MessageBox.Show("Сначало выберите пациента");
            }
            else
            {
                mainGrid.Visibility = Visibility.Hidden;
                appointment_grid.Visibility = Visibility.Visible;
                DirectionGrid.Visibility = Visibility.Hidden;
                root_grid.Visibility = Visibility.Hidden;
            }
        }
        private void zapic_today_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Zapic zapic = new Zapic();
            zapic = zapic_today.SelectedItem as Zapic;
            pacient_tv.Text = $"Пациент: {zapic.PatientSecondName}";
            fio_tv1.Text = $"ФИО:{zapic.PatientLastName.Trim()} {zapic.PatientName.Trim()} {zapic.PatientSecondName.Trim()}";
            helth_tv.Text = "Номер полюса:" + zapic.Health;
            ApId = zapic.Appointmet;
            
        }
        private void canel_bt_Click(object sender, RoutedEventArgs e)
        {
            mainGrid.Visibility = Visibility.Visible;
            appointment_grid.Visibility = Visibility.Hidden;
            DirectionGrid.Visibility = Visibility.Hidden;
            root_grid.Visibility = Visibility.Hidden;
            new_zapic_to_doctor_grid.Visibility = Visibility.Hidden;

        }
        private void YepNope_Checked(object sender, RoutedEventArgs e)
        {
            sill_grid.IsEnabled = true;
           
        }
        private void YepNope_Unchecked(object sender, RoutedEventArgs e)
        {
            sill_grid.IsEnabled = false;
            date_end_et.Text = "";
            date_start_et.Text = "";
        }
        public void IsertAppoint()
        {
            string sqlExpression = "";
            if (YepNope.IsChecked == true)
            {
                sqlExpression = $"INSERT INTO [dbo].[SickLeave] ([SickLeaveId], [DateStart], [DateEnd]) VALUES ({dates.Count +1}, N'{returnDateTime(date_start_et.Text)}', N'{date_end_et.Text}')";
                sqlExpression = sqlExpression + $"INSERT INTO [dbo].[Direction] ([DirectionId], [AppointId], [SickLeave], [Diagnosis], [Recimmendation], [Medicines]) VALUES ({Direc.Count+1}, {ApId}, {dates.Count + 1}, N'{diagnoz_tb.Text}', N'{rec_tb.Text}', N'{medicines_tb.Text}')";
            }
            else
            {
                sqlExpression = $"INSERT INTO [dbo].[Direction] ([DirectionId], [AppointId], [SickLeave], [Diagnosis], [Recimmendation], [Medicines]) VALUES ({Direc.Count + 1}, {ApId}, NULL , N'{diagnoz_tb.Text}', N'{rec_tb.Text}', N'{medicines_tb.Text}')";
            }


            using (SqlConnection connection = new SqlConnection(ConnectString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                int number = command.ExecuteNonQuery();
                MessageBox.Show($"Объекты успешно добавленны {number}");
            }
        }
        private void dir_grid_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Direction fir;
            fir = dir_grid.SelectedItem as Direction;
            foreach (var item in pricol)
            {
                if (item.Appointmet == fir.AppointId)
                {
                    fio_patient_tv.Text = $"ФИО Пациента: {item.PatientLastName.Trim()} {item.PatientName.Trim()} {item.PatientSecondName.Trim()}";
                    date_zapic_tv.Text = $"Время записи: {item.DateTimeAppoiment}";
                    diagron_tv.Text = $"Диагноз: {fir.Diagnosis.Trim()}";
                    lech_tv.Text = $"Лечение: {fir.Medicines.Trim()} и {fir.Rec.Trim()}";
                    if (fir.SeakId != 0)
                    {
                        foreach (var dat in dates)
                        {
                            if (dat.Id == fir.SeakId)
                            {
                                sick_lev.Text = $"Больничный c {dat.DateStart.Date} по {dat.DateEnd.Date}";
                            }
                        }
                    }
                    else
                    {
                        sick_lev.Text = $"Больничный не назначен";
                    }
                }
            }
        }
        private void Direction_bt_Click(object sender, RoutedEventArgs e)
        {
            mainGrid.Visibility = Visibility.Hidden;
            appointment_grid.Visibility = Visibility.Hidden;
            DirectionGrid.Visibility = Visibility.Visible;
            root_grid.Visibility = Visibility.Hidden;
            new_zapic_to_doctor_grid.Visibility = Visibility.Hidden;
        }
        private void today_bt_Click(object sender, RoutedEventArgs e)
        {
            mainGrid.Visibility = Visibility.Visible;
            appointment_grid.Visibility = Visibility.Hidden;
            DirectionGrid.Visibility = Visibility.Hidden;
            root_grid.Visibility = Visibility.Hidden;
            new_zapic_to_doctor_grid.Visibility = Visibility.Hidden;
        }
        private void add_specialist_Click(object sender, RoutedEventArgs e)
        {
            mainGrid.Visibility = Visibility.Hidden;
            appointment_grid.Visibility = Visibility.Hidden;
            DirectionGrid.Visibility = Visibility.Hidden;
            root_grid.Visibility = Visibility.Visible;
            specialist_grid.ItemsSource = specialists;
            new_zapic_to_doctor_grid.Visibility = Visibility.Hidden;
        }
        private void create_bt_Click(object sender, RoutedEventArgs e)
        {
            foreach (var item in root_grid.Children )
            {
                if (item.GetType() == typeof(TextBox))
                {
                    TextBox lac = item as TextBox;
                    if (lac.Text.Length == 0)
                    {
                        MessageBox.Show("Все поля обязательны к заполнению");
                        break;
                    }                 
                }
            }
            int passId = 0;
            string sqlEx = $"SELECT MAX(PassportId) from Passport";
            using (SqlConnection connection = new SqlConnection(ConnectString))
            {

                connection.Open();
                SqlCommand cmd = new SqlCommand(sqlEx, connection);            
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            passId = reader.GetInt32(0);
                        }
                    }               
                }
            }
            try
            {
                string sqlExpression = $"INSERT INTO [dbo].[Passport] ([PassportId], [FirstName], [LastName], [SecondName], [Serial], [Number], [Issued], [Gender], [DateIssued], [DateBirth], [PlaceOfBirth]) VALUES ({passId + 1}, N'{firt_name_ed.Text}', N'{LastName_ed.Text}', N'{SecondName_ed.Text}', N'{serial_et.Text} ', {number_et.Text}, N'{issued_ed.Text}', N'{gender_ed.Text}', N'{ returnDateTime(Date_Issued_ed.Text)}', N'{returnDateTime(date_bith_ed.Text)}', N'{propis_ed.Text}')";
                using (SqlConnection connection = new SqlConnection(ConnectString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(sqlExpression, connection);
                    int number = command.ExecuteNonQuery();
                    MessageBox.Show("Паспорт успешно добавлен");
                }
                sqlExpression = $"INSERT INTO [dbo].[Doctor] ([DoctorId], [Speciality], [Passport], [DateStartWork], [Login], [Password], [root]) VALUES ({specialists.Count+1}, 2, {passId+1}, N'{DateTime.Now.ToString("yyyy-MM-dd")}', N'{log_ed.Text}', N'{password_ed.Text}', 0)";
                using (SqlConnection connection = new SqlConnection(ConnectString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(sqlExpression, connection);
                    int number = command.ExecuteNonQuery();
                    MessageBox.Show("Специалист Успешно добавлен");
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show($"Возникла непредвиденная ошибка:({ex})");
            }          
        }
        public string returnDateTime(string kok)
        {
            DateTime dt = DateTime.Now;
            dt = Convert.ToDateTime(kok);
            return dt.ToString("yyyy-MM-dd");
        }
        private void end_appoint_bt_Click(object sender, RoutedEventArgs e)
        {
            IsertAppoint();
        }
        private void zapic_to_priem_Click(object sender, RoutedEventArgs e)
        {
            new_zapic_to_doctor_grid.Visibility = Visibility.Visible;
            mainGrid.Visibility = Visibility.Hidden;
            appointment_grid.Visibility = Visibility.Hidden;
            DirectionGrid.Visibility = Visibility.Hidden;
            root_grid.Visibility = Visibility.Hidden;
        }
        private void loadPacient()
        {
            try
            {
                string sqlEx = $"Select Patient.HealthInsuranceNumber, Passport.FirstName, Passport.LastName, Passport.SecondName from Patient inner join Passport on Patient.PassportId = Passport.PassportId";
                using (SqlConnection connection = new SqlConnection(ConnectString))
                {

                    connection.Open();
                    SqlCommand cmd = new SqlCommand(sqlEx, connection);
                    patients = new List<patient>();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                patient ppp = new patient();
                                ppp.Helth = reader.GetString(0);
                                ppp.Name = reader.GetString(1);
                                ppp.LastName = reader.GetString(2);
                                ppp.SecondName = reader.GetString(3);
                                patients.Add(ppp);
                            }
                        }
                        else
                        {
                            MessageBox.Show("Неправильный логин или пароль");
                        }
                    }
                    data_pacient_grid_dg.ItemsSource = patients;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Возникла ошибка: {ex}");
            }
        }
        private void zapic_Click(object sender, RoutedEventArgs e)
        {
            if (MessageBoxResult.Yes == MessageBox.Show($"Вы действительно хотите записать {SelectedPacient.Name.Trim()} {SelectedPacient.LastName.Trim()} {SelectedPacient.SecondName.Trim()} на {Convert.ToDateTime(calc.SelectedDate).ToString("d")} {Hour_cb.Text}:{minute_cb.Text}?","Записать",MessageBoxButton.YesNo,MessageBoxImage.Question))
            {
                string sqlExpression = $"DECLARE @maxId int = (Select MAX(Appointment.AppointmentId) from Appointment)\nINSERT INTO [dbo].[Appointment] ([AppointmentId], [Doctor], [Patient], [Status], [DateTemeAppoinment]) VALUES (@maxId+1, {DoctorWho.DoctorId}, N'{SelectedPacient.Helth}', 1, N'{secDateTime()}')";
                using (SqlConnection connection = new SqlConnection(ConnectString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(sqlExpression, connection);
                    int number = command.ExecuteNonQuery();
                    MessageBox.Show($"Объекты успешно добавленны {number}");
                }
            }
        }
        private void data_pacient_grid_dg_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            patient zapic = new patient();
            zapic = data_pacient_grid_dg.SelectedItem as patient;
            SelectedPacient = zapic;
        }
        private string secDateTime()
        {
            string a = Convert.ToDateTime(calc.SelectedDate.ToString()).ToString("yyyy-MM-dd") + " " +Hour_cb.Text + ":" + minute_cb.Text + ":" + "00";
            return  Convert.ToDateTime(a).ToString("yyyy-MM-dd HH:mm:ss");
            
        }
    }
}
