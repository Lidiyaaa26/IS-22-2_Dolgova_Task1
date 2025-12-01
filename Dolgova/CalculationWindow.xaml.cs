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

namespace Dolgova
{
    /// <summary>
    /// Логика взаимодействия для CalculationWindow.xaml
    /// </summary>
    public partial class CalculationWindow : Window
    {
        Task_1_DolgovaEntities db = new Task_1_DolgovaEntities();
        public CalculationWindow()
        {
            InitializeComponent();
            LoadTypeProducts();
            LoadTypeMaterial();
        }
        // загрузка типов продукции в список
        private void LoadTypeProducts()
        {
            try
            {
                var typeProduct = db.ProductType.ToList();

                ProductTypeCombo.ItemsSource = typeProduct;
                ProductTypeCombo.DisplayMemberPath = "Name";
                ProductTypeCombo.SelectedValuePath = "ID";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при загрузке типов продукции: " + ex.Message);
            }
        }
        // загрузка типов материала в список
        private void LoadTypeMaterial()
        {
            try
            {
                var typeMaterial = db.MaterialType.ToList();

                MaterialTypeCombo.ItemsSource = typeMaterial;
                MaterialTypeCombo.DisplayMemberPath = "Name";
                MaterialTypeCombo.SelectedValuePath = "ID";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при загрузке типов материала: " + ex.Message);
            }
        }
        private void CalculateButton_Click(object sender, RoutedEventArgs e)
        {
            var calculator = new MaterialCalculator();
             // чтение данных
            int.TryParse(RequiredAmountBox.Text, out int required);
            int.TryParse(StorageAmountBox.Text, out int storage);
            double.TryParse(Param1Box.Text, out double p1);
            double.TryParse(Param2Box.Text, out double p2);

            // полчуение данных 
            var product = ProductTypeCombo.SelectedItem as ProductType;
            var material = MaterialTypeCombo.SelectedItem as MaterialType;

            // расчет
            int result = calculator.Calculate(product, material, required, storage, p1, p2);

            // вывод результата
            ResultText.Text = result == -1 ? "Ошибка данных!" : $"Необходимо материала: {result}";
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            this.Close();
        }
    }
}
