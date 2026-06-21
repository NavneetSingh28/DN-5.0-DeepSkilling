using System;

class Employee
{
    public int employeeId;
    public string name;
    public string position;
    public double salary;
}

class Program
{
    static Employee[] employees = new Employee[5];
    static int count = 0;

    static void AddEmployee(Employee e)
    {
        employees[count++] = e;
    }

    static void Traverse()
    {
        for (int i = 0; i < count; i++)
        {
            Console.WriteLine(employees[i].name);
        }
    }

    static void Main(string[] args)
    {
        AddEmployee(new Employee
        {
            employeeId = 1,
            name = "Navneet",
            position = "Developer",
            salary = 50000
        });

        Traverse();
    }
}