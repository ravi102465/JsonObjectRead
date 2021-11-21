using Newtonsoft.Json.Linq;

namespace JsonObjectRead
{
    internal static class ObjectParser
    {
        // Current implement except no siblings on object
        //No sanitation is done on input and parsing. i.e it should be valid json object
        public static string GetKeyAndValue(string nestedObject)
        {
            JObject jObject = JObject.Parse(nestedObject);
            string key = "";
            GetKey(jObject.Last, ref key);
            string value = (string)jObject.SelectToken(key);
            return $"key is {key} and value is {value}";
        }
        private static void GetKey(JToken obj, ref string key)
        {
            if (obj.HasValues == true)
            {
                GetKey(obj.Last, ref key);
            }
            else
            {
                if (string.IsNullOrWhiteSpace(key))
                {
                    key = obj.Path;
                }
            }

        }
    }
}
