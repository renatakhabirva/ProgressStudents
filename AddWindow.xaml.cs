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

namespace ProgressStudents
{
    /// <summary>
    /// Логика взаимодействия для AddWindow.xaml
    /// </summary>
    public partial class AddWindow : Window
    {
        List<Summary> selectedSummary = new List<Summary>();
        private Summary summary = new Summary();


        public AddWindow()
        {
            InitializeComponent();
            
            //SummaryFrame.Navigate(new SummaryPage());
            //MainClass.SummaryFrame = SummaryFrame;
            this.DataContext = Progress_StudentsEntities.GetContext();
            var currentClass = Progress_StudentsEntities.GetContext().Class.ToList();
            ClassCB.ItemsSource = currentClass.Select(x => $"{ x.ClassName}");
            /*var currentDiscipline = Progress_StudentsEntities.GetContext().Discipline.ToList();
            DisciplineCB.ItemsSource = currentDiscipline.Select(x => $"{x.DisciplineName}");
            var currentTeacher = Progress_StudentsEntities.GetContext().Teachers.ToList();
            TeacherCB.ItemsSource = currentTeacher.Select(x => $"{x.TeacherFullName}");*/
        }
        

        private void Button_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
