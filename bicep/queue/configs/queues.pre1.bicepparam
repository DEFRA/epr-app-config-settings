using '../queue.bicep'

param serviceBusNamespaceName = 'PRERWDINFSB1401'

param serviceBusQueues = [
  {
    name: 'defra.epr.pom.data.uploaded'
    lockDuration: 'PT5M'
  }
  {
    name: 'defra.epr.producer.data'
    lockDuration: 'PT5M'
    maxSizeInMegabytes: 4096
    maxMessageSizeInKilobytes: 3072
  }
  {
    name: 'defra.epr.protectivemonitoring.events'
  }
  {
    name: 'defra.epr.registration.data'
  }
]
