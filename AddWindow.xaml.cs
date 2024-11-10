using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
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

namespace ProgressStudents
{
    /// <summary>
    /// Логика взаимодействия для AddWindow.xaml
    /// </summary>
    public partial class AddWindow : Window
    {
        private Summary _currentSummary = new Summary();
        
        public AddWindow( )
        {
            InitializeComponent();
            SummaryFrame.Navigate(new SummaryPage());
            MainClass.SummaryFrame = SummaryFrame;
            DataContext = _currentSummary;
            var currentClass = Progress_StudentsEntities.GetContext().Class.ToList();
            ClassCB.ItemsSource = currentClass.Select(x => $"{x.ClassName}");
            var currentDiscipline = Progress_StudentsEntities.GetContext().Discipline.ToList();
            DisciplineCB.ItemsSource = currentDiscipline.Select(x => $"{x.DisciplineName}");
            var currentTeacher = Progress_StudentsEntities.GetContext().Teachers.ToList();
            TeacherCB.ItemsSource = currentTeacher.Select(x => $"{x.TeacherFullName}");

        }
       
       
       
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            //проверка на пустоту полей
            bool IsComboBoxEmpty(ComboBox cb)
            {
                return cb.SelectedIndex == -1 && string.IsNullOrWhiteSpace(cb.Text);
            }
            if (IsComboBoxEmpty(DisciplineCB))
            {
                MessageBox.Show("Выберите дисциплину", "Error");
                return;
            }

            if (IsComboBoxEmpty(ClassCB))
            {
                MessageBox.Show("Выберите группу", "Error");
                return;
            }
            if (IsComboBoxEmpty(TeacherCB))
            {
                MessageBox.Show("Выберите преподавателя", "Error");
                return;
            }
            if (SemesterTB.Text == "" || Convert.ToInt32(SemesterTB.Text) == 0)
                MessageBox.Show("Укажите семестр ", "Error");
            else
            {
                
                //добавление новой записи в таблицу Summary
                if (_currentSummary.SummaryID == 0)
                {
                    Progress_StudentsEntities.GetContext().Summary.Add(_currentSummary);
                }
                try
                {
                    Progress_StudentsEntities.GetContext().SaveChanges();
                    MessageBox.Show("Информация сохранена!");
                }
                catch (Exception ex) 
                {
                    MessageBox.Show(ex.Message.ToString(), "Error");
                }         

            }
        
        }
        
    }




}
