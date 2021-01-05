# nexus-tekton

We want to pull an artefact from nexus, then build and deploy as a containerized app.

## Steps

### Task: Git-Clone: Clone Dockerfile and other files from Git

### Task: Nexus-Pull: Using curl, we download the nexus artefact and copy it into the cloned repo

### Task: Build-Push: Build an image from artefact using the Dockerfile, push to internal repo
