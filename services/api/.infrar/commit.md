---
schema_version: 1
id: 0d8f6ec5-0116-46c7-93de-f9959f56f546
name: api
node: services/api
branch: main
previous_commit: 28a40aef6ff34d1cca321b02d9b450225cceb2a3
---

## What changed

- `services/api/.infrar/build.yaml`: the requirement `db` (product only) becomes `orbit` — product `postgres`, version `16`, `tenancy: database`, projecting `DATABASE_URL` as `url`. The former `env:` entry `DATABASE_URL` (`from: orbit`), which never pointed at `db`, is replaced by that projection.
- `.infrar/environment/`: `module "db"` (no version) becomes `module "orbit"` (`infrar/postgres`, `product_version = "16"`, `tenancy = "database"`); `outputs.tf` and `README.md` follow the rename.
- `.infrar/knowledge.md`: the build spec row, the Consumes line and the two wiring notes now describe the `orbit` requirement.

## Why

The api code speaks to Postgres through `pg` (8.22.0 in the lockfile) and reads its connection from `DATABASE_URL` only. The repository names the instance `orbit` (`aws_db_instance.orbit`, `db_name = "orbit"`) and pins `engine_version = "16"` in `deploy/main.tf`; version 16 is in the catalog, `pg` 8.x supports it, and the SQL in `src/server.js` needs nothing newer than Postgres 9.5. Declaring the requirement and its module lets Environment realise the database instead of relying on an implicit wiring.
