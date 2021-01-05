provider "azurerm" {
#  version = "=2.41.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devopsforum-tf"
    storage_account_name = "sadevopsforumtf"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "rg-devopsforum" {
  name     = "rg-devopsforum"
  location = "westeurope"
}

resource "azurerm_application_insights" "ai-devopsforum" {
  name                = "DevOpsForum"
  location            = azurerm_resource_group.rg-devopsforum.location
  resource_group_name = azurerm_resource_group.rg-devopsforum.name
  application_type    = "web"
}

resource "azurerm_app_service_plan" "asp-devopsforum" {
  name                = "DevOpsForum-plan"
  location            = azurerm_resource_group.rg-devopsforum.location
  resource_group_name = azurerm_resource_group.rg-devopsforum.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "as-devopsforum" {
  name                = "DevOpsForum"
  location            = azurerm_resource_group.rg-devopsforum.location
  resource_group_name = azurerm_resource_group.rg-devopsforum.name
  app_service_plan_id = azurerm_app_service_plan.asp-devopsforum.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = azurerm_application_insights.ai-devopsforum.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = azurerm_application_insights.ai-devopsforum.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~2"
    "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
    "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
  }
}