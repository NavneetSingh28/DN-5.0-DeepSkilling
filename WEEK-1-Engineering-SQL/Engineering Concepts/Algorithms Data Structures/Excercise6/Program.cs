using System;

class Book
{
    public int bookId;
    public string title;
    public string author;
}

class Program
{
    static int LinearSearch(Book[] books, string title)
    {
        for (int i = 0; i < books.Length; i++)
        {
            if (books[i].title == title)
            {
                return i;
            }
        }

        return -1;
    }

    static void Main(string[] args)
    {
        Book[] books =
        {
            new Book{bookId=1,title="CSharp",author="ABC"},
            new Book{bookId=2,title="Java",author="XYZ"}
        };

        Console.WriteLine(
            LinearSearch(books, "Java"));
    }
}