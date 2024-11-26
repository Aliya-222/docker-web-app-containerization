FROM node:16 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY . .
FROM node:16-slim
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl --fail http://localhost:3000 || exit 1
CMD ["npm","start"]
