using System;

class Task
{
    public int taskId;
    public string taskName;
    public string status;
    public Task next;
}

class TaskList
{
    Task head = null;

    public void AddTask(int id, string name, string status)
    {
        Task newTask = new Task();

        newTask.taskId = id;
        newTask.taskName = name;
        newTask.status = status;

        newTask.next = head;
        head = newTask;
    }

    public void Traverse()
    {
        Task temp = head;

        while (temp != null)
        {
            Console.WriteLine(temp.taskName);

            temp = temp.next;
        }
    }
}

class Program
{
    static void Main(string[] args)
    {
        TaskList list = new TaskList();

        list.AddTask(1, "Coding", "Pending");
        list.AddTask(2, "Testing", "Completed");

        list.Traverse();
    }
}