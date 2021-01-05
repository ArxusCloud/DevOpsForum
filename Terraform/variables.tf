variable "name" {
  type        = string
  description = "General Name"
}

variable "location" {
  type        = string
  description = "Location"
}


locals {
    rg-name = "rg-${var.name}"
    ai-name = var.name
    asp-name = "${var.name}-plan"
    as-name = var.name
}