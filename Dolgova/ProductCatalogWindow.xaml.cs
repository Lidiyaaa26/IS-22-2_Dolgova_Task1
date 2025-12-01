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
    /// Логика взаимодействия для ProductCatalogWindow.xaml
    /// </summary>
    public partial class ProductCatalogWindow : Window
    {
        Task_1_DolgovaEntities db = new Task_1_DolgovaEntities();
        public ProductCatalogWindow()
        {
            InitializeComponent();
            LoadProductTypes();
            LoadProducts();
        }
        // загрузка типов продукции
        private void LoadProductTypes()
        {
            var types = db.ProductType.ToList();
            cbProductType.ItemsSource = types;
            types.Insert(0, new ProductType { ID = 0, Name = "Вся продукция" });

            cbProductType.SelectedIndex = -1; // по умолчанию  ничего не выбрано
        }
        // Загрузка продукции 
        private void LoadProducts(int? productTypeId = null)
        {
            var productsQuery = db.Product.AsQueryable();

            if (productTypeId.HasValue)
                productsQuery = productsQuery.Where(p => p.ProductType == productTypeId.Value);

            var productList = productsQuery
                .Select(p => new ProductViewModel
                {
                    ProductEntity = p,
                    Name = p.Name,
                    Quantity = p.PartnerProducts.Sum(pp => (decimal?)(pp.QuantityOfProducts ?? 0)) ?? 0m, 
                    Price = (decimal)p.MinimumPriceForPartner

                })
                .ToList();

            productsGrid.ItemsSource = productList;
        }

        // Событие при выборе типа продукции
        private void CbProductType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbProductType.SelectedValue != null && (int)cbProductType.SelectedValue != 0)
                LoadProducts((int)cbProductType.SelectedValue);
            else
                LoadProducts(); 
        }


        // Модель для отображения
        public class ProductViewModel
        {
            public Product ProductEntity { get; set; }
            public string Name { get; set; }
            public decimal Quantity { get; set; }
            public decimal Price { get; set; }
            public decimal Total => Quantity * Price;
        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            this.Close();
        }
    }
}
