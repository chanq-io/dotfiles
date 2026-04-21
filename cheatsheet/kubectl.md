# kubectl Cheatsheet

Command-line tool for interacting with Kubernetes clusters.

---

## Context & Configuration

| Command | Description |
|---|---|
| `kubectl config get-contexts` | List all contexts |
| `kubectl config current-context` | Show active context |
| `kubectl config use-context <ctx>` | Switch context |
| `kubectl config set-context --current --namespace=<ns>` | Set default namespace for current context |
| `kubectl config view` | Show merged kubeconfig |
| `kubectl config view --minify` | Show only current context config |
| `kubectl cluster-info` | Display cluster endpoint info |

## Getting Resources

```bash
kubectl get <resource>                   # List resources
kubectl get <resource> <name>            # Get specific resource
kubectl get <resource> -n <namespace>    # In a specific namespace
kubectl get <resource> --all-namespaces  # Across all namespaces (or -A)
```

### Output Flags

| Flag | Description |
|---|---|
| `-o wide` | Additional columns (node, IP, etc.) |
| `-o yaml` | Full YAML output |
| `-o json` | Full JSON output |
| `-o name` | Just resource names (kind/name) |
| `-o jsonpath='{.items[*].metadata.name}'` | Extract specific fields |
| `-o custom-columns=NAME:.metadata.name,STATUS:.status.phase` | Custom columns |
| `--sort-by=.metadata.creationTimestamp` | Sort output |
| `--no-headers` | Omit header row |
| `-w` / `--watch` | Watch for changes |

### Label Selectors

```bash
kubectl get pods -l app=nginx                   # Exact match
kubectl get pods -l 'app in (nginx, apache)'    # Set-based
kubectl get pods -l app=nginx,env=prod          # Multiple labels (AND)
kubectl get pods -l '!canary'                   # Label does not exist
```

### Field Selectors

```bash
kubectl get pods --field-selector status.phase=Running
kubectl get pods --field-selector metadata.name=mypod
```

## Common Resource Types

| Short | Full | Description |
|---|---|---|
| `po` | pods | Running container instances |
| `deploy` | deployments | Manages ReplicaSets |
| `rs` | replicasets | Ensures pod replicas |
| `svc` | services | Network endpoint |
| `ing` | ingresses | HTTP routing rules |
| `cm` | configmaps | Configuration data |
| `secret` | secrets | Sensitive data |
| `ns` | namespaces | Cluster namespaces |
| `no` | nodes | Cluster nodes |
| `pv` | persistentvolumes | Storage volumes |
| `pvc` | persistentvolumeclaims | Volume claims |
| `ds` | daemonsets | One pod per node |
| `sts` | statefulsets | Stateful workloads |
| `job` | jobs | Run-to-completion tasks |
| `cj` | cronjobs | Scheduled jobs |
| `sa` | serviceaccounts | Identity for pods |
| `hpa` | horizontalpodautoscalers | Auto-scaling |
| `ep` | endpoints | Service endpoints |
| `sc` | storageclasses | Storage provisioners |

## Describe & Inspect

```bash
kubectl describe pod <name>              # Detailed info + events
kubectl describe node <name>             # Node info + allocations
kubectl get pod <name> -o yaml           # Full spec
kubectl get events --sort-by=.lastTimestamp  # Cluster events
kubectl explain pod.spec.containers      # API docs for a field
```

## Creating & Applying Resources

```bash
kubectl apply -f manifest.yaml           # Create or update from file
kubectl apply -f ./dir/                  # Apply all YAML in directory
kubectl apply -f https://url/manifest.yaml  # Apply from URL
kubectl apply -k ./kustomization/        # Apply with Kustomize

kubectl create deployment nginx --image=nginx  # Imperative create
kubectl create namespace dev
kubectl create configmap my-config --from-file=config.txt
kubectl create secret generic my-secret --from-literal=key=value

kubectl diff -f manifest.yaml            # Preview changes before apply
```

## Editing & Patching

```bash
kubectl edit deployment <name>           # Open in $EDITOR
kubectl patch deployment <name> -p '{"spec":{"replicas":3}}'
kubectl set image deployment/<name> container=image:tag
kubectl label pod <name> env=prod        # Add label
kubectl annotate pod <name> note="info"  # Add annotation
```

## Deleting Resources

```bash
kubectl delete -f manifest.yaml          # Delete from file
kubectl delete pod <name>                # Delete specific resource
kubectl delete pod <name> --grace-period=0 --force  # Force delete
kubectl delete pods -l app=old           # Delete by label
kubectl delete all --all -n <namespace>  # Delete everything in namespace
```

## Scaling & Rollouts

```bash
# Scale
kubectl scale deployment <name> --replicas=5
kubectl autoscale deployment <name> --min=2 --max=10 --cpu-percent=80

# Rollout
kubectl rollout status deployment <name>       # Watch rollout progress
kubectl rollout history deployment <name>       # View revision history
kubectl rollout undo deployment <name>          # Rollback to previous
kubectl rollout undo deployment <name> --to-revision=2  # Specific revision
kubectl rollout restart deployment <name>       # Rolling restart
kubectl rollout pause deployment <name>         # Pause rollout
kubectl rollout resume deployment <name>        # Resume rollout
```

## Logs

```bash
kubectl logs <pod>                        # Pod logs
kubectl logs <pod> -c <container>         # Specific container
kubectl logs <pod> --all-containers       # All containers in pod
kubectl logs -f <pod>                     # Follow/stream logs
kubectl logs --tail=100 <pod>             # Last 100 lines
kubectl logs --since=1h <pod>             # Logs from last hour
kubectl logs -l app=nginx                 # Logs by label selector
kubectl logs <pod> --previous             # Logs from previous crash
```

## Exec & Debug

```bash
kubectl exec -it <pod> -- bash            # Shell into pod
kubectl exec -it <pod> -c <container> -- bash  # Specific container
kubectl exec <pod> -- cat /etc/config     # Run single command

kubectl cp <pod>:/path ./local            # Copy from pod
kubectl cp ./local <pod>:/path            # Copy to pod

kubectl run debug --image=busybox -it --rm -- sh  # Ephemeral debug pod
kubectl debug <pod> -it --image=busybox   # Debug a running pod
```

## Port Forwarding & Proxy

```bash
kubectl port-forward pod/<name> 8080:80          # Pod port forward
kubectl port-forward svc/<name> 8080:80          # Service port forward
kubectl port-forward deploy/<name> 8080:80       # Deployment port forward
kubectl proxy                                     # API server proxy on :8001
```

## Resource Usage

```bash
kubectl top nodes                         # Node CPU/memory usage
kubectl top pods                          # Pod CPU/memory usage
kubectl top pods --sort-by=memory         # Sort by memory
kubectl top pods -A                       # All namespaces
kubectl top pods --containers             # Per-container usage
```

## Useful One-Liners

```bash
# Get all pod IPs
kubectl get pods -o wide

# Get all images running in cluster
kubectl get pods -A -o jsonpath='{range .items[*]}{.spec.containers[*].image}{"\n"}{end}' | sort -u

# Find pods not Running
kubectl get pods -A --field-selector status.phase!=Running

# Get resource requests/limits for pods
kubectl get pods -o custom-columns='NAME:.metadata.name,CPU_REQ:.spec.containers[0].resources.requests.cpu,MEM_REQ:.spec.containers[0].resources.requests.memory'

# Drain a node (evict pods for maintenance)
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data

# Cordon/uncordon a node
kubectl cordon <node>    # Mark unschedulable
kubectl uncordon <node>  # Mark schedulable

# Restart all pods in a deployment
kubectl rollout restart deployment <name>

# Get all resources in a namespace
kubectl api-resources --verbs=list --namespaced -o name | xargs -n1 kubectl get -n <ns> --show-kind --ignore-not-found
```

## Aliases (Common)

```bash
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kga='kubectl get all'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kdp='kubectl describe pod'
alias kl='kubectl logs -f'
alias kx='kubectl exec -it'
```
