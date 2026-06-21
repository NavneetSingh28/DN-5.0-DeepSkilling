using System;

class Order
{
    public int orderId;
    public string customerName;
    public double totalPrice;
}

class Program
{
    static void BubbleSort(Order[] orders)
    {
        for (int i = 0; i < orders.Length - 1; i++)
        {
            for (int j = 0; j < orders.Length - i - 1; j++)
            {
                if (orders[j].totalPrice >
                    orders[j + 1].totalPrice)
                {
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                }
            }
        }
    }

    static void Main(string[] args)
    {
        Order[] orders =
        {
            new Order{orderId=1,customerName="A",totalPrice=500},
            new Order{orderId=2,customerName="B",totalPrice=200}
        };

        BubbleSort(orders);

        foreach (Order o in orders)
        {
            Console.WriteLine(o.orderId + " " + o.totalPrice);
        }
    }
}