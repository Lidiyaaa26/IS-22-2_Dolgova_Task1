using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dolgova
{
    public class MaterialCalculator
    {
        public int Calculate(
           ProductType productType,
           MaterialType materialType,
           int requiredAmount,
           int storageAmount,
           double param1,
           double param2)
        {
            // Проверка входных данных
            if (productType == null || materialType == null)
                return -1;

            if (requiredAmount < 0 || storageAmount < 0 || param1 <= 0 || param2 <= 0)
                return -1;

            // расход материала на единицу продукции
            double materialPerItem = param1 * param2 * (double)productType.ProductTypeFactor;

            // Учитываем процент брака
            materialPerItem *= (1 + (double)materialType.PercentageOfDefectiveMaterials);

            // Сколько реально нужно произвести
            int needToProduce = requiredAmount - storageAmount;
            if (needToProduce < 0) needToProduce = 0;

            // Полный расход материала
            double total = materialPerItem * needToProduce;

            // Округление вверх
            return (int)Math.Ceiling(total);
        }
    }
}
