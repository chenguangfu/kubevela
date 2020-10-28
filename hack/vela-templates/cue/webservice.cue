output: {
  apiVersion: "standard.oam.dev/v1alpha1"
  kind:       "PodSpecWorkload"
  metadata: name: context.name
  spec: {
    replicas: 1
    podSpec: {
      containers: [{
        name:  context.name
        image: parameter.image
        if parameter["env"] != _|_ {
          env: parameter.env
        }
        ports: [{
          containerPort: parameter.port
        }]
      }]
    }
  }
}
parameter: {
  // +usage=specify app image
  // +short=i
  image: string

  // +usage=specify port for container
  // +short=p
  port:  *6379 | int

  env?: [...{
    name:  string
    value?: string
    valueFrom?: {
      secretKeyRef: {
        name: string
        key: string
      }
    }
  }]
}