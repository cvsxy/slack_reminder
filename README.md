# Slack Mention Reminder

A Slack bot that lets you schedule reminders by @mentioning it — no slash commands needed. Based on [seratch/slack-mention-reminder](https://github.com/seratch/slack-mention-reminder).

## How It Works

Mention the bot in any channel with this format:

```
@MentionReminder remind #channel at 2026-03-15 09:00 +00:00
Hey team, standup starts in 5 minutes!
```

You can also target a user for a DM reminder:

```
@MentionReminder remind @username at 2026-03-15 14:00 +00:00
Don't forget to submit your expense report!
```

Epoch timestamps (seconds) are also supported for workflow automation:

```
@MentionReminder remind #tasks at 1742025600
Automated reminder message here
```

The bot will confirm with a checkmark or report parsing errors in a thread reply.

---

## Setup Guide

### Step 1: Create the Slack App

1. Go to [https://api.slack.com/apps](https://api.slack.com/apps)
2. Click **"Create New App"** → **"From an app manifest"**
3. Select your workspace
4. Switch to the **JSON** tab and paste the contents of `manifest.json` from this project
5. Click **Create**

### Step 2: Install to Your Workspace

1. On the app settings page, go to **Settings → Install App**
2. Click **"Install to Workspace"** and authorize
3. Copy the **Bot User OAuth Token** (`xoxb-...`) — this is your `SLACK_BOT_TOKEN`

### Step 3: Generate an App-Level Token

1. Go to **Settings → Basic Information**
2. Scroll to **App-Level Tokens** and click **"Generate Token and Scopes"**
3. Name it anything (e.g., `socket-mode`)
4. Add the scope: **`connections:write`**
5. Click **Generate**
6. Copy the token (`xapp-...`) — this is your `SLACK_APP_TOKEN`

### Step 4: Set Up Environment

```bash
cp .env.example .env
```

Edit `.env` and paste your tokens:

```
SLACK_BOT_TOKEN=xoxb-your-bot-token
SLACK_APP_TOKEN=xapp-your-app-level-token
```

### Step 5: Install and Run

```bash
npm install
npm start
```

For development with auto-reload:

```bash
npm run local
```

### Step 6: Invite the Bot

In Slack, invite the bot to any channel where you want to use it:

```
/invite @MentionReminder
```

---

## Docker Deployment

```bash
docker build -t slack-reminder .
docker run -e SLACK_APP_TOKEN=xapp-... -e SLACK_BOT_TOKEN=xoxb-... slack-reminder
```

---

## Required Bot Scopes

These are configured in `manifest.json`:

| Scope | Purpose |
|-------|---------|
| `app_mentions:read` | Listen for @mentions |
| `chat:write` | Send reminder messages |
| `chat:write.public` | Post to channels the bot hasn't joined |
| `im:write` | Send DM reminders |
| `mpim:write` | Send group DM reminders |

---

## Project Structure

```
slack_reminder/
├── src/
│   ├── app.ts          # Bot logic: mention parsing + message scheduling
│   └── main.ts         # Socket Mode client entry point
├── manifest.json       # Slack app manifest (paste into Slack dashboard)
├── package.json        # Dependencies and scripts
├── tsconfig.json       # TypeScript config
├── Dockerfile          # Container deployment
├── .env.example        # Token template
└── .gitignore
```
