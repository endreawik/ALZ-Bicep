
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#
# Module: Management Groups - OK
#
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

$inputObject = @{
    DeploymentName        = -join ('alz-MGDeployment-{0}' -f (Get-Date -Format 'yyyyMMddTHHMMssffffZ'))[0..63]
    Location              = 'norwayeast'
    TemplateFile          = "infra-as-code/bicep/modules/managementGroups/managementGroups.bicep"
    TemplateParameterFile = 'infra-as-code/bicep/modules/managementGroups/parameters/managementGroups.parameters.all.json'
  }
  New-AzTenantDeployment @inputObject

##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#
# Module: Custom Policy Definitions - OK
#
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

$inputObject = @{
    DeploymentName        = -join ('alz-PolicyDefsDeployment-{0}' -f (Get-Date -Format 'yyyyMMddTHHMMssffffZ'))[0..63]
    Location              = 'norwayeast'
    ManagementGroupId     = 'andreas'
    TemplateFile          = "infra-as-code/bicep/modules/policy/definitions/customPolicyDefinitions.bicep"
    TemplateParameterFile = 'infra-as-code/bicep/modules/policy/definitions/parameters/customPolicyDefinitions.parameters.all.json'
  }
  
  New-AzManagementGroupDeployment @inputObject



##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#
# Module: Custom Role Definitions - OK
#
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

$inputObject = @{
    DeploymentName        = -join ('eaw-CustomRoleDefsDeployment-{0}' -f (Get-Date -Format 'yyyyMMddTHHMMssffffZ'))[0..63]
    Location              = 'norwayeast'
    ManagementGroupId     = 'andreas'
    TemplateFile          = "infra-as-code/bicep/modules/customRoleDefinitions/customRoleDefinitions.bicep"
    TemplateParameterFile = 'infra-as-code/bicep/modules/customRoleDefinitions/parameters/customRoleDefinitions.parameters.all.json'
  }
  
  New-AzManagementGroupDeployment @inputObject




























##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#
# Module: Logging, Automation & Sentinel
#
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

# For Azure Global regions
# Set Platform management subscripion ID as the the current subscription
$ManagementSubscriptionId = "[your platform management subscription ID]"

# Set the top level MG Prefix in accordance to your environment. This example assumes default 'alz'.
$TopLevelMGPrefix = "andreas"

# Parameters necessary for deployment
$inputObject = @{
  DeploymentName        = -join ('alz-LoggingDeploy-{0}' -f (Get-Date -Format 'yyyyMMddTHHMMssffffZ'))[0..63]
  ResourceGroupName     = "rg-$TopLevelMGPrefix-logging-001"
  TemplateFile          = "infra-as-code/bicep/modules/logging/logging.bicep"
  TemplateParameterFile = "infra-as-code/bicep/modules/logging/parameters/logging.parameters.all.json"
}

Select-AzSubscription -SubscriptionId $ManagementSubscriptionId

# Create Resource Group - optional when using an existing resource group
New-AzResourceGroup `
  -Name $inputObject.ResourceGroupName `
  -Location norwayeast

New-AzResourceGroupDeployment @inputObject

##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#
# Module: Logging, Automation & Sentinel
#
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####



##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#
# Module: Orchestration - mgDiagSettingsAll - Enable diagnostic settings for management groups in the ALZ Management Groups hierarchy
#
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

$inputObject = @{
  DeploymentName        = -join ('eaw-mgDiagSettingsAllDeployment-{0}' -f (Get-Date -Format 'yyyyMMddTHHMMssffffZ'))[0..63]
  Location              = 'norwayeast'
  ManagementGroupId     = 'andreas'
  TemplateFile          = "infra-as-code/bicep/orchestration/mgDiagSettingsAll/mgDiagSettingsAll.bicep"
  TemplateParameterFile = 'infra-as-code/bicep/orchestration/mgDiagSettingsAll/parameters/mgDiagSettingsAll.parameters.all.json'
}
  
New-AzManagementGroupDeployment @inputObject


##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#
# Module: ALZ Default Policy Assignments
#
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

$inputObject = @{
    DeploymentName        = -join ('alz-alzPolicyAssignmentDefaultsDeployment-{0}' -f (Get-Date -Format 'yyyyMMddTHHMMssffffZ'))[0..63]
    Location              = 'norwayeast'
    ManagementGroupId     = 'andreas'
    TemplateFile          = "infra-as-code/bicep/modules/policy/assignments/alzDefaults/alzDefaultPolicyAssignments.bicep"
    TemplateParameterFile = 'infra-as-code/bicep/modules/policy/assignments/alzDefaults/parameters/alzDefaultPolicyAssignments.parameters.all.json'
  }
  
  New-AzManagementGroupDeployment @inputObject