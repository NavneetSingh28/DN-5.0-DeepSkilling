using System;

class Program
{
    static void Main()
    {
        Logger log1 = Logger.GetInstance();
        Logger log2 = Logger.GetInstance();

        log1.Log("Singleton Pattern Example");

        if (log1 == log2)
        {
            Console.WriteLine("Only one object created");
        }
        else
        {
            Console.WriteLine("Multiple objects created");
        }
    }
}