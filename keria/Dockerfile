FROM python:3.12.8-alpine3.21 AS builder

RUN apk --no-cache add \
    git \
    curl \
    bash \
    alpine-sdk \
    libffi-dev \
    libsodium \
    libsodium-dev

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

COPY --from=ghcr.io/astral-sh/uv:0.9.5 /uv /uvx /bin/

WORKDIR /keria

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev --no-editable

FROM python:3.12.8-alpine3.21

WORKDIR /keria

RUN apk --no-cache add \
    bash \
    libsodium-dev \
    gcc

COPY --from=builder /keria /keria

ENV PATH="/keria/.venv/bin:$PATH"
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=UTF-8

EXPOSE 3901
EXPOSE 3902
EXPOSE 3903

ENTRYPOINT ["keria"]
CMD ["start"]
