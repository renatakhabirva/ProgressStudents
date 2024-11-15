﻿using System;
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
    /// Логика взаимодействия для ListPage.xaml
    /// </summary>
    public partial class ListPage : Page
    {
        public int CountRecords { get; set; }

        public ListPage()
        {
            InitializeComponent();
            
            var currentListPage = Progress_StudentsEntities.GetContext().Summary.ToList();
            SummaryList.ItemsSource = currentListPage;
            SortCB.SelectedIndex = 0;
            ComboType.SelectedIndex = 0;
            UpdateSummary();
        }
        
        private void UpdateSummary()
        {

            List<Summary> currentListPage = Progress_StudentsEntities.GetContext().Summary.ToList();
            currentListPage = currentListPage.Where(p => p.Discipline.DisciplineName.ToLower().Contains(SearchTB.Text.ToLower())).ToList();
            SummaryList.ItemsSource = currentListPage;
            CountRecords = currentListPage.Count;
            if (SortCB.SelectedIndex == 1)
            {
                currentListPage = currentListPage.Where(p => (p.SummarySemester == 1 || p.SummarySemester == 2)).ToList();
            }
            if (SortCB.SelectedIndex == 2)
            {
                currentListPage = currentListPage.Where(p => (p.SummarySemester == 3 || p.SummarySemester == 4)).ToList();
            }
            if (SortCB.SelectedIndex == 3)
            {
                currentListPage = currentListPage.Where(p => (p.SummarySemester == 5 || p.SummarySemester == 6)).ToList();
            }
            if (SortCB.SelectedIndex == 4)
            {
                currentListPage = currentListPage.Where(p => (p.SummarySemester == 7 || p.SummarySemester == 8)).ToList();
            }
            if (SortCB.SelectedIndex == 5)
            {
                currentListPage = currentListPage.Where(p => (p.SummarySemester == 9 || p.SummarySemester == 10)).ToList();
            }
            if (ComboType.SelectedIndex == 0)
            {
                currentListPage = currentListPage.OrderBy(p => p.Class.ClassName).ToList();
            }
            if (ComboType.SelectedIndex == 1) 
            { 
                currentListPage = currentListPage.OrderByDescending(p => p.Class.ClassName).ToList();
            }
            SummaryList.ItemsSource = currentListPage;
            SummaryList.Items.Refresh();
            CountTB.Text = currentListPage.Count.ToString() + " из " + CountRecords.ToString();
            
        }
        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateSummary();
        }

        private void ComboType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateSummary();
        }

        private void SortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateSummary();
        }

        private void TextBox_LostFocus(object sender, RoutedEventArgs e)
        {
            if (sender is TextBox textBox && textBox.DataContext is SubordinatesSummary summary)
            {
                summary.SubGrade = textBox.Text;
                UpdateSummary();
                SaveChangesToDatabase(summary);
            }
        }

        private void SaveChangesToDatabase(SubordinatesSummary summary)
        {
            try
            {
                Progress_StudentsEntities.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена");
                /*using (var context = Progress_StudentsEntities.GetContext())
                {
                    var entity = context.SubordinatesSummary.FirstOrDefault(s => s.SubID == summary.SubID);
                    if (entity != null && entity.SubGrade != summary.SubGrade)
                    {
                        entity.SubGrade = summary.SubGrade;
                        context.SaveChanges();
                    }
                }*/
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            if (SummaryList.SelectedItem is Summary selectedSummary)
            {
                try
                {
                    using (var db = new Progress_StudentsEntities())
                    {
                        // Reload selected summary entity to ensure it is tracked in the current context
                        var summaryToRemove = db.Summary.Find(selectedSummary.SummaryID);

                        if (summaryToRemove != null)
                        {
                            // Remove related SubordinatesSummary entries
                            db.SubordinatesSummary.RemoveRange(db.SubordinatesSummary.Where(ss => ss.SubSummary == summaryToRemove.SummaryID));

                            // Remove the Summary entry
                            db.Summary.Remove(summaryToRemove);

                            // Save changes to commit the deletions
                            db.SaveChanges();

                            MessageBox.Show("Запись и связанные данные успешно удалены.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);

                            // Refresh the list after deletion
                            UpdateSummary();
                            
                        }
                        else
                        {
                            MessageBox.Show("Выбранная запись не найдена.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Ошибка при удалении данных: {ex.Message}");
                    MessageBox.Show("Произошла ошибка при удалении данных.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else
            {
                MessageBox.Show("Пожалуйста, выберите запись для удаления.", "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            UpdateSummary();
        }
        
        
        private void AddSummaryButton_Click(object sender, RoutedEventArgs e)
        {
            new AddWindow().Show();
            
        }
    }
}
