using System;

interface IPaymentStrategy
{
    void Pay(int amount);
}

class CreditCardPayment : IPaymentStrategy
{
    public void Pay(int amount)
    {
        Console.WriteLine("Paid using Credit Card: " + amount);
    }
}

class PayPalPayment : IPaymentStrategy
{
    public void Pay(int amount)
    {
        Console.WriteLine("Paid using PayPal: " + amount);
    }
}

class PaymentContext
{
    private IPaymentStrategy strategy;

    public PaymentContext(IPaymentStrategy strategy)
    {
        this.strategy = strategy;
    }

    public void ExecutePayment(int amount)
    {
        strategy.Pay(amount);
    }
}

class Program
{
    static void Main(string[] args)
    {
        PaymentContext payment =
            new PaymentContext(new PayPalPayment());

        payment.ExecutePayment(3000);
    }
}