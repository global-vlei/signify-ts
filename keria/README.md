# KERIA

Pinned in [`pyproject.toml`](pyproject.toml) and [`uv.lock`](uv.lock) for integration tests and local docker-compose.

## Upgrading KERIA

1. Update the git SHA in `pyproject.toml`
2. Run `uv lock` in this directory and commit `uv.lock`
3. Re-run `npm run test:integration`
