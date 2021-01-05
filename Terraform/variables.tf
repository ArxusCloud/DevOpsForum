variable "name" {
  type        = string
  description = "General Name"
}

variable "location" {
  type        = string
  description = "Location"
}


locals {
    rg-name = concat("rg-", var.name)
    ai-name = var.name
    asp-name = concat(var.name, "-plan")
    as-name = var.name
}