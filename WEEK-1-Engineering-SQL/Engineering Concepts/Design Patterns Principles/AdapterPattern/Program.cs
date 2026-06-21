using System;

interface IPaymentProcessor
{
    void ProcessPayment(int amount);
}

class PayPalGateway
{
    public void MakePayment(int amount)
    {
        Console.WriteLine("PayPal Payment: " + amount);
    }
}

class StripeGateway
{
    public void Pay(int amount)
    {
        Console.WriteLine("Stripe Payment: " + amount);
    }
}

class PayPalAdapter : IPaymentProcessor
{
    private PayPalGateway gateway = new PayPalGateway();

    public void ProcessPayment(int amount)
    {
        gateway.MakePayment(amount);
    }
}

class StripeAdapter : IPaymentProcessor
{
    private StripeGateway gateway = new StripeGateway();

    public void ProcessPayment(int amount)
    {
        gateway.Pay(amount);
    }
}

class Program
{
    static void Main(string[] args)
    {
        IPaymentProcessor payment1 = new PayPalAdapter();
        payment1.ProcessPayment(1000);

        IPaymentProcessor payment2 = new StripeAdapter();
        payment2.ProcessPayment(2000);
    }
}