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
using System.Data.Entity;
using System.Windows.Shapes;

namespace Dolgova
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Task_1_DolgovaEntities db = new Task_1_DolgovaEntities();
        public MainWindow()
        {
            InitializeComponent();
            partnerList.MouseRightButtonUp += partnerList_MouseDoubleClick; // обработчик события

        }
        // метод для загрузки партнеров
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            RefreshPartners();
        }
        // двойное нажатие на элемент
        private void partnerList_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (partnerList.SelectedItem is PartnerViewModel selected)
            {
                // поиск партнера по ID
                var partner = db.Partner.FirstOrDefault(p => p.ID == selected.ID);
                if (partner != null)
                {
                    PartnerProductsWindow editWindow = new PartnerProductsWindow(partner, db);
                    editWindow.DataChanged += RefreshPartners;
                    editWindow.ShowDialog();

                }
            }
        }


        private void RefreshPartners()
        {
            try
            {
                var partnersData =
                    db.Partner
                    .Select(p => new
                    {
                        Partner = p,
                        TypeName = p.PartnerType1.Name,
                        PartnerProducts = p.PartnerProducts
                    })
                    .AsEnumerable() 
                    .Select(p => new PartnerViewModel
                    {
                        ID = p.Partner.ID,
                        Type = p.TypeName,
                        Name = p.Partner.Name,
                        LegalAddress = p.Partner.LegalAddress,
                        Phone = p.Partner.Phone,
                        Rating = p.Partner.Rating,

                        TotalCost = p.PartnerProducts.Sum(pp =>
                        {
                            // количество товаров 
                            decimal qty = pp.QuantityOfProducts ?? 0;

                            // получаем продукции
                            var product = db.Product.FirstOrDefault(pr => pr.ID == pp.Product);

                            // минимальная цена для партнера
                            decimal price = product?.MinimumPriceForPartner ?? 0m;

                            return qty * price;
                        })
                    })
                    .ToList();

                partnerList.ItemsSource = partnersData;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка при загрузке партнёров: " + ex.Message);
            }
        }
        public class PartnerViewModel
        {
            public int ID { get; set; }
            public string Type { get; set; }
            public string Name { get; set; }
            public string LegalAddress { get; set; }
            public string Phone { get; set; }
            public int? Rating { get; set; }


            public decimal TotalCost { get; set; } // Стоимость всех заявок
        }

        private void AddPartnerButton_Click(object sender, RoutedEventArgs e)
        {
            PartnerProductsWindow form = new PartnerProductsWindow();
            if (form.ShowDialog() == true)
            {
                // обновление формы после редактирования 
                RefreshPartners();
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            CalculationWindow calculationWindow = new CalculationWindow();
            calculationWindow.Show();
            this.Close();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            ProductCatalogWindow productCatalogWindow = new ProductCatalogWindow();
            productCatalogWindow.Show();
            this.Close();
        }
    }
}
