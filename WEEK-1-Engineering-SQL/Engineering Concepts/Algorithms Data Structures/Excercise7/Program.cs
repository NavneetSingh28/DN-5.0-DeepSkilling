using System;

class Program
{
    static double FutureValue(
        double amount,
        double rate,
        int years)
    {
        if (years == 0)
        {
            return amount;
        }

        return FutureValue(
            amount * (1 + rate),
            rate,
            years - 1);
    }

    static void Main(string[] args)
    {
        double result =
            FutureValue(1000, 0.10, 3);

        Console.WriteLine(
            "Future Value: " + result);
    }
}