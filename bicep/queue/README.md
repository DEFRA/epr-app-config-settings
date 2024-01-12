# ServiceBus Queue configuration

A bicep template is used to create and update ServiceBus queues for a given environment. The changes are applied via a dedicated [AzureDevOps pipeline](https://dev.azure.com/defragovuk/RWD-CPR-EPR4P-ADO/_build?definitionId=5087). Environment specific configuration is handled with `queue.<environment>.bicepparam` files located inside the configs folder.

Example config file:

```bicep

using '../queue.bicep'

param serviceBusNamespaceName = 'ENVRWDINFSB1401'  // ServiceBus Namespace

param serviceBusQueues = [  // List of queues that should be created within the ServiceBus namespace
  {
    name: 'queuename1.env'            // Required, queue name
    lockDuration: 'PT5M'              // Optional, if absent defaults to PT1M
    maxSizeInMegabytes: 4096          // Optional, if absent defaults to 1024
    maxMessageSizeInKilobytes: 3072   // Optional, if absent defaults to 1024
  }
  {
    name: 'queuename2.env'
    lockDuration: 'PT3M'
  }
  {
    name: 'queuename3.env'
  }
  {
    name: 'queuename4.env'
  }
]
```
