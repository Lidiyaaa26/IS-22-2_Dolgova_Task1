using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dolgova
{
    public class PartnerProductViewModel : INotifyPropertyChanged
    {
        public PartnerProducts PartnerProductEntity { get; set; }
        public string ProductName { get; set; }

        private decimal quantity;
        public decimal Quantity
        {
            get => quantity;
            set
            {
                if (quantity != value)
                {
                    quantity = value;
                    OnPropertyChanged(nameof(Quantity));
                    OnPropertyChanged(nameof(Total));
                }
            }
        }

        public decimal Price { get; set; }
        public decimal Total => Quantity * Price;

        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged(string prop) =>
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
    }


}
