using System;

class Computer
{
    public string CPU;
    public int RAM;
    public int Storage;

    private Computer(Builder builder)
    {
        CPU = builder.CPU;
        RAM = builder.RAM;
        Storage = builder.Storage;
    }

    public void Show()
    {
        Console.WriteLine("CPU: " + CPU);
        Console.WriteLine("RAM: " + RAM + "GB");
        Console.WriteLine("Storage: " + Storage + "GB");
    }

    public class Builder
    {
        public string CPU;
        public int RAM;
        public int Storage;

        public Builder SetCPU(string cpu)
        {
            CPU = cpu;
            return this;
        }

        public Builder SetRAM(int ram)
        {
            RAM = ram;
            return this;
        }

        public Builder SetStorage(int storage)
        {
            Storage = storage;
            return this;
        }

        public Computer Build()
        {
            return new Computer(this);
        }
    }
}

class Program
{
    static void Main(string[] args)
    {
        Computer pc = new Computer.Builder()
            .SetCPU("Intel i7")
            .SetRAM(16)
            .SetStorage(512)
            .Build();

        pc.Show();
    }
}