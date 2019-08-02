workflow "BuildTagPush to Docker Hub" {
  on = "push"
  resolves = ["Metadata on Docker Hub"]
}

action "Docker Registry" {
  uses = "actions/docker/login@c08a5fc9e0286844156fefff2c141072048141f6"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Build" {
  uses = "actions/docker/cli@c08a5fc9e0286844156fefff2c141072048141f6"
  needs = ["Docker Registry"]
  args = "build -t mpepping/middleman  ."
}

action "Push" {
  uses = "actions/docker/cli@c08a5fc9e0286844156fefff2c141072048141f6"
  args = "push mpepping/middleman"
  needs = ["Build"]
}

action "Metadata on Docker Hub" {
  uses = "docker://mpepping/docker-hub-metadata-github-action"
  needs = ["Push"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  env = {
    IMAGE = "mpepping/middleman"
  }
}
