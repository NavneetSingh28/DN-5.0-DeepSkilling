using System;

class Product
{
    public int productId;
    public string productName;
    public string category;
}

class Program
{
    static int LinearSearch(Product[] products, string name)
    {
        for (int i = 0; i < products.Length; i++)
        {
            if (products[i].productName == name)
            {
                return i;
            }
        }

        return -1;
    }

    static int BinarySearch(Product[] products, string name)
    {
        int low = 0;
        int high = products.Length - 1;

        while (low <= high)
        {
            int mid = (low + high) / 2;

            int result =
                string.Compare(products[mid].productName, name);

            if (result == 0)
                return mid;

            if (result < 0)
                low = mid + 1;
            else
                high = mid - 1;
        }

        return -1;
    }

    static void Main(string[] args)
    {
        Product[] products =
        {
            new Product{productId=1,productName="Apple",category="Fruit"},
            new Product{productId=2,productName="Banana",category="Fruit"},
            new Product{productId=3,productName="Mango",category="Fruit"}
        };

        Console.WriteLine(
            "Linear Search: "
            + LinearSearch(products, "Banana"));

        Console.WriteLine(
            "Binary Search: "
            + BinarySearch(products, "Mango"));
    }
}