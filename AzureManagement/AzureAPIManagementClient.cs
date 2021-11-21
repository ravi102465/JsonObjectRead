using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading;
using System.Threading.Tasks;

namespace AzureManagement
{
    public class AzureAPIManagementClient
    {
        static readonly HttpClient httpClient = new HttpClient();
        readonly string apiVersion = "2021-07-01";
        public async Task<string> GetVirtualMachineMetaData(string vMName, string resourceGroup, string subscriptionId, string accessToken, string key = default)
        {

            string uri = $"https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/{vMName}?api-version={apiVersion}";

            using var httpRequestMessage = new HttpRequestMessage(HttpMethod.Get, uri);
            httpRequestMessage.Headers.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

            var httpResponseMessage = await httpClient.SendAsync(httpRequestMessage, CancellationToken.None);

            string bodyJson = await httpResponseMessage.Content.ReadAsStringAsync();
            JObject jObject = JObject.Parse(bodyJson);
            string data;
            if (key != null)
            {
                data = (string)jObject.SelectToken(key);   
                if (data ==null)
                {
                    data = "Requested Key not found on Metadata";
                }
            }
            else
            {
                data = jObject.ToString();
            }
            return data; 
        }
    }
}
