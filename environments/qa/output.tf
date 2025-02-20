output "qa_load_balancer_url" {
  description = "QA environment URL"
  value       = "http://${module.k8s.lb_ip} renders This is qa environment"
}