# Create k8s namespace

resource "kubernetes_namespace" "env_namespace" {
  metadata {
    name = var.environment
  }
}

# Create config map for the HTML page

resource "kubernetes_config_map" "nginx_html" {
  metadata {
    name      = "nginx-html"
    namespace = kubernetes_namespace.env_namespace.metadata[0].name
  }

  data = {
    "index.html" = "<html><body><h1>This is ${var.environment} environment.</h1></body></html>"
  }
}

# Create Nginx Deployment

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.env_namespace.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"

          port {
            container_port = 80
          }

          volume_mount {
            mount_path = "/usr/share/nginx/html"
            name       = "html"
          }
        }

        volume {
          name = "html"

          config_map {
            name = kubernetes_config_map.nginx_html.metadata[0].name
          }
        }
      }
    }
  }
}

# Expose Nginx via Load Balancer service

resource "kubernetes_service" "lb_service" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.env_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}