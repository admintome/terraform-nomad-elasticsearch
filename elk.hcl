job "logging" {

  type = "service"

  datacenters = ["dc1"]
  
  update {
    stagger = "30s"
    max_parallel = 1
  }

  group "elk" {
    count = 1

    task "elasticsearch" {
      driver = "docker"

      config {
	image = "docker.elastic.co/elasticsearch/elasticsearch:5.6.3"
	port_map = {
	  es = 9200
	  ed = 9300
	}
      }

      resources {
	cpu = 1000
	memory = 4000
	network {
	  mbits = 10
	  port "es" {}
	  port "ed" {}
	}
      }

      env {
	discovery.type = "single-node"
      }

      service {
	name = "elasticsearch"
	tags = ["global","elasticsearch"]
	port = "es"
	check {
	  name = "alive"
	  type = "tcp"
	  interval = "10s"
	  timeout = "2s"
	}
      }
    }
  }
}

	
