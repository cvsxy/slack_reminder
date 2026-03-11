# Build stage
FROM node:20-alpine3.18 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Runtime stage
FROM node:20-alpine3.18
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app .
ENTRYPOINT ["node", "./lib/main.js"]

# Build and run:
#   docker build -t slack-reminder .
#   docker run -e SLACK_APP_TOKEN=xapp-... -e SLACK_BOT_TOKEN=xoxb-... -e SLACK_APP_LOG_LEVEL=INFO slack-reminder
