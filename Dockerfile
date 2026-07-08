# ===========================
# Stage 1 - Build
# ===========================
FROM node:20-alpine AS builder

# Create app directory
WORKDIR /app

# Copy package files first (better layer caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --omit=dev

# Copy application source
COPY . .

# ===========================
# Stage 2 - Production
# ===========================
FROM node:20-alpine

WORKDIR /app

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy application from builder
COPY --from=builder /app .

# Change ownership
RUN chown -R appuser:appgroup /app

USER appuser

# Expose application port
EXPOSE 3000

# Start application
CMD ["npm", "start"]
