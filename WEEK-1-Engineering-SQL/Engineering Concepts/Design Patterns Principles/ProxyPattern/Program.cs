using System;

interface IImage
{
    void Display();
}

class RealImage : IImage
{
    private string fileName;

    public RealImage(string fileName)
    {
        this.fileName = fileName;
        LoadImage();
    }

    private void LoadImage()
    {
        Console.WriteLine("Loading image: " + fileName);
    }

    public void Display()
    {
        Console.WriteLine("Displaying image: " + fileName);
    }
}

class ProxyImage : IImage
{
    private RealImage realImage;
    private string fileName;

    public ProxyImage(string fileName)
    {
        this.fileName = fileName;
    }

    public void Display()
    {
        if (realImage == null)
        {
            realImage = new RealImage(fileName);
        }

        realImage.Display();
    }
}

class Program
{
    static void Main(string[] args)
    {
        IImage image = new ProxyImage("photo.jpg");

        image.Display();
        image.Display();
    }
}