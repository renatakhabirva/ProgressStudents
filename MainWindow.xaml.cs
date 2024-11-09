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
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        List<Summary> selectedSummary = new List<Summary>();
        private Summary summary = new Summary();
        public MainWindow()
        {
            InitializeComponent();
            MainClass.MainFrame = MainFrame;
            MainFrame.Navigate(new ListPage());
            
            
        }

        private void AddSummaryButton_Click(object sender, RoutedEventArgs e)
        {
             

        }
    }
}
