<div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
  <img alt="Eve" src="assets/eve_logo.png" width="200px" align="left"/>
  <img alt="Incept5" src="assets/incept5.png" width="200px" align="right"/>
</div>
<h1 align="center">Eve</h1>

<p align='center'>
<b>Take command of your own set of Software Engineering Agents</b><br><br>
</p>

## Summary of the Dev Kit

Eve is a powerful tool that allows you to develop software at a higher level using natural language.


Key Features:
* Node-based server and easy to use web UI
* Supports Anthropic Claude Sonnet 3.5 (and also Google Gemini, OpenAI, Groq, GLHF, Mistral & Ollama - for local LLMs)
* Works with existing code bases or a clean slate
* Multiple Agents to help with various disciplines
* Product Agent to help define requirements and create stories
* Architect Agent to create refactoring plans and break down stories into coding tasks
* Software Engineering Agent to make code changes, run tests and iterate until passing
* Ops Agent to install tools and bootstrap new projects
* MCP Agent to install Model Context Protocol server tools to hook up your agents to any 3rd party system
* Private Coder is a simplified coding agent tuned to work with the best open source models
* Audio transcription support (talk instead of type)
* Workspace management for multiple projects
* Git integration for version control
* Simplified "In-Repo" Epics/Stories/Task project management


## Quick Start

1. Clone the repository
2. Verify and install required tools (Node.js 20+ and pnpm)
3. (Optional) Set up audio transcription
4. Run the Eve server with ./eve.sh
5. Access the web UI in your browser at http://localhost:3010
6. Go to the Settings page (bottom link on left hand menu) and enter the required API keys:
6. Get your free Eve API Key from here: https://incept5.github.io/eve-web-admin
7. Get a Claude API Key from https://console.anthropic.com
8. Get your Groq API Key from https://console.groq.com (this is needed for cheap summarization)
9. Get your GLHF API Key from https://glhf.chat (free access to open source models such as Llama3.3)
10. Import your local git repo as a workspace 
11. Chat with the Agents to make updates to your system

For detailed instructions, see the sections below.

If you have questions then feel free to email: adam.chesney@incept5.com

## Eve Dev Guide

We are creating a guide to help you transition to the world of higher level development.

The guide covers (or will cover!) topics such as:

1. Introduction to higher level development
2. How the AI Software Engineering Agent works
3. Best Practices to get the most out of Eve
4. Advanced Usage
5. Troubleshooting

To access the guide, please open the [index page](guide/index.md) in the `guide` directory. This living document will be updated regularly with new information and examples to help you make the most of the Eve system.

**NOTE that the guide is a work in progress and is not complete yet....**

## Getting Started

### A note about Anthropic credits and paying for Claude

You will need to add a debit or credit card and purchase some credits.
A developer working flat out most days is going to rack up something like £100 worth of tokens per month.
YMMV based on repo size etc. You can set limits in the Anthropic Console to protect yourself. 
I suggest you have your own Anthropic account and either expense it or use a company debit/credit card.
If you try to share an API key among developers then you may well run into per month usage limits or rate limits.
You may get rate limited to begin with as you start on Tier 1 and are only allowed 1 million tokens per day. Add a bunch
of credit to get to higher tiers.

### Install Required Tools

To run Eve, you need to have Node.js (version 20 or higher) and pnpm installed on your system. If you don't have these tools installed, follow these steps:

1. Install Node.js:
   - Visit the official Node.js website: https://nodejs.org/
   - Download and install the latest LTS version (20.x or higher)

2. Install pnpm:
   - After installing Node.js, open a terminal or command prompt
   - Run the following command to install pnpm globally:
     ```
     npm install -g pnpm
     ```

For more information on installing and using pnpm, visit: https://pnpm.io/installation

3. For Windows users:
   - Install Git CLI tools, which include Git Bash:
     - Visit the official Git website: https://git-scm.com/download/win
     - Download and install the Git for Windows installer
     - During installation, make sure to select the option to include Git Bash

Once you have Node.js, pnpm, and Git CLI tools (for Windows) installed, you can proceed with the setup of the Eve Horizon.

### Audio Transcription Setup

Eve includes support for audio transcription (talk into the mic instead of typing) using the faster-whisper library. To set up the audio transcription feature, follow these steps:

1. Make sure you have Python3 and pip installed on your system. If not, the installation script will attempt to install them for you.

2. Run the install-faster-whisper.sh script:

   ```
   ./scripts/install-faster-whisper.sh
   ```

   This script will:
   - Check if Python3 and pip are installed, and install them if necessary.
   - Install the faster-whisper-cli package using pip.

3. After running the script, the faster-whisper-cli should be installed and ready to use with Eve.

Note: The installation script supports macOS and Linux. For Windows users, you may need to install Python3, pip, and faster-whisper-cli manually.

If you encounter any issues during the installation, please refer to the error messages in the console or seek assistance from the project maintainers.

## Running the Eve Server

Once you have completed the setup steps above, you can start the Eve server using the provided script. Follow these steps:

1. Open a terminal and navigate to the root directory of the Eve project.

2. Run the following command:

   ```
   ./eve.sh
   ```

   This script will:
   - Install or update npm packages using pnpm
   - Start the Eve server

3. Wait for the server to start. You should see a message indicating that the server is running.

4. Once the server is running, you can access the web UI by opening a web browser and navigating to: http://localhost:3010

If you encounter any issues while starting the server, check the console output for error messages. Make sure you have completed all the setup steps, including setting your Anthropic API key in the `.env` file and installing the required tools.

To stop the server, you can use `Ctrl+C` in the terminal where the server is running.


## Workspaces


<img alt="Eve Horizon" src="assets/screenshots/workspaces.png" width="800"/>


### Import a Local Repo
Before you can start developing in tandem with the SE Agent you will need to configure a workspace. To do this select **Workspaces**
from the left hand menu and then **Import Local Repo** where you will be asked for the full path to the git repo. It will take the dir name
to be the name of the workspace unless you choose to override by providing a specific name for your repo.

### Default Workspace
Once you have a bunch of workspaces you might find it annoying to have to keep selecting the one you want for a particular Agent.
You can select the workspace you want for the agent in the dropdown and then by clicking on the star icon to the right of the dropdown
you can make that workspace the default which will be pre-selected for the current agent.

<img alt="Eve Horizon" src="assets/screenshots/default-workspace.png" width="600"/>

### Build/Test Command
You can set a command or script for the SE Agent to run after it makes its code changes but before committing them to git. 
Just hit **Edit** with the workspace selected and enter the command. Note that the Agent may not always run the command automatically
and if it doesn't then a simple "test" prompt should suffice. The Agent should iterate and keep trying to fix stuff
until the tests pass.

## Product Agent

<img alt="Eve Horizon" src="assets/product-agent.png" width="800px"/>

The Product Agent will help you refine your requirements and turn them into an Epic with child stories.
We support a simplified "in-repo" mechanism for this currently by storing markdown and json files inside the ./epics directory inside the git Repo

You can ask the Product Agent things like:

* "Create a new Epic from the following requirements..."
* "Refine the requirements for Epic 1 to add..."
* "Create the stories for Epic 2"
* "Update the stories for Epic 1 to reflect the updated requirements and the new design of...."

## Architect Agent

<img alt="Eve Horizon" src="assets/hldk-architect-tasks.png" width="800px"/>

The Architect Agent will interrogate the existing codebase and will break down each Story (under REPO/epics) into a set of coding tasks for the Software Engineering Agent to implement.

You can ask the Architect Agent things like:

* "Create the tasks for Epic 3, story 1"
* "Update the tasks for Epic 3, story 1 to make the following changes..."

## Software Engineering Agent

<img alt="Eve Horizon" src="assets/hldk-se-agent.png" width="800px"/>

The Software Engineering Agent is primarily there to turn your ideas into new code.
It has access to the full source in the repo and will make any changes you request by
first examining related files and then implementing a solution by adding new files and/or updating existing files.
You can also set the portFromDir on the workspace to allow the SE Agent to read source files from another repository - this is useful when porting code from one system over to another.

The agent can see all the files in the git repo but it may need hints as to where to look for things.

You can ask the SE Agent things like:

* _"Update the session page in the web ui to do x, y, z..."_
* _"Look at mutation service and repo and make changes to do x,y,z..."_
* _"Use the person module as an example and implement a new module called Foo with props (x,y,z) - implement the repo, service, controller with unit tests for all"_
* "Have a look at the payments module (entities, service etc) and add a new service that does...."
* "Add a new e2e test that verifies that the Foo module is working correcly.. be sure to cover the following functionality..."
* "Implement task 1 in story 2 of epic 1"

### Sessions
Create a new session for each new mini-spec that you want to send to the agent. 
If you try to do too much on one session then the agent may get confused. Also be sure to select the correct Workspace or the agent will
definitely get confused!

If you want to make tweaks to the code that was just generated then that is usually fine to do in the same session.

### Chatting with the agents

Send specs or commands by filling out the text area at the bottom that says _"Type your message"_ and then clicking the Send or simply hitting **Enter**.

If you want a new line you can use **Shift+Enter**

You can upload images and send them up to the Agent (if the LLM supports multimodal) using the image button.

### Voice Transcription

<img alt="Eve Horizon" src="assets/mic-input.png" width="400px"/>

If you want to provide your specs via voice then make sure you have installed the faster whisper cli (see above) and then
just **HOLD** the mic button down... once the mic button turns red then it is listening and will continue to listen until you let
go of the button at which point the recording is streamed to the server and then to faster whisper and the resulting text
will appear in the text area. You will then still need to submit this text by pressing **Enter** or clicking the send button.

### Aborting

If the agent seems to be going awry then you can interrupt what it is doing by hitting the red stop button.

### Epics

<img alt="Eve Horizon" src="assets/hldk-epics-view.png" width="600px"/>

On the right hand side of the agent screens you can select "Epics" to see the Epics related to the current workspace.
This is currently a simplified Jira-like thing that stores Epic (requirements.md), Stories and Tasks under the ./epics 
directory inside the git repo. This means that the agents can both read and write to the files and the history is managed
by git. The Epics view is a read-only view into this state and you can select the relevant Epic & Story using the dropdowns.

### Updates

During the process of making code updates the SE Agent will update some source files by using its Search & Replace
file update tool. Each operation with this tool results in an entry to the Updates panel on the right. You may see multiple
updates for a single file and that is normal because in large files the agent will not want to have to update the whole file
at once (lots of expensive output tokens) and so it uses multiple Search & Replace edits (find the search text in the file and replace it with the replace text)
to more efficiently update multiple bits.

In the Update panel you have the choice of viewing the Description which shows the Search & Replace block that the agent has
generated to make the edit or either the Before or After panels which show the full file contents immediately before or after
the edit. You can double-click on the Before or After text to copy the file contents to the clipboard in case that's useful.

### Git Log

<img alt="Eve Horizon" src="assets/git-log.png" width="600px"/>

As an alternative to the Updates panel you can switch to see the Git Log which shows the last 10 or so commits.

You can choose to revert the last commit by clicking on the little red revert icon.

Or you can choose to open a new browser tab to see the unified Git diff for the commit by clicking on the blue git icon.

<img alt="Eve Horizon" src="assets/git-diff.png" width="600px"/>

## Sessions Page

<img alt="Eve Horizon" src="assets/sessions-page.png" width="800px"/>

If you need to go back to a previous session then you should be able to find it on the recent sessions page along
with some stats about each session. You can click on the link to take you back to the SE Agent with that session loaded.

Please note that you may not be able to continue with the session if the server has been restarted recently.
This is because the Snapshotting of session data (for Langgraph) is currently only persisted to RAM and not disk.

## Use a Hints file

The SE Agent will always look for a file called **hints.md** in the root of the git repo and the contents are passed on
to Claude. You should add one to your repo and let the agent know about any helpful hints for adding code to the repo.

It should contain things like:

* How you want your code laid out (if it's not already obvious from the existing code)
* Maybe what package manager you are using (if it's not obvious from the file tree)
* Point to good examples of things (e.g. services, entities etc) to look at when adding a new one of those
* Tips about architecture or performance stuff

Here is an example from the Eve itself:

<pre>
   # These are hints for Eve or any other AI agent to help it understand the codebase.
   
   # DATABASE CHANGES
   
   When making changes to the database schema you need to add a new knex migration script (.js not .ts!) to the `/migrations` directory
   
   Remember:
   - Use pnpm for all package management calls and NOT npm or yarn.
   - IMPORTANT: Never run pnpm in the root directory
   - For server packages changes you will need to run 'cd hldk-server && pnpm add <package-name>'
   - For client packages changes you will need to run 'cd vitify-webui && pnpm add <package-name>'
   - For ID generation always use ulid - we have already added the ulid package to the project.
   - When generating db related code always try to minimise the number of db round trips - so use group by and in clauses where possible etc.
</pre>

## MCP Servers

Eve supports Model Context Protocol (MCP) servers, which extend the capabilities of the system by integrating external tools and services.

### What are MCP Servers?

MCP (Model Context Protocol) servers are specialized servers that implement the Model Context Protocol, allowing Eve to communicate with external tools and services. These servers act as bridges between Eve and various functionalities like code analysis, data retrieval, or specialized processing.

### Adding MCP Servers

You can add MCP servers to the system using the MCP Agent. Here's how:

1. **List current MCP servers**:
   Ask the MCP Agent to list current servers to see what's already configured.

2. **Search for available servers**:
   Ask the MCP Agent to search for an MCP server that provides the functionality you need.
   Example: "Can you find an MCP server for code analysis?"

3. **Install a server**:
   Once you've identified a server you want to add, ask the MCP Agent to install it.
   Example: "Please install the code-analysis MCP server."

4. **Configure the server**:
   The MCP Agent will guide you through any necessary configuration steps, such as:
   - Setting up API keys or credentials
   - Configuring server-specific settings
   - Testing the server to ensure it's working properly

5. **Verify installation**:
   After installation, you can ask to "list available tools" to verify that the server's tools are accessible.

All MCP servers are stored in the `~/.eve/mcp-servers` directory (unless overridden in the settings page), with their configurations managed in the `mcp-servers.json` file.

### Building Custom MCP Servers

If no existing MCP server meets your needs, you can ask the MCP Agent to help you build a custom server. The agent will guide you through the process of creating a new MCP server that implements the specific functionality you require.

## Implementing a Plugin

Eve supports custom plugins, allowing you to extend its functionality. Here's how to implement a plugin:

1. **Plugin Directory Structure**: 
   Create a new directory for your plugin in `server/plugins/<plugin-name>`.

2. **Configuration File**:
   Create a `plugin-config.json` file in your plugin directory with the following structure:
   ```json
   {
     "name": "<plugin-name>",
     "agent": "<plugin-name>-agent.js",
     "tools": {
       "<toolName>": "<tool-name>-tool.js"
     }
   }
   ```

3. **Agent Implementation**:
   If your plugin includes an agent, create an `<plugin-name>-agent.js` file. The agent must implement:
   - `getSystemPrompt(context)` method
   - (Optional) `getToolNames()` method

This is an example agent.js:

```
   module.exports = {
      async getSystemPrompt(context) {
         return `You are an Echo Agent. Your task is to repeat the user's message and add the current date.
             IMPORTANT: Format the response as JSON and only return the JSON string: {"echo": "<message> <current date>"}
         `;
      },
      async getToolNames(context) {
         return ['current_date'];
      }
   };
```
4. **Tool Implementation**:
   For each tool, create a `<tool-name>-tool.js` file. Each tool must extend the langchain Tool class.

5. **Example**:
   You can use the `echo-agent` plugin as a reference, located in `server/plugins/echo-agent/`.

6. **Testing**:
   After adding your plugin, you can invoke the agent with an HTTP POST request to:
   ```
   POST http://localhost:3010/agents/<plugin-name>/responseContent
   Accepts: application/json
   {
    "workspaceName":"hldk",
    "content":"meow",
    "config": {
        "model":"groq/llama3-groq-70b-8192-tool-use-preview"
    }
   }
   
   ```
   Set the `Accepts` header to `application/json` for JSON responses.

Examine the existing plugins in the `server/plugins/` directory.

**TIP: Add this repo as a workspace and ask the se-agent to create your plugin!**

### Prompt Placeholders

When implementing the `getSystemPrompt(context)` method in your agent, you can use the following placeholders in your prompt:

- `${context.sessionId}`: The current session ID
- `${context.requestId}`: The current request ID
- `${context.workspace.name}`: The name of the current workspace
- `${context.workspace.repoBaseDir}`: The base directory of the repository
- `${context.workspace.remoteRepoUrl}`: The remote URL of the repository
- `${context.workspace.buildOrTestCommand}`: The build or test command for the workspace
- `${context.repositoryTree()}`: The directory tree of the repository
- `${context.repositoryHints()}`: The contents of the hints.md file in the repository root

These placeholders will be automatically replaced with their corresponding values when the prompt is generated. Use them to provide context-specific information to your agent.

## Troubleshooting

TBD

## Contact

If you have any questions then please email adam.chesney@incept5.com
