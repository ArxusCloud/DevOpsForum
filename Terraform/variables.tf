variable "name" {
  type        = string
  description = "General Name"
}

variable "location" {
  type        = string
  description = "Location"
}


locals {
    rg-name = format("rg-%s", var.name)
    ai-name = var.name
    asp-name = format(var.name, "%s-plan")
    as-name = var.name
}