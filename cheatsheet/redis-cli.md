# redis-cli Cheatsheet

Command-line interface for Redis. Supports interactive mode, single commands, and piping.

## Connection

```bash
redis-cli                                    # localhost:6379, db 0
redis-cli -h 10.0.0.1 -p 6380               # Custom host and port
redis-cli -a mypassword                      # With password
redis-cli -n 2                               # Select database 2
redis-cli -u redis://user:pass@host:6379/0   # URI format
redis-cli --tls                              # TLS connection
redis-cli --tls --cert ./cert.pem --key ./key.pem  # Mutual TLS
redis-cli -c                                 # Cluster mode
```

| Flag        | Description                              |
|-------------|------------------------------------------|
| `-h HOST`   | Server hostname (default: 127.0.0.1)    |
| `-p PORT`   | Server port (default: 6379)              |
| `-a PASS`   | Password                                 |
| `-n DB`     | Database number (default: 0)             |
| `-u URI`    | Connection URI                           |
| `-c`        | Cluster mode (follow redirects)          |
| `--tls`     | Enable TLS                               |
| `--pipe`    | Pipe mode (mass insert)                  |
| `--scan`    | Scan mode (list keys)                    |
| `--bigkeys` | Find biggest keys in dataset             |
| `--memkeys` | Find keys by memory usage                |
| `--latency` | Measure latency continuously             |
| `--stat`    | Print server stats continuously          |

## String Commands

| Command                        | Description                            |
|--------------------------------|----------------------------------------|
| `SET key value`                | Set a key                              |
| `GET key`                      | Get a key's value                      |
| `SETNX key value`             | Set only if key doesn't exist          |
| `SETEX key seconds value`     | Set with TTL                           |
| `MGET key1 key2`              | Get multiple keys                      |
| `MSET key1 v1 key2 v2`       | Set multiple keys                      |
| `INCR key`                    | Increment integer value                |
| `INCRBY key N`                | Increment by N                         |
| `DECR key`                    | Decrement integer value                |
| `APPEND key value`            | Append to string                       |
| `STRLEN key`                  | Get string length                      |

## Key Commands

| Command                        | Description                            |
|--------------------------------|----------------------------------------|
| `DEL key [key ...]`           | Delete key(s)                          |
| `EXISTS key`                  | Check if key exists (returns 0/1)      |
| `EXPIRE key seconds`          | Set TTL in seconds                     |
| `PEXPIRE key ms`              | Set TTL in milliseconds                |
| `TTL key`                     | Get remaining TTL (-1=no expiry, -2=gone) |
| `PTTL key`                    | TTL in milliseconds                    |
| `PERSIST key`                 | Remove TTL (make persistent)           |
| `TYPE key`                    | Get key's data type                    |
| `RENAME key newkey`           | Rename a key                           |
| `KEYS pattern`                | Find keys by pattern (avoid in prod!)  |
| `SCAN cursor [MATCH pat] [COUNT n]` | Iterate keys safely              |
| `RANDOMKEY`                   | Return a random key                    |
| `DUMP key`                    | Serialize a key                        |
| `OBJECT ENCODING key`         | Show internal encoding                 |

### SCAN Examples

```bash
SCAN 0 MATCH "user:*" COUNT 100             # First batch
SCAN <cursor> MATCH "user:*" COUNT 100      # Next batch (use returned cursor)
# Continue until cursor returns 0
```

## Hash Commands

| Command                              | Description                      |
|--------------------------------------|----------------------------------|
| `HSET key field value`               | Set hash field                   |
| `HGET key field`                     | Get hash field                   |
| `HMSET key f1 v1 f2 v2`             | Set multiple fields              |
| `HMGET key f1 f2`                    | Get multiple fields              |
| `HGETALL key`                        | Get all fields and values        |
| `HDEL key field`                     | Delete field                     |
| `HEXISTS key field`                  | Check field exists               |
| `HKEYS key`                          | List all field names             |
| `HVALS key`                          | List all values                  |
| `HLEN key`                           | Number of fields                 |
| `HINCRBY key field N`                | Increment field value            |

## List Commands

| Command                        | Description                            |
|--------------------------------|----------------------------------------|
| `LPUSH key val [val ...]`      | Push to head                           |
| `RPUSH key val [val ...]`      | Push to tail                           |
| `LPOP key`                     | Pop from head                          |
| `RPOP key`                     | Pop from tail                          |
| `LRANGE key 0 -1`             | Get all elements                       |
| `LRANGE key 0 9`              | Get first 10 elements                  |
| `LLEN key`                     | List length                            |
| `LINDEX key N`                 | Get element at index                   |
| `LSET key N value`             | Set element at index                   |
| `LREM key count value`         | Remove elements                        |
| `BLPOP key timeout`            | Blocking pop from head                 |

## Set Commands

| Command                        | Description                            |
|--------------------------------|----------------------------------------|
| `SADD key member [member ...]` | Add members                            |
| `SREM key member`              | Remove member                          |
| `SMEMBERS key`                 | List all members                       |
| `SISMEMBER key member`         | Check membership                       |
| `SCARD key`                    | Set size                               |
| `SINTER key1 key2`             | Intersection                           |
| `SUNION key1 key2`             | Union                                  |
| `SDIFF key1 key2`              | Difference                             |
| `SPOP key`                     | Remove and return random member        |
| `SRANDMEMBER key N`            | Return N random members                |

## Sorted Set Commands

| Command                                  | Description                    |
|------------------------------------------|--------------------------------|
| `ZADD key score member`                  | Add with score                 |
| `ZSCORE key member`                      | Get member's score             |
| `ZRANK key member`                       | Get member's rank (0-based)    |
| `ZRANGE key 0 -1 WITHSCORES`            | All members by score asc       |
| `ZREVRANGE key 0 9 WITHSCORES`          | Top 10 by score desc           |
| `ZRANGEBYSCORE key min max`              | Members within score range     |
| `ZREM key member`                        | Remove member                  |
| `ZCARD key`                              | Set size                       |
| `ZINCRBY key increment member`           | Increment score                |
| `ZCOUNT key min max`                     | Count in score range           |

## Server / Admin Commands

| Command                        | Description                            |
|--------------------------------|----------------------------------------|
| `INFO`                         | Full server info                       |
| `INFO memory`                  | Memory section only                    |
| `INFO replication`             | Replication info                       |
| `INFO stats`                   | General statistics                     |
| `DBSIZE`                       | Number of keys in current db           |
| `MONITOR`                      | Stream all commands in real time       |
| `SLOWLOG GET 10`               | Last 10 slow queries                   |
| `SLOWLOG LEN`                  | Number of slow log entries             |
| `SLOWLOG RESET`                | Clear slow log                         |
| `CONFIG GET maxmemory`         | Get config value                       |
| `CONFIG SET maxmemory 1gb`     | Set config value at runtime            |
| `CONFIG REWRITE`               | Save runtime config to file            |
| `CLIENT LIST`                  | List connected clients                 |
| `CLIENT KILL ID id`            | Kill a client connection               |
| `FLUSHDB`                      | Delete all keys in current db          |
| `FLUSHALL`                     | Delete all keys in all databases       |
| `BGSAVE`                       | Trigger background RDB save            |
| `BGREWRITEAOF`                 | Trigger AOF rewrite                    |
| `LASTSAVE`                     | Timestamp of last save                 |
| `SELECT N`                     | Switch to database N                   |

## Pub/Sub

```bash
# Terminal 1: subscribe
SUBSCRIBE mychannel
PSUBSCRIBE "events.*"                # Pattern subscribe

# Terminal 2: publish
PUBLISH mychannel "hello world"

# Unsubscribe
UNSUBSCRIBE mychannel
PUNSUBSCRIBE "events.*"
```

## CLI One-Liners

```bash
redis-cli INFO memory | grep used_memory_human      # Quick memory check
redis-cli --bigkeys                                   # Find largest keys
redis-cli --memkeys --memkeys-samples 100            # Memory per key
redis-cli --latency                                   # Continuous latency test
redis-cli --stat                                      # Continuous server stats
redis-cli KEYS "user:*" | xargs redis-cli DEL        # Delete keys by pattern
redis-cli --scan --pattern "sess:*" | head -20        # Safe key listing
redis-cli -n 0 --scan --pattern "*" --count 1000     # Scan all keys in db 0
redis-cli --pipe < commands.txt                       # Bulk insert from file
redis-cli --rdb dump.rdb                              # Download RDB snapshot
```
