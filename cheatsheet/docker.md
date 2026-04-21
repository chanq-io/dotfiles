# Docker Cheatsheet

Essential commands for building, running, and managing containers with Docker and Docker Compose.

---

## Container Lifecycle

| Command | Description |
|---|---|
| `docker run <image>` | Create and start a container |
| `docker run -it <image> bash` | Run interactively with a shell |
| `docker run -d <image>` | Run detached (background) |
| `docker start <container>` | Start a stopped container |
| `docker stop <container>` | Gracefully stop a container |
| `docker restart <container>` | Restart a container |
| `docker kill <container>` | Force stop a container |
| `docker rm <container>` | Remove a stopped container |
| `docker rm -f <container>` | Force remove (even if running) |
| `docker pause <container>` | Pause a running container |
| `docker unpause <container>` | Unpause a container |

## docker run Key Flags

| Flag | Description |
|---|---|
| `--rm` | Auto-remove container on exit |
| `-it` | Interactive + TTY (for shell access) |
| `-d` | Detached mode (background) |
| `-p 8080:80` | Map host port 8080 to container port 80 |
| `-v /host:/container` | Bind mount a volume |
| `-v vol_name:/container` | Use a named volume |
| `-e VAR=value` | Set environment variable |
| `--env-file .env` | Load env vars from file |
| `--name myapp` | Assign a name to the container |
| `--network mynet` | Connect to a specific network |
| `-w /app` | Set working directory |
| `--restart unless-stopped` | Restart policy |
| `--cpus 2` | Limit CPU cores |
| `-m 512m` | Limit memory |
| `--entrypoint /bin/sh` | Override entrypoint |

## Common Examples

```bash
# Run nginx, expose port 80, auto-remove on stop
docker run --rm -d -p 8080:80 --name web nginx

# Run with env vars and a volume mount
docker run -d -e DB_HOST=db -v $(pwd)/data:/data --name app myimage

# Execute a command in a running container
docker exec -it myapp bash

# Follow logs
docker logs -f --tail 100 myapp

# Copy files to/from container
docker cp file.txt myapp:/tmp/
docker cp myapp:/tmp/file.txt ./
```

## Inspecting Containers

| Command | Description |
|---|---|
| `docker ps` | List running containers |
| `docker ps -a` | List all containers (including stopped) |
| `docker ps -q` | List only container IDs |
| `docker logs <container>` | View container logs |
| `docker logs -f <container>` | Follow (tail) logs |
| `docker logs --tail 50 <c>` | Last 50 lines |
| `docker logs --since 1h <c>` | Logs from last hour |
| `docker inspect <container>` | Full JSON details |
| `docker inspect -f '{{.NetworkSettings.IPAddress}}' <c>` | Extract specific field |
| `docker stats` | Live resource usage for all containers |
| `docker top <container>` | Running processes inside container |
| `docker diff <container>` | Changed files in container filesystem |
| `docker port <container>` | Show port mappings |

## Images

| Command | Description |
|---|---|
| `docker build -t name:tag .` | Build image from Dockerfile |
| `docker build -f Other.Dockerfile .` | Build from specific Dockerfile |
| `docker build --no-cache .` | Build without layer cache |
| `docker build --build-arg K=V .` | Pass build argument |
| `docker images` | List local images |
| `docker images -q` | List only image IDs |
| `docker pull <image>` | Pull image from registry |
| `docker push <image>` | Push image to registry |
| `docker tag src:tag dst:tag` | Tag an image |
| `docker rmi <image>` | Remove an image |
| `docker image prune` | Remove dangling images |
| `docker image prune -a` | Remove all unused images |
| `docker history <image>` | Show image layer history |
| `docker save -o file.tar <image>` | Export image to tarball |
| `docker load -i file.tar` | Load image from tarball |

## Networking

| Command | Description |
|---|---|
| `docker network ls` | List networks |
| `docker network create <name>` | Create a bridge network |
| `docker network inspect <name>` | Inspect network details |
| `docker network connect <net> <c>` | Attach container to network |
| `docker network disconnect <net> <c>` | Detach container from network |
| `docker network rm <name>` | Remove a network |
| `docker network prune` | Remove unused networks |

## Volumes

| Command | Description |
|---|---|
| `docker volume ls` | List volumes |
| `docker volume create <name>` | Create a named volume |
| `docker volume inspect <name>` | Inspect volume |
| `docker volume rm <name>` | Remove a volume |
| `docker volume prune` | Remove unused volumes |

## Cleanup / System

| Command | Description |
|---|---|
| `docker system df` | Show disk usage |
| `docker system prune` | Remove stopped containers, unused networks, dangling images |
| `docker system prune -a` | Also remove unused images (not just dangling) |
| `docker system prune -a --volumes` | Nuclear option: prune everything including volumes |
| `docker container prune` | Remove stopped containers |

## Docker Compose

| Command | Description |
|---|---|
| `docker compose up` | Start all services |
| `docker compose up -d` | Start detached |
| `docker compose up --build` | Rebuild images then start |
| `docker compose up <service>` | Start specific service |
| `docker compose down` | Stop and remove containers, networks |
| `docker compose down -v` | Also remove volumes |
| `docker compose down --rmi all` | Also remove images |
| `docker compose ps` | List running services |
| `docker compose logs` | View logs for all services |
| `docker compose logs -f <svc>` | Follow logs for one service |
| `docker compose exec <svc> bash` | Shell into running service |
| `docker compose run <svc> <cmd>` | Run one-off command in new container |
| `docker compose build` | Build/rebuild images |
| `docker compose pull` | Pull latest images |
| `docker compose restart <svc>` | Restart a service |
| `docker compose stop` | Stop without removing |
| `docker compose config` | Validate and view merged config |
| `docker compose top` | Show running processes |

## Dockerfile Basics

```dockerfile
# Base image
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy dependency files first (layer caching)
COPY package.json package-lock.json ./
RUN npm ci

# Copy application code
COPY . .
RUN npm run build

# Production stage (multi-stage build)
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

# Environment variables
ENV NODE_ENV=production

# Expose port (documentation only)
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost:3000/ || exit 1

# Default command
CMD ["node", "dist/index.js"]
```

### Key Dockerfile Instructions

| Instruction | Description |
|---|---|
| `FROM` | Base image (required first instruction) |
| `WORKDIR` | Set working directory for subsequent instructions |
| `COPY` | Copy files from host to image |
| `ADD` | Like COPY but supports URLs and auto-extracts archives |
| `RUN` | Execute command during build |
| `CMD` | Default command when container starts (overridable) |
| `ENTRYPOINT` | Main executable (args appended, harder to override) |
| `ENV` | Set environment variable |
| `ARG` | Build-time variable (not in final image) |
| `EXPOSE` | Document which port the app uses |
| `VOLUME` | Create mount point |
| `USER` | Set user for subsequent instructions |
| `HEALTHCHECK` | Define container health check |
| `LABEL` | Add metadata |

### Dockerfile Tips

- Order instructions from least to most frequently changing for better layer caching.
- Use multi-stage builds to keep final images small.
- Prefer `COPY` over `ADD` unless you need URL fetching or archive extraction.
- Combine `RUN` commands with `&&` to reduce layers.
- Use `.dockerignore` to exclude files from the build context.
- Never store secrets in `ENV` or `ARG`; use build secrets (`--mount=type=secret`).
