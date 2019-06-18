## Configuring Blue/Green Deployments

# Deploying two versions of the same application
To represent two different versions of the applications, I have built simple Nginx-based Docker images – jijeesh/bluegreen:v1 and jijeesh/bluegreen:v2. When deployed, they show a static page with a blue or green background. We will use these images for the tutorial.
Our goal is to drive the traffic selectively to one of the deployments with no downtime. To achieve this, we need to tell Istio to route the traffic based on the weights.

There are three objects involved in making this happen:

# Gateway
An Istio Gateway describes a load balancer operating at the edge of the mesh receiving incoming or outgoing HTTP/TCP connections. The specification describes a set of ports that should be exposed, the type of protocol to use, SNI configuration for the load balancer, etc. In the below definition, we are pointing the gateway to the default Ingress Gateway created by Istio during the installation.

# Destination Rule
An Istio DestinationRule defines policies that apply to traffic intended for a service after routing has occurred. Notice how the rule is declared based on the labels defined in the original Kubernetes deployment.

# Virtual Service
A VirtualService defines a set of traffic routing rules to apply when a host is addressed. Each routing rule defines matching criteria for traffic of a specific protocol. If the traffic is matched, then it is sent to a named destination service based on a version.

In the below definition, we are declaring the weights as 50 for both v1 and v2, which means the traffic will be evenly distributed.
