namespace JsonObjectRead
{
    class Program
    {
        static void Main(string[] args)
        {
            string input = "{'a':{'b':{'c':'d'} }}";
            System.Console.WriteLine(ObjectParser.GetKeyAndValue(input));

            input = "{'x':{'y':{'z':'a'} }}";
            System.Console.WriteLine(ObjectParser.GetKeyAndValue(input));

        }
    }
}
