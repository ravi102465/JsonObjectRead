Current Implimentation:
we are using rest api to get the meta data of Virtual Machine
Client is created with Get Method. It expect the subscription id, resource group, vm name, token, and key to search
Token can be generated using any oAuth flow. With scope to https://management.azure.com/.default
Method checks key is passed or not. If Key is passed it will look for it and return the data key if present else data not found. Else whole 
Metadata object is returned.

Currently code doesn't react to any exception, No code refactoring is done.

Current limitation is if the key is nested object it should be send like properties.osProfile.computerName