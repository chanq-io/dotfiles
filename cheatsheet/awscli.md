# AWS CLI Cheatsheet

Command-line interface for Amazon Web Services. Covers the most frequently used services and patterns.

---

## Configuration

```bash
aws configure                        # Interactive setup (access key, secret, region, output)
aws configure --profile staging      # Configure a named profile
aws configure list                   # Show current configuration
aws configure list-profiles          # List all profiles
aws configure set region us-west-2   # Set a single value
aws configure get region             # Get a single value
```

### Common Global Flags

| Flag | Description |
|---|---|
| `--profile <name>` | Use a named profile |
| `--region <region>` | Override region (e.g., `us-east-1`) |
| `--output <format>` | Output format: `json`, `text`, `table`, `yaml` |
| `--query <jmespath>` | Filter output with JMESPath expression |
| `--no-cli-pager` | Disable pager for output |
| `--dry-run` | Test permissions without making changes (EC2) |
| `--debug` | Verbose debug output |

### Environment Variables

| Variable | Description |
|---|---|
| `AWS_PROFILE` | Default profile name |
| `AWS_DEFAULT_REGION` | Default region |
| `AWS_ACCESS_KEY_ID` | Access key |
| `AWS_SECRET_ACCESS_KEY` | Secret key |
| `AWS_SESSION_TOKEN` | Session token (temporary credentials) |
| `AWS_DEFAULT_OUTPUT` | Default output format |

## STS (Identity)

```bash
aws sts get-caller-identity                          # Who am I?
aws sts get-caller-identity --query 'Account' --output text  # Just account ID
aws sts assume-role --role-arn <arn> --role-session-name <name>  # Assume role
```

## S3

### Listing

```bash
aws s3 ls                              # List buckets
aws s3 ls s3://bucket/                 # List objects in bucket
aws s3 ls s3://bucket/prefix/ --recursive  # Recursive listing
aws s3 ls s3://bucket/ --human-readable --summarize  # Readable sizes + total
```

### Copy & Sync

```bash
aws s3 cp file.txt s3://bucket/              # Upload file
aws s3 cp s3://bucket/file.txt ./            # Download file
aws s3 cp s3://bucket/dir/ ./dir/ --recursive  # Download directory
aws s3 cp - s3://bucket/file.txt             # Upload from stdin

aws s3 sync ./local/ s3://bucket/prefix/     # Sync local -> S3
aws s3 sync s3://bucket/ ./local/            # Sync S3 -> local
aws s3 sync s3://src-bucket/ s3://dst-bucket/  # Sync between buckets
aws s3 sync . s3://bucket/ --exclude "*.log" --include "*.txt"  # With filters
aws s3 sync . s3://bucket/ --delete          # Delete files in dest not in source
```

### Bucket Operations

```bash
aws s3 mb s3://new-bucket                    # Make bucket
aws s3 rb s3://bucket                        # Remove empty bucket
aws s3 rb s3://bucket --force                # Remove bucket + all contents
aws s3 mv s3://bucket/old.txt s3://bucket/new.txt  # Move / rename
aws s3 rm s3://bucket/file.txt               # Delete object
aws s3 rm s3://bucket/prefix/ --recursive    # Delete all with prefix
```

### Presigned URLs

```bash
aws s3 presign s3://bucket/file.txt                    # Default 1 hour
aws s3 presign s3://bucket/file.txt --expires-in 3600  # Expires in seconds
```

### S3 API (lower-level)

```bash
aws s3api head-object --bucket <b> --key <k>           # Object metadata
aws s3api put-bucket-versioning --bucket <b> --versioning-configuration Status=Enabled
aws s3api list-object-versions --bucket <b> --prefix <p>
```

## EC2

### Instances

```bash
# List instances
aws ec2 describe-instances
aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,State.Name,InstanceType,PrivateIpAddress,Tags[?Key==`Name`].Value|[0]]' --output table

# Filter by state
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running"

# Filter by tag
aws ec2 describe-instances --filters "Name=tag:Name,Values=myserver"

# Start / Stop / Terminate
aws ec2 start-instances --instance-ids i-1234567890abcdef0
aws ec2 stop-instances --instance-ids i-1234567890abcdef0
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
aws ec2 reboot-instances --instance-ids i-1234567890abcdef0

# Launch instance
aws ec2 run-instances \
  --image-id ami-0abcdef1234567890 \
  --instance-type t3.micro \
  --key-name my-key \
  --security-group-ids sg-12345 \
  --subnet-id subnet-12345 \
  --count 1 \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=myserver}]'
```

### Images & Snapshots

```bash
aws ec2 describe-images --owners self                  # Your AMIs
aws ec2 create-image --instance-id i-123 --name "backup"  # Create AMI
aws ec2 describe-snapshots --owner-ids self
```

### Security Groups

```bash
aws ec2 describe-security-groups
aws ec2 describe-security-groups --group-ids sg-12345
aws ec2 authorize-security-group-ingress --group-id sg-12345 --protocol tcp --port 443 --cidr 0.0.0.0/0
aws ec2 revoke-security-group-ingress --group-id sg-12345 --protocol tcp --port 443 --cidr 0.0.0.0/0
```

### Key Pairs

```bash
aws ec2 describe-key-pairs
aws ec2 create-key-pair --key-name my-key --query 'KeyMaterial' --output text > my-key.pem
```

## IAM

```bash
aws iam list-users
aws iam list-roles
aws iam list-policies --scope Local             # Custom policies only
aws iam get-user                                 # Current user details
aws iam get-role --role-name <role>
aws iam list-attached-role-policies --role-name <role>
aws iam list-attached-user-policies --user-name <user>
aws iam create-role --role-name <name> --assume-role-policy-document file://trust.json
aws iam attach-role-policy --role-name <name> --policy-arn <arn>
```

## Lambda

```bash
aws lambda list-functions
aws lambda list-functions --query 'Functions[].[FunctionName,Runtime,MemorySize]' --output table

# Invoke
aws lambda invoke --function-name <name> --payload '{"key":"value"}' output.json
aws lambda invoke --function-name <name> --payload '{}' --log-type Tail output.json  # With logs

# Create
aws lambda create-function \
  --function-name my-func \
  --runtime nodejs20.x \
  --handler index.handler \
  --role arn:aws:iam::123456:role/lambda-role \
  --zip-file fileb://function.zip

# Update code
aws lambda update-function-code --function-name <name> --zip-file fileb://function.zip

# Update configuration
aws lambda update-function-configuration --function-name <name> --memory-size 512 --timeout 30

# Get function details
aws lambda get-function --function-name <name>
aws lambda get-function-configuration --function-name <name>
```

## CloudWatch Logs

```bash
aws logs describe-log-groups
aws logs describe-log-streams --log-group-name <group> --order-by LastEventTime --descending
aws logs tail <log-group> --follow              # Stream logs (like tail -f)
aws logs tail <log-group> --since 1h            # Last hour
aws logs filter-log-events --log-group-name <group> --filter-pattern "ERROR"
```

## ECS

```bash
aws ecs list-clusters
aws ecs list-services --cluster <cluster>
aws ecs describe-services --cluster <cluster> --services <svc>
aws ecs list-tasks --cluster <cluster> --service-name <svc>
aws ecs describe-tasks --cluster <cluster> --tasks <task-arn>
aws ecs update-service --cluster <cluster> --service <svc> --force-new-deployment  # Redeploy
```

## Route 53

```bash
aws route53 list-hosted-zones
aws route53 list-resource-record-sets --hosted-zone-id <id>
```

## JMESPath Query Examples

```bash
# Get just instance IDs
--query 'Reservations[].Instances[].InstanceId'

# Filter in query
--query 'Reservations[].Instances[?State.Name==`running`].InstanceId'

# First result only
--query 'Reservations[].Instances[0].InstanceId'

# Multiple fields
--query 'Reservations[].Instances[].[InstanceId, InstanceType, State.Name]'

# Named output columns (with --output table)
--query 'Reservations[].Instances[].{ID:InstanceId, Type:InstanceType, State:State.Name}'

# Sort
--query 'sort_by(Reservations[].Instances[], &LaunchTime)[].[InstanceId, LaunchTime]'

# Count
--query 'length(Reservations[].Instances[])'
```

## Tips

- Use `--output text` combined with `--query` for scriptable one-value outputs.
- Use `aws <service> wait <condition>` to block until a resource reaches a state (e.g., `aws ec2 wait instance-running`).
- Pipe JSON output to `jq` for advanced processing beyond JMESPath.
- Use `--no-cli-pager` or set `AWS_PAGER=""` to avoid the pager in scripts.
- The `aws configure sso` command sets up SSO-based auth for organizations using AWS IAM Identity Center.
