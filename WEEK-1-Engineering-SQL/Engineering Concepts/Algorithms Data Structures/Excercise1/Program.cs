using System;
using System.Collections.Generic;

class Product
{
    public int productId;
    public string productName;
    public int quantity;
    public double price;
}

class Program
{
    static Dictionary<int, Product> inventory =
        new Dictionary<int, Product>();

    static void AddProduct(Product p)
    {
        inventory[p.productId] = p;
    }

    static void UpdateProduct(int id, int quantity)
    {
        if (inventory.ContainsKey(id))
        {
            inventory[id].quantity = quantity;
        }
    }

    static void DeleteProduct(int id)
    {
        inventory.Remove(id);
    }

    static void Display()
    {
        foreach (var item in inventory.Values)
        {
            Console.WriteLine(item.productId + " "
                + item.productName + " "
                + item.quantity + " "
                + item.price);
        }
    }

    static void Main(string[] args)
    {
        Product p1 = new Product();

        p1.productId = 1;
        p1.productName = "Laptop";
        p1.quantity = 10;
        p1.price = 50000;

        AddProduct(p1);

        UpdateProduct(1, 20);

        Display();

        DeleteProduct(1);
    }
}