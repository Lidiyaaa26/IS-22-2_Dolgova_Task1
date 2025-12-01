using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Xml.Linq;



namespace Dolgova
{
    /// <summary>
    /// Логика взаимодействия для PartnerProductsWindow.xaml
    /// </summary>
    public partial class PartnerProductsWindow : Window
    {
        private Task_1_DolgovaEntities db = new Task_1_DolgovaEntities();
        private Partner editingPartner; // текущий редактируемый партнер
        private bool isEditMode = false;
        public event Action DataChanged;
        private Partner partner;
        private bool editMode;




        // Конструктор для добавления нового партнёра
        public PartnerProductsWindow()
        {
            InitializeComponent();
            editingPartner = new Partner();
            isEditMode = false;
            this.DataContext = editingPartner; // привязка данных
            LoadPartnerTypes();
            UpdateButtonsVisibility();
            LoadProductsToCombo();

        }


        // Конструктор для редактирования существующего партнёра
        public PartnerProductsWindow(Partner partner, Task_1_DolgovaEntities context)
        {
            InitializeComponent();
            db = context;           
            editingPartner = partner;
            isEditMode = true;
            DataContext = editingPartner;

            LoadPartnerTypes();
            FillFields();
            LoadPartnerProducts();
            UpdateButtonsVisibility();
            LoadProductsToCombo();
        }
        private void LoadProductsToCombo()
        {
            var products = db.Product.ToList();   
            cbProducts.ItemsSource = products;
            cbProducts.DisplayMemberPath = "Name"; 
            cbProducts.SelectedValuePath = "ID"; 
        }
        // Обновление видимости кнопок
        private void UpdateButtonsVisibility()
        {
            btnAddPartner.Visibility = isEditMode ? Visibility.Collapsed : Visibility.Visible;
            btnSaveChanges.Visibility = isEditMode ? Visibility.Visible : Visibility.Collapsed;
        }
        // заполнение полей для редактирования
        private void FillFields()
        {
            txtName.Text = editingPartner.Name;
            txtDirector.Text = editingPartner.Director;
            txtAddress.Text = editingPartner.LegalAddress;
            txtPhone.Text = editingPartner.Phone;
            txtEmail.Text = editingPartner.Email;
            txtINN.Text = editingPartner.INN;
            txtRating.Text = editingPartner.Rating?.ToString();
            if (editingPartner.PartnerType != 0)
                cbPartnerType.SelectedValue = editingPartner.PartnerType;
        }

        // загрузка типов партнера
        private void LoadPartnerTypes()
        {
            var types = db.PartnerType.ToList();
            cbPartnerType.ItemsSource = types;
            cbPartnerType.DisplayMemberPath = "Name";
            cbPartnerType.SelectedValuePath = "ID";

            if (editingPartner.PartnerType != 0)
                cbPartnerType.SelectedValue = editingPartner.PartnerType;
            else
                cbPartnerType.SelectedIndex = -1;
        }
        // загрузка продуктов партнёра
        private void LoadPartnerProducts()
        {
            if (editingPartner.PartnerProducts == null) return;

            var productsList = editingPartner.PartnerProducts
                .Select(pp => new PartnerProductViewModel
                {
                    PartnerProductEntity = pp,
                    ProductName = pp.Product1?.Name ?? "Неизвестно",
                    Quantity = pp.QuantityOfProducts ?? 0,
                    Price = pp.Product1?.MinimumPriceForPartner ?? 0
                }).ToList();

            productsGrid.ItemsSource = productsList;

            decimal total = productsList.Sum(p => p.Total);
            totalText.Text = $"Итоговая сумма: {total:F2} р.";
        }
        // метод для проверки корректности данных
        private bool ValidateInput()
        {
            // Тип партнёра
            if (cbPartnerType.SelectedValue == null)
            {
                MessageBox.Show("Выберите тип партнера");
                return false;
            }

            // Наименование
            string name = txtName.Text.Trim();
            if (string.IsNullOrWhiteSpace(name))
            {
                MessageBox.Show("Введите наименование партнера");
                return false;
            }

            // Директор
            string director = txtDirector.Text.Trim();
            if (string.IsNullOrWhiteSpace(director) || !director.All(c => char.IsLetter(c) || char.IsWhiteSpace(c)))
            {
                MessageBox.Show("Введите корректное имя директора (только буквы)");
                return false;
            }

            // Адрес
            string address = txtAddress.Text.Trim();
            if (string.IsNullOrWhiteSpace(address))
            {
                MessageBox.Show("Введите юридический адрес");
                return false;
            }

            // Телефон
            string phone = txtPhone.Text.Trim();
            if (!Regex.IsMatch(phone, @"^\+7\s\(\d{3}\)\s\d{3}\s\d{2}\s\d{2}$"))
            {
                MessageBox.Show("Введите телефон в формате +7 (999) 999 99 99");
                return false;
            }

            // Email
            string email = txtEmail.Text.Trim();
            if (string.IsNullOrWhiteSpace(email) || !Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                MessageBox.Show("Введите корректный email");
                return false;
            }

            // ИНН
            string inn = txtINN.Text.Trim();
            if (string.IsNullOrWhiteSpace(inn) || !inn.All(char.IsDigit) || !(inn.Length == 10 || inn.Length == 12))
            {
                MessageBox.Show("Введите корректный ИНН (10 или 12 цифр)");
                return false;
            }

            // Рейтинг
            if (!int.TryParse(txtRating.Text.Trim(), out int rating) || rating < 0)
            {
                MessageBox.Show("Рейтинг должен быть целым неотрицательным числом");
                return false;
            }

            return true;
        }

    
        public class PartnerProductViewModel
        {
            public PartnerProducts PartnerProductEntity { get; set; }
            public string ProductName { get; set; }
            public decimal Quantity { get; set; }
            public decimal Price { get; set; }
            public decimal Total => Quantity * Price;
        }
        // добавление нового партнера 
        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            var partner = new Partner
            {
                Name = txtName.Text.Trim(),
                Director = txtDirector.Text.Trim(),
                LegalAddress = txtAddress.Text.Trim(),
                Phone = txtPhone.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                INN = txtINN.Text.Trim(),
                Rating = int.Parse(txtRating.Text.Trim()),
                PartnerType = (int)cbPartnerType.SelectedValue,

            };

            db.Partner.Add(partner);
            db.SaveChanges();

            MessageBox.Show("Партнёр успешно добавлен");
            DialogResult = true;
            this.Close();
        }
        // сохранение изменений 
        private void BtnSaveChanges_Click(object sender, RoutedEventArgs e)
        {
            if (editingPartner != null)
            {
                if (!ValidateInput()) return;

                editingPartner.Name = txtName.Text.Trim();
                editingPartner.Director = txtDirector.Text.Trim();
                editingPartner.LegalAddress = txtAddress.Text.Trim();
                editingPartner.Phone = txtPhone.Text.Trim();
                editingPartner.Email = txtEmail.Text.Trim();
                editingPartner.INN = txtINN.Text.Trim();
                editingPartner.Rating = int.Parse(txtRating.Text.Trim());
                editingPartner.PartnerType = (int)cbPartnerType.SelectedValue;


                db.SaveChanges();

                MessageBox.Show("Партнёр успешно обновлён");
                DialogResult = true;
                this.Close();
            }
        }
        private void DeleteProduct_Click(object sender, RoutedEventArgs e)
        {
            if (productsGrid.SelectedItem is PartnerProductViewModel selectedVM)
            {
                if (MessageBox.Show($"Удалить продукт '{selectedVM.ProductName}' у партнера?",
                                    "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Warning) == MessageBoxResult.Yes)
                {
                    db.PartnerProducts.Remove(selectedVM.PartnerProductEntity);
                    db.SaveChanges();

                    LoadPartnerProducts(); // обновляем таблицу

                    DataChanged?.Invoke();

                }
            }
        }



        private void BtnAddProduct_Click(object sender, RoutedEventArgs e)
        {
            // Проверка выбранного товара
            var product = cbProducts.SelectedItem as Product;
            if (product == null)
            {
                MessageBox.Show("Выберите продукт");
                return;
            }

            // Проверка количества
            decimal qty;
            if (!decimal.TryParse(txtQty.Text, out qty) || qty <= 0)
            {
                MessageBox.Show("Введите корректное количество");
                return;
            }


            var newRecord = new PartnerProducts
            {
                Partner = editingPartner.ID,
                Product = product.ID,
                QuantityOfProducts = (int)qty
            };

            db.PartnerProducts.Add(newRecord);
            db.SaveChanges();

            LoadPartnerProducts();
            DataChanged?.Invoke();
        }
        private void productsGrid_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {
            if (e.EditAction == DataGridEditAction.Commit)
            {
                var editedVM = e.Row.Item as PartnerProductViewModel;
                if (editedVM != null)
                {
                    editedVM.PartnerProductEntity.QuantityOfProducts = (int)editedVM.Quantity;
                    db.Entry(editedVM.PartnerProductEntity).State = EntityState.Modified;

                    db.SaveChanges();
                }

                // Пересчёт итога
                var productsList = productsGrid.ItemsSource.Cast<PartnerProductViewModel>();
                decimal total = productsList.Sum(p => p.Total);
                totalText.Text = $"Итоговая сумма: {total:F2} р.";

                DataChanged?.Invoke();
            }
        }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            if (editingPartner != null)
            {
                if (!ValidateInput()) return;

                editingPartner.Name = txtName.Text.Trim();
                editingPartner.Director = txtDirector.Text.Trim();
                editingPartner.LegalAddress = txtAddress.Text.Trim();
                editingPartner.Phone = txtPhone.Text.Trim();
                editingPartner.Email = txtEmail.Text.Trim();
                editingPartner.INN = txtINN.Text.Trim();
                editingPartner.Rating = int.Parse(txtRating.Text.Trim());
                editingPartner.PartnerType = (int)cbPartnerType.SelectedValue;


                db.SaveChanges();

                DataChanged?.Invoke();

                MessageBox.Show("Партнёр успешно обновлён");
                DialogResult = true;
                this.Close();
            }
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
