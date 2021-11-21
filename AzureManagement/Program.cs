using System;
using System.Threading.Tasks;

namespace AzureManagement
{
    class Program
    {
        static async Task Main(string[] args)
        {
            AzureAPIManagementClient azureAPIClient = new AzureAPIManagementClient();
            var metaData = await azureAPIClient.GetVirtualMachineMetaData("Ubuntu18", "Azurevm", "SUBSCRITION_ID_FOR_VM", "TOKENID", "KEY_SEARCH");
            Console.WriteLine($"Searched Key Data:{metaData}" );
        }
    }
}
