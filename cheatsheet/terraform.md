# Terraform Cheatsheet

Infrastructure as Code tool by HashiCorp. Write, plan, and create infrastructure declaratively using HCL.

---

## Core Workflow

```bash
terraform init       # Initialize working directory, download providers/modules
terraform plan       # Preview changes without applying
terraform apply      # Apply changes (prompts for confirmation)
terraform destroy    # Destroy all managed infrastructure
```

## Init

```bash
terraform init                       # Standard init
terraform init -upgrade              # Upgrade providers/modules to latest allowed
terraform init -reconfigure          # Reconfigure backend, ignore existing config
terraform init -migrate-state        # Migrate state to new backend
terraform init -backend=false        # Skip backend initialization
```

## Plan

```bash
terraform plan                       # Show execution plan
terraform plan -out=plan.tfplan      # Save plan to file (use with apply)
terraform plan -destroy              # Plan a destroy
terraform plan -target=aws_instance.web  # Plan for specific resource only
terraform plan -var 'name=value'     # Pass variable
terraform plan -var-file=prod.tfvars # Use variable file
terraform plan -refresh-only         # Only refresh state, no changes
```

## Apply

```bash
terraform apply                      # Apply with confirmation prompt
terraform apply plan.tfplan          # Apply a saved plan (no prompt)
terraform apply -auto-approve        # Skip confirmation prompt
terraform apply -target=aws_instance.web  # Apply specific resource
terraform apply -var 'name=value'    # Pass variable
terraform apply -var-file=prod.tfvars
terraform apply -replace=aws_instance.web  # Force recreate (replaces taint)
terraform apply -parallelism=10      # Concurrent operations (default 10)
```

## Destroy

```bash
terraform destroy                    # Destroy all resources
terraform destroy -auto-approve      # Skip confirmation
terraform destroy -target=aws_instance.web  # Destroy specific resource
```

## Key Flags (Apply/Plan/Destroy)

| Flag | Description |
|---|---|
| `-var 'key=value'` | Set a variable |
| `-var-file=file.tfvars` | Load variables from file |
| `-auto-approve` | Skip interactive confirmation |
| `-target=resource.name` | Target specific resource |
| `-replace=resource.name` | Force replacement (destroy + recreate) |
| `-refresh=false` | Skip state refresh |
| `-parallelism=N` | Max concurrent operations |
| `-compact-warnings` | Compact warning output |
| `-lock=false` | Disable state locking |

## Validate & Format

```bash
terraform validate                   # Check config syntax and consistency
terraform fmt                        # Format .tf files to canonical style
terraform fmt -check                 # Check if files are formatted (CI use)
terraform fmt -recursive             # Format all subdirectories
terraform fmt -diff                  # Show diff of formatting changes
```

## State Management

```bash
terraform show                       # Show current state (human-readable)
terraform show plan.tfplan           # Show saved plan
terraform show -json                 # JSON output of state

terraform state list                 # List all resources in state
terraform state show <resource>      # Show details of one resource
terraform state mv <src> <dst>       # Rename/move resource in state
terraform state rm <resource>        # Remove resource from state (doesn't destroy)
terraform state pull                 # Download remote state to stdout
terraform state push <file>          # Upload local state to remote backend
terraform state replace-provider <old> <new>  # Replace provider in state
```

## Import

```bash
# Import existing infrastructure into state
terraform import aws_instance.web i-1234567890abcdef0
terraform import 'aws_security_group.sg["web"]' sg-12345   # Map-keyed resource
terraform import module.vpc.aws_vpc.main vpc-12345          # Inside a module

# Import block (Terraform 1.5+, declarative import)
# Add to .tf file:
# import {
#   to = aws_instance.web
#   id = "i-1234567890abcdef0"
# }
# Then: terraform plan -generate-config-out=generated.tf
```

## Output

```bash
terraform output                     # Show all outputs
terraform output <name>              # Show specific output
terraform output -json               # JSON format
terraform output -raw <name>         # Raw value (no quotes, for scripting)
```

## Workspaces

```bash
terraform workspace list             # List workspaces
terraform workspace show             # Show current workspace
terraform workspace new <name>       # Create new workspace
terraform workspace select <name>    # Switch workspace
terraform workspace delete <name>    # Delete workspace
```

Use `terraform.workspace` in config to reference the active workspace name.

## Taint & Untaint (Legacy)

```bash
# Prefer -replace flag instead (Terraform 1.0+)
terraform taint aws_instance.web     # Mark for recreation on next apply
terraform untaint aws_instance.web   # Remove taint mark
```

## Providers

```bash
terraform providers                  # Show required providers
terraform providers lock             # Generate lock file for platforms
terraform providers mirror <dir>     # Mirror providers to local directory
```

## Graph & Debug

```bash
terraform graph | dot -Tpng > graph.png  # Dependency graph (needs graphviz)
terraform console                    # Interactive expression evaluator

# Debug logging
TF_LOG=DEBUG terraform plan          # Verbose logging
TF_LOG_PATH=terraform.log terraform plan  # Log to file
```

## HCL Basics

### Variables

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  type = map(string)
  default = {
    env = "dev"
  }
}

variable "allowed_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/8"]
}

variable "enable_monitoring" {
  type    = bool
  default = true
}
```

### Resources

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0abcdef1234567890"
  instance_type = var.instance_type

  tags = {
    Name = "web-server"
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
    ignore_changes        = [tags]
  }
}
```

### Data Sources

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}
```

### Outputs

```hcl
output "instance_ip" {
  description = "Public IP of web server"
  value       = aws_instance.web.public_ip
  sensitive   = false
}
```

### Locals

```hcl
locals {
  name_prefix = "${var.project}-${var.environment}"
  common_tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
```

### Common Functions

| Function | Example |
|---|---|
| `format` | `format("Hello, %s!", var.name)` |
| `join` | `join(", ", var.list)` |
| `split` | `split(",", var.string)` |
| `lookup` | `lookup(var.map, "key", "default")` |
| `merge` | `merge(local.tags, { extra = "tag" })` |
| `length` | `length(var.list)` |
| `element` | `element(var.list, 0)` |
| `coalesce` | `coalesce(var.a, var.b, "fallback")` |
| `try` | `try(var.obj.key, "default")` |
| `file` | `file("${path.module}/script.sh")` |
| `templatefile` | `templatefile("tpl.sh", { name = var.name })` |
| `cidrsubnet` | `cidrsubnet("10.0.0.0/16", 8, 1)` -> `10.0.1.0/24` |
| `toset` | `toset(["a", "b"])` |

### Loops & Conditionals

```hcl
# count
resource "aws_instance" "server" {
  count         = var.instance_count
  ami           = "ami-123"
  instance_type = "t3.micro"
  tags = { Name = "server-${count.index}" }
}

# for_each (map)
resource "aws_instance" "server" {
  for_each      = var.servers
  ami           = each.value.ami
  instance_type = each.value.type
  tags = { Name = each.key }
}

# for_each (set)
resource "aws_iam_user" "users" {
  for_each = toset(["alice", "bob"])
  name     = each.key
}

# Conditional
resource "aws_instance" "web" {
  count         = var.create_instance ? 1 : 0
  ami           = "ami-123"
  instance_type = "t3.micro"
}

# for expression
locals {
  upper_names = [for name in var.names : upper(name)]
  name_map    = { for name in var.names : name => upper(name) }
}
```

### Backends

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

## Tips

- Always run `terraform plan` before `apply` and review the diff.
- Use `-target` sparingly; it can leave state inconsistent.
- Store state remotely (S3, GCS, Terraform Cloud) for team collaboration.
- Use `.tfvars` files per environment: `terraform apply -var-file=prod.tfvars`.
- Pin provider versions in `required_providers` to avoid surprise upgrades.
- Use `terraform state rm` before removing a resource from config if you want to keep the real resource alive.
