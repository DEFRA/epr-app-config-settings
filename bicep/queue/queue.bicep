@description('Name of the Service Bus namespace')
param serviceBusNamespaceName string

@description('Queues and their settings')
param serviceBusQueues array


resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' existing = {
  name: serviceBusNamespaceName
}

resource serviceBusQueue 'Microsoft.ServiceBus/namespaces/queues@2022-01-01-preview' = [for (queue, i) in serviceBusQueues: {
  parent: serviceBusNamespace
  name: queue.name
  properties: {
    lockDuration: ((contains(queue, 'lockDuration')) ? queue.lockDuration : null )
    maxSizeInMegabytes: ((contains(queue, 'maxSizeInMegabytes')) ? queue.maxSizeInMegabytes : null )
    maxMessageSizeInKilobytes: ((contains(queue, 'maxMessageSizeInKilobytes')) ? queue.maxMessageSizeInKilobytes : null )
  }
}]

