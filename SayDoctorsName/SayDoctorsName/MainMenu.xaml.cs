using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Windows;
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

        public MainMenu(Doctor doctor, string connectionString)
        {
            InitializeComponent();
            dat_tv.Text = DateTime.Now.ToString("dd/MM dddd");
            DoctorWho = doctor;
            ConnectString = connectionString;
            fio_tv.Text = $"{fio_tv.Text} {DoctorWho.LastName.Trim()} {DoctorWho.FirstName.Trim()} {DoctorWho.SecondName.Trim()}  ";
            GetPacientData();
            Sick();
            Direction();
            DirectionGrid.Visibility = Visibility.Hidden;
        }
        private void exit_bt_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
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
            }
        }
        private void zapic_today_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            Zapic zapic = new Zapic();
            zapic = zapic_today.SelectedItem as Zapic;
            pacient_tv.Text = $"Пациент: {zapic.PatientSecondName}";
            fio_tv1.Text = $"ФИО:{zapic.PatientLastName.Trim()} {zapic.PatientName.Trim()} {zapic.PatientSecondName.Trim()}";
            helth_tv.Text = "Номер полюса:" + zapic.Health;
        }
        private void canel_bt_Click(object sender, RoutedEventArgs e)
        {
            mainGrid.Visibility = Visibility.Visible;
            appointment_grid.Visibility = Visibility.Hidden;
            DirectionGrid.Visibility = Visibility.Hidden;

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
            string sqlExpression = $"INSERT INTO [dbo].[Direction] ([DirectionId], [SickLeave], [Diagnosis], [Recimmendation], [Medicines]) VALUES (1, NULL, N'Рак', N'Отдых', N'Тримбалончик')";

            using (SqlConnection connection = new SqlConnection(ConnectString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(sqlExpression, connection);
                int number = command.ExecuteNonQuery();
                Console.WriteLine($"Добавлено объектов: {number}");
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
        }
        private void today_bt_Click(object sender, RoutedEventArgs e)
        {
            mainGrid.Visibility = Visibility.Visible;
            appointment_grid.Visibility = Visibility.Hidden;
            DirectionGrid.Visibility = Visibility.Hidden;
        }
    }
}
