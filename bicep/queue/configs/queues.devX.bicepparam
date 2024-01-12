using '../queue.bicep'

param serviceBusNamespaceName = '#{{ serviceBus.namespace }}'

param serviceBusQueues = [
  {
    name: '#{{ serviceBus.queue.pomDataUpload.name }}'
    lockDuration: 'PT5M'
  }
  {
    name: '#{{ serviceBus.queue.producerData.name }}'
    lockDuration: 'PT5M'
    maxSizeInMegabytes: 4096
    maxMessageSizeInKilobytes: 3072
  }
  {
    name: '#{{ serviceBus.queue.protectiveMonitoringEvents.name }}'
  }
  {
    name: '#{{ serviceBus.queue.registrationData.name }}'
  }
]
