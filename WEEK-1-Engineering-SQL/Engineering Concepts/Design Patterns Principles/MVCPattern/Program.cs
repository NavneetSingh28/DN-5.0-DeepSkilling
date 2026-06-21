using System;

class Student
{
    public int Id;
    public string Name;
    public string Grade;
}

class StudentView
{
    public void DisplayStudentDetails(Student student)
    {
        Console.WriteLine("ID: " + student.Id);
        Console.WriteLine("Name: " + student.Name);
        Console.WriteLine("Grade: " + student.Grade);
    }
}

class StudentController
{
    private Student model;
    private StudentView view;

    public StudentController(Student model, StudentView view)
    {
        this.model = model;
        this.view = view;
    }

    public void UpdateView()
    {
        view.DisplayStudentDetails(model);
    }
}

class Program
{
    static void Main(string[] args)
    {
        Student student = new Student();

        student.Id = 1;
        student.Name = "Navneet";
        student.Grade = "A";

        StudentView view = new StudentView();

        StudentController controller =
            new StudentController(student, view);

        controller.UpdateView();
    }
}