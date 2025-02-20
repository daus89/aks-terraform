output "dev_load_balancer_url" {
  description = "Dev environment URL"
  value       = "http://${module.k8s.lb_ip} renders This is dev environment"
}