# psql Cheatsheet

Interactive terminal for PostgreSQL. Supports SQL execution, meta-commands, and scripting.

## Connection

```bash
psql -h localhost -p 5432 -U myuser -d mydb       # Full connection
psql -h localhost -U myuser mydb                   # Common shorthand
psql postgres                                       # Connect to default postgres db
psql "postgresql://user:pass@host:5432/dbname"     # Connection URI
psql -h host -U user -d db -W                      # Prompt for password
```

| Flag         | Description                           |
|--------------|---------------------------------------|
| `-h HOST`   | Hostname (default: local socket)      |
| `-p PORT`   | Port (default: 5432)                  |
| `-U USER`   | Username                              |
| `-d DBNAME` | Database name                         |
| `-W`        | Force password prompt                 |
| `-w`        | Never prompt for password             |
| `-c "SQL"`  | Execute single command and exit       |
| `-f file`   | Execute commands from file            |
| `-o file`   | Send query output to file             |
| `-A`        | Unaligned output mode                 |
| `-t`        | Tuples only (no headers/footers)      |
| `-X`        | Don't read `.psqlrc`                  |
| `--csv`     | CSV output mode                       |

## Meta-Commands: Database and Schema

| Command              | Description                              |
|----------------------|------------------------------------------|
| `\l`                 | List all databases                       |
| `\l+`                | List databases with size and details     |
| `\c dbname`          | Connect to a different database          |
| `\dn`                | List schemas                             |
| `\dn+`               | List schemas with details               |
| `\dt`                | List tables in current schema            |
| `\dt+`               | Tables with size info                    |
| `\dt schema.*`       | Tables in specific schema                |
| `\di`                | List indexes                             |
| `\di+`               | Indexes with size info                   |
| `\dv`                | List views                               |
| `\dm`                | List materialized views                  |
| `\ds`                | List sequences                           |
| `\df`                | List functions                           |
| `\df+`               | Functions with source code               |
| `\du`                | List roles/users                         |
| `\dp`                | List table privileges                    |

## Meta-Commands: Table Inspection

| Command              | Description                              |
|----------------------|------------------------------------------|
| `\d tablename`       | Describe table (columns, types, indexes) |
| `\d+ tablename`      | Describe with storage and comments       |
| `\d *pattern*`       | Describe objects matching pattern        |

## Meta-Commands: Output and Editing

| Command              | Description                              |
|----------------------|------------------------------------------|
| `\x`                 | Toggle expanded display (vertical)       |
| `\x auto`            | Auto-expand for wide results             |
| `\timing`            | Toggle query execution timing            |
| `\e`                 | Open last query in `$EDITOR`             |
| `\e file.sql`        | Edit file in `$EDITOR`, then execute     |
| `\i file.sql`        | Execute commands from file               |
| `\o file`            | Send output to file                      |
| `\o`                 | Stop sending output to file              |
| `\pset format csv`   | Switch to CSV format                     |
| `\pset pager off`    | Disable pager                            |
| `\H`                 | Toggle HTML output                       |

## Meta-Commands: Import/Export

```sql
\copy table TO 'file.csv' CSV HEADER                     -- Export table to CSV
\copy table FROM 'file.csv' CSV HEADER                    -- Import CSV into table
\copy (SELECT * FROM t WHERE x>1) TO 'out.csv' CSV HEADER -- Export query results
\copy table (col1,col2) FROM 'file.csv' CSV HEADER        -- Import specific columns
```

Note: `\copy` runs client-side. The SQL `COPY` command runs server-side and needs file access on the server.

## Meta-Commands: Misc

| Command              | Description                              |
|----------------------|------------------------------------------|
| `\conninfo`          | Show current connection info             |
| `\password user`     | Change a user's password securely        |
| `\q`                 | Quit psql                                |
| `\! cmd`             | Run shell command                        |
| `\set VAR val`       | Set psql variable                        |
| `\echo text`         | Print text                               |
| `\?`                 | Show all meta-commands help              |
| `\h SELECT`          | SQL command syntax help                  |

## Useful Queries: Database Size

```sql
-- Database sizes
SELECT pg_database.datname, pg_size_pretty(pg_database_size(pg_database.datname))
FROM pg_database ORDER BY pg_database_size(pg_database.datname) DESC;

-- Table sizes (including indexes and toast)
SELECT relname, pg_size_pretty(pg_total_relation_size(relid))
FROM pg_catalog.pg_statio_user_tables ORDER BY pg_total_relation_size(relid) DESC;

-- Table size vs index size
SELECT relname,
  pg_size_pretty(pg_relation_size(relid)) AS table_size,
  pg_size_pretty(pg_indexes_size(relid)) AS index_size,
  pg_size_pretty(pg_total_relation_size(relid)) AS total_size
FROM pg_catalog.pg_statio_user_tables ORDER BY pg_total_relation_size(relid) DESC;
```

## Useful Queries: Running Queries and Locks

```sql
-- Currently running queries
SELECT pid, age(clock_timestamp(), query_start), usename, query, state
FROM pg_stat_activity
WHERE state != 'idle' ORDER BY query_start;

-- Long-running queries (> 5 minutes)
SELECT pid, age(clock_timestamp(), query_start), usename, query
FROM pg_stat_activity
WHERE state != 'idle' AND query_start < now() - interval '5 minutes';

-- Kill a query (graceful)
SELECT pg_cancel_backend(PID);

-- Kill a query (force terminate connection)
SELECT pg_terminate_backend(PID);

-- Show locks
SELECT pid, relation::regclass, mode, granted
FROM pg_locks WHERE NOT granted;

-- Blocking queries
SELECT blocked.pid AS blocked_pid, blocked.query AS blocked_query,
       blocking.pid AS blocking_pid, blocking.query AS blocking_query
FROM pg_stat_activity AS blocked
JOIN pg_locks AS bl ON bl.pid = blocked.pid
JOIN pg_locks AS kl ON kl.transactionid = bl.transactionid AND kl.pid != bl.pid
JOIN pg_stat_activity AS blocking ON blocking.pid = kl.pid
WHERE NOT bl.granted;
```

## Useful Queries: Statistics

```sql
-- Table statistics (seq scans, index scans, row estimates)
SELECT relname, seq_scan, idx_scan, n_live_tup, n_dead_tup, last_autovacuum
FROM pg_stat_user_tables ORDER BY n_live_tup DESC;

-- Index usage (find unused indexes)
SELECT indexrelname, idx_scan, pg_size_pretty(pg_relation_size(indexrelid))
FROM pg_stat_user_indexes ORDER BY idx_scan ASC;

-- Cache hit ratio (should be > 99%)
SELECT sum(blks_hit) * 100.0 / sum(blks_hit + blks_read) AS cache_hit_ratio
FROM pg_stat_database;

-- Connection count
SELECT datname, count(*) FROM pg_stat_activity GROUP BY datname;

-- Replication status
SELECT client_addr, state, sent_lsn, write_lsn, flush_lsn, replay_lsn
FROM pg_stat_replication;
```

## Useful .psqlrc Settings

```
\set HISTSIZE 10000
\set COMP_KEYWORD_CASE upper
\timing on
\x auto
\pset null '(null)'
\set PROMPT1 '%[%033[1m%]%M %n@%/%R%[%033[0m%]%# '
```
