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
        List<SubordinatesSummary> selectedSummary = new List<SubordinatesSummary>();
        
        public AddWindow( )
        {
            InitializeComponent();
            MainClass.SummaryFrame = SummaryFrame;
            SummaryFrame.Navigate(new SummaryPage());
            
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

                int classId = ClassCB.SelectedIndex + 1; 
                int disciplineId = DisciplineCB.SelectedIndex + 1;
                int teacherId = TeacherCB.SelectedIndex + 1;

                // Получаем значение из TextBox'a
                int semesterValue = Convert.ToInt32(SemesterTB.Text);

                // Создаем новую запись в Summary
                using (var db = new Progress_StudentsEntities())
                {
                    var newSummary = new Summary()
                    {
                        SummaryClass = classId,
                        SummaryDiscipline = disciplineId,
                        SummaryTeacher = teacherId,
                        SummarySemester = semesterValue
                    };
                    db.Summary.Add(newSummary);
                    db.SaveChanges();

                    int newSummaryId = newSummary.SummaryID;

                    var studentsInClass = db.Students.Where(s => s.StudentClass == classId).ToList();
                    foreach (var student in studentsInClass)
                    {
                        var newSubordinate = new SubordinatesSummary()
                        {
                            SubSummary = newSummaryId,
                            SubStudent = student.StudentID,
                            SubGrade = "Введите оценку"
                        };
                        db.SubordinatesSummary.Add(newSubordinate);
                    }
                    
                    db.SaveChanges();  // Save all new SubordinatesSummary entries
                                       //SummaryFrame.Visibility = Visibility.Visible;
                    var newSubordinate1 = new SubordinatesSummary(/* параметры */);

                    // Отображаем SummaryPage в текущем окне AddWindow
                    ShowSummaryPage(newSubordinate1);


                    MessageBox.Show("Запись успешно добавлена", "Успешно", MessageBoxButton.OK, MessageBoxImage.Information);
                }
                
            }  
            

        }
        
        
    }
}

