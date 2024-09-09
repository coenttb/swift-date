# syntax=docker/dockerfile:1.2
# ================================
# Build image
# ================================
FROM swift:5.10.1-focal as build

# Install OS updates and, if needed, sqlite3 and OpenSSL development libraries
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get -q install -y \
          libssl-dev \
          sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Set up a build area
WORKDIR /build

# Copy the entire source code
COPY . .

# Build everything, with optimizations
RUN swift build -c release --static-swift-stdlib

# ================================
# Run image
# ================================
FROM ubuntu:focal

# Install necessary runtime libraries
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get -q install -y \
          libssl-dev \
          sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user to run the app
RUN useradd --user-group --create-home --system --skel /dev/null --home-dir /app vapor

# Switch to the new user
USER vapor
WORKDIR /app

# Copy build artifacts
COPY --from=build --chown=vapor:vapor /build/.build/release /app

# Command to run the executable
CMD ["./Run"]