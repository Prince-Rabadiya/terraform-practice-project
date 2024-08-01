terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///Users/princerabadiya/.docker/run/docker.sock"
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper = false
}

resource "random_string" "random2" {
  length  = 4
  special = false
  upper = false
}

resource "docker_container" "nodered_container" {
  name  = join("-", ["nodered", random_string.random.result])
  image = docker_image.nodered_image.image_id
  ports {
    internal = 1880
    external = 1880
  }
}

resource "docker_container" "nodered_container2" {
  name  = join("-", ["nodered", random_string.random2.result])
  image = docker_image.nodered_image.image_id
  ports {
    internal = 1880
    external = 1881
  }
}

output "IP_Address" {
  value = docker_container.nodered_container.network_data[0].ip_address
  description = "IP Address of the container"
}

output "name" {
  value = docker_container.nodered_container.name
  description = "Name of the container"
}