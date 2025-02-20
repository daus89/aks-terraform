output "prod_load_balancer_url" {
  description = "Prod environment URL"
  value       = "http://${module.k8s.lb_ip}"
}