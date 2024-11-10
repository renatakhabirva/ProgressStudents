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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ProgressStudents
{
    /// <summary>
    /// Логика взаимодействия для SummaryPage.xaml
    /// </summary>
    public partial class SummaryPage : Page
    {
        

        public SummaryPage()
        {
            InitializeComponent();
            var _curSub = Progress_StudentsEntities.GetContext().SubordinatesSummary.ToList();
            
            
        }

        private void TextBox_LostFocus(object sender, RoutedEventArgs e)
        {
            if (sender is TextBox textBox && textBox.DataContext is SubordinatesSummary summary)
            {
                summary.SubGrade = textBox.Text;
                
                SaveChangesToDatabase(summary);
            }
        }
        private void SaveChangesToDatabase(SubordinatesSummary summary)
        {
            try
            {
                Progress_StudentsEntities.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена");
                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
    }
}
