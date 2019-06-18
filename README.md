# kubernetes-istio-consul
Install Tiller on your cluster with the service account:
```
$ helm init --service-account tiller
```
install consul
```
helm install --namespace consul --name consul ./consul-helm
```
Make sure you have a service account with the cluster-admin role defined for Tiller. If not already defined, create one using following command:
```
$ kubectl apply -f istio-helm/helm-service-account.yaml
```

Install the istio-init chart to bootstrap all the Istio’s CRDs:
```
$ helm install istio-helm/istio-init --name istio-init --namespace istio-system
```
Verify that all 53 Istio CRDs were committed to the Kubernetes api-server using the following command:

If cert-manager is enabled, then the CRD count will be 58 instead.
```
$ kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l
53
```
Select a configuration profile and then install the istio chart corresponding to your chosen profile. The default profile is recommended for production deployments:

```
helm install istio-helm/istio --name istio --namespace istio-system
```
