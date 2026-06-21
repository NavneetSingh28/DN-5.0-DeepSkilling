using System;
using System.Collections.Generic;

interface IObserver
{
    void Update(string stockName, int price);
}

class MobileApp : IObserver
{
    public void Update(string stockName, int price)
    {
        Console.WriteLine(stockName + " price: " + price);
    }
}

class WebApp : IObserver
{
    public void Update(string stockName, int price)
    {
        Console.WriteLine("Web App -> " + stockName + " : " + price);
    }
}

class StockMarket
{
    private List<IObserver> observers = new List<IObserver>();

    public void Register(IObserver observer)
    {
        observers.Add(observer);
    }

    public void Notify(string stockName, int price)
    {
        foreach (var observer in observers)
        {
            observer.Update(stockName, price);
        }
    }
}

class Program
{
    static void Main(string[] args)
    {
        StockMarket market = new StockMarket();

        market.Register(new MobileApp());
        market.Register(new WebApp());

        market.Notify("TCS", 4000);
    }
}