using System;

interface ICommand
{
    void Execute();
}

class Light
{
    public void On()
    {
        Console.WriteLine("Light ON");
    }

    public void Off()
    {
        Console.WriteLine("Light OFF");
    }
}

class LightOnCommand : ICommand
{
    private Light light;

    public LightOnCommand(Light light)
    {
        this.light = light;
    }

    public void Execute()
    {
        light.On();
    }
}

class LightOffCommand : ICommand
{
    private Light light;

    public LightOffCommand(Light light)
    {
        this.light = light;
    }

    public void Execute()
    {
        light.Off();
    }
}

class RemoteControl
{
    private ICommand command;

    public void SetCommand(ICommand command)
    {
        this.command = command;
    }

    public void PressButton()
    {
        command.Execute();
    }
}

class Program
{
    static void Main(string[] args)
    {
        Light light = new Light();

        RemoteControl remote = new RemoteControl();

        remote.SetCommand(new LightOnCommand(light));
        remote.PressButton();

        remote.SetCommand(new LightOffCommand(light));
        remote.PressButton();
    }
}