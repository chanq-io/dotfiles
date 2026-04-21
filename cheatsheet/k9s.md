# k9s Cheatsheet

Terminal UI for Kubernetes -- navigate, observe, and manage clusters interactively.

---

## Launch

```bash
k9s                          # Start with current context
k9s -n <namespace>           # Start in specific namespace
k9s --context <ctx>          # Start with specific context
k9s --readonly               # Read-only mode
k9s -c pods                  # Start on a specific resource view
k9s --kubeconfig <path>      # Use specific kubeconfig
```

## Global Navigation

| Key | Action |
|---|---|
| `:` | Command mode (type resource names) |
| `/` | Filter current view |
| `?` | Show help / keybindings |
| `Esc` | Back / clear filter / exit dialog |
| `Ctrl+a` | Show all available resource aliases |
| `Enter` | Select / drill into resource |
| `Backspace` (in command) | Go back to previous view |
| `q` / `Ctrl+c` | Quit k9s |
| `Ctrl+d` | Delete selected resource |

## Command Mode (`:` prefix)

Type these after pressing `:` to jump to a resource view:

| Command | View |
|---|---|
| `:pod` / `:po` | Pods |
| `:deploy` | Deployments |
| `:svc` | Services |
| `:ns` | Namespaces |
| `:no` / `:node` | Nodes |
| `:ing` | Ingresses |
| `:cm` | ConfigMaps |
| `:secret` | Secrets |
| `:job` | Jobs |
| `:cj` | CronJobs |
| `:ds` | DaemonSets |
| `:sts` | StatefulSets |
| `:rs` | ReplicaSets |
| `:pv` | PersistentVolumes |
| `:pvc` | PersistentVolumeClaims |
| `:sa` | ServiceAccounts |
| `:hpa` | HorizontalPodAutoscalers |
| `:ep` | Endpoints |
| `:sc` | StorageClasses |
| `:ctx` | Contexts (switch cluster) |
| `:crd` | Custom Resource Definitions |
| `:event` / `:ev` | Events |
| `:rb` | RoleBindings |
| `:cr` | ClusterRoles |
| `:crb` | ClusterRoleBindings |

### Special Views

| Command | Description |
|---|---|
| `:pulse` | Cluster pulse (health overview dashboard) |
| `:xray <resource>` | Xray view -- tree of related resources (e.g., `:xray deploy`) |
| `:popeye` | Cluster sanitizer (finds misconfigs) |
| `:aliases` | List all resource aliases |
| `:helm` | Helm releases |
| `:screen-dump` | Save current view to file |

## Resource View Actions

### Universal Keys

| Key | Action |
|---|---|
| `j` / `k` or arrows | Move up/down |
| `Enter` | Drill into / describe resource |
| `d` | Describe selected resource |
| `y` | View YAML |
| `e` | Edit resource (opens $EDITOR) |
| `Ctrl+d` | Delete resource (with confirmation) |
| `Ctrl+k` | Kill resource (force delete, no grace period) |
| `l` | View logs |
| `p` | Logs previous container |
| `Shift+f` | Port-forward |
| `s` | Shell into container |
| `a` | Attach to container |
| `f` | Show PortForward view |
| `Ctrl+s` | Save YAML to file |
| `Ctrl+w` | Toggle wide view |
| `r` | Refresh view |
| `Ctrl+e` | Toggle header |
| `m` | Toggle sort order (or sort by specific column) |
| `Ctrl+l` | Clear screen |

### Pod-Specific

| Key | Action |
|---|---|
| `s` | Shell into pod (`/bin/sh`) |
| `l` | View logs (streams) |
| `p` | View previous container logs |
| `Shift+f` | Port-forward dialog |
| `f` | Show port-forwards |
| `c` | Select container (multi-container pods) |

### Deployment-Specific

| Key | Action |
|---|---|
| `Enter` | View pods in deployment |
| `Ctrl+s` | Scale replicas |
| `r` | Rollout restart |
| `b` | Rollback |

## Log Viewing

| Key | Action |
|---|---|
| `j` / `k` | Scroll down/up |
| `g` | Jump to top |
| `G` | Jump to bottom |
| `f` | Toggle follow (auto-scroll) |
| `/` | Search / filter logs |
| `w` | Toggle line wrap |
| `t` | Toggle timestamps |
| `s` | Toggle since duration |
| `0-5` | Set since time (0=all, 1=1m, 2=5m, 3=15m, 4=30m, 5=1h) |
| `c` | Copy to clipboard |
| `Ctrl+s` | Save logs to file |
| `Esc` | Exit log view |

## Filtering

- Press `/` in any view to type a filter.
- Filters are regex-aware: `/nginx.*prod` works.
- Use `/` in log view to search log content.
- Press `Esc` to clear the active filter.
- Filter by labels: `/-l app=nginx` in some views.

### Namespace Filtering

- Press `:ns` then select a namespace, or
- Type a namespace in the filter bar of a resource view.
- Use `0` in namespace view to show all namespaces.

## Port Forwarding

1. Navigate to the pod or service.
2. Press `Shift+f`.
3. Fill in the port-forward dialog (local:remote port).
4. Press `Enter` to start.
5. Press `f` on any view to see active port-forwards.
6. Select a port-forward and press `Ctrl+d` to stop it.

## Shell Into a Pod

1. Navigate to the pod.
2. Press `s`.
3. If multi-container, select the container.
4. A shell session opens inside the pod.
5. Type `exit` or press `Ctrl+d` to return to k9s.

## Configuration

Config file: `~/.config/k9s/config.yaml`

```yaml
k9s:
  refreshRate: 2                # Refresh interval in seconds
  maxConnRetry: 5
  enableMouse: false
  headless: false
  ui:
    skin: dracula               # Theme name
    enableSkins: true
  currentContext: my-context
  currentCluster: my-cluster
  clusters:
    my-cluster:
      namespace:
        active: default
        favorites:
          - default
          - kube-system
          - monitoring
      view:
        active: pods
```

Skin files go in `~/.config/k9s/skins/`.

## Tips

- Use `:xray deploy` to see the full tree from Deployment -> ReplicaSet -> Pod -> Container.
- `:pulse` gives a quick cluster health dashboard showing resource counts and status.
- Press `Ctrl+a` to see all supported resource aliases if you forget the short name.
- k9s respects `KUBECONFIG` env var and supports multiple kubeconfig files.
- Read-only mode (`--readonly`) is great for production clusters.
- Benchmark mode: `:bench <svc>` to run HTTP benchmarks against a service.
