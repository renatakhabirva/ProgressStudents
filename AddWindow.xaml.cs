using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
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
                    List<SubordinatesSummary> subordinatesList = new List<SubordinatesSummary>();
                    
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
                    
                    db.SaveChanges();
                    ListViewAdd.ItemsSource = db.SubordinatesSummary.Where(ss => ss.SubSummary== newSummaryId).ToList();
                    
                
                MessageBox.Show("Запись успешно добавлена", "Успешно", MessageBoxButton.OK, MessageBoxImage.Information);
                } 
            }  

        }

        private void EditGrade_LostFocus(object sender, RoutedEventArgs e)
        {
            // Получаем ссылку на TextBox, который потерял фокус
            TextBox editGrade = sender as TextBox;

            if (editGrade != null)
            {
                // Получаем данные привязки к этому TextBox'у
                SubordinatesSummary subordinatesSummary = editGrade.DataContext as SubordinatesSummary;

                if (subordinatesSummary != null)
                {
                    // Обновляем значение SubGrade у соответствующей записи
                    subordinatesSummary.SubGrade = editGrade.Text;

                    try
                    {
                        // Сохраняем изменения в базу данных
                        using (var db = new Progress_StudentsEntities())
                        {
                            db.Entry(subordinatesSummary).State = EntityState.Modified;
                            db.SaveChanges();
                        }

                        MessageBox.Show("Изменения сохранены!", "Success");
                    }
                    catch (DbEntityValidationException ex)
                    {
                        StringBuilder sb = new StringBuilder();
                        foreach (var validationErrors in ex.EntityValidationErrors)
                        {
                            foreach (var validationError in validationErrors.ValidationErrors)
                            {
                                sb.AppendLine($"Property: {validationError.PropertyName}, Error: {validationError.ErrorMessage}");
                            }
                        }
                        MessageBox.Show(sb.ToString(), "Ошибка валидации");
                    }
                    catch (Exception exc)
                    {
                        MessageBox.Show(exc.Message, "Ошибка");
                    }
                }
            }
        }
    }
}

