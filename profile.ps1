
#Begin Azure PowerShell alias import
Import-Module Az.Profile -ErrorAction SilentlyContinue -ErrorVariable importError
if ($importerror.Count -eq 0) {
    Enable-AzureRmAlias -Module Az.RecoveryServices, Az.ManagedServiceIdentity, Az.ApplicationInsights, Az.Compute.ManagedService, Az.Billing, Az.ContainerInstance, Az.Reservations, Az.Scheduler, Az.DataFactories, Az.SignalR, Az.Tags, Az.Automation, Az.MachineLearning, Az.DataLakeStore, Az.HDInsight, Az.ServiceBus, Az.StreamAnalytics, Az.Resources, Az.ContainerRegistry, Az.DataFactoryV2, Az.ResourceGraph, Az.PolicyInsights, Az.Cdn, Az.RedisCache, Az.Relay, Az.RecoveryServices.Backup, Az.AnalysisServices, Az.IotHub, Az.Subscription, Az.Websites, Az.Maps, Az.LogicApp, Az.Dns, Az.Profile, Az.CognitiveServices, Az.DeviceProvisioningServices, Az.Insights, Az.Sql, Az.ManagementPartner, Az.Aks, Az.DevSpaces, Az.Batch, Az.Search, Az.MachineLearningCompute, Az.KeyVault, Az.Backup, Az.TrafficManager, Az.Storage, Az.StorageSync, Az.UsageAggregates, Az.Media, Az.ServiceFabric, Az.PowerBIEmbedded, Az.Compute, Az.EventHub, Az.Consumption, Az.ApiManagement, Az.OperationalInsights, Az.MarketplaceOrdering, Az.RecoveryServices.SiteRecovery, Az.Network, Az.DataLakeAnalytics, Az.Security, Az.EventGrid, Az.DataMigration, Az.NotificationHubs -ErrorAction SilentlyContinue;
}
#End Azure PowerShell alias import

#Begin Posh Git settings
Import-Module posh-git

$GitPromptSettings.DefaultPromptWriteStatusFirst = $true
#$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n$([DateTime]::now.ToString("MM-dd HH:mm:ss"))'
#$GitPromptSettings.DefaultPromptBeforeSuffix.ForegroundColor = 0x808080
$GitPromptSettings.DefaultPromptSuffix = '`n ~> '
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = 0xffb347
#End Posh Git settings

Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -EditMode Emacs

function Invoke-PesterJob {
    [CmdletBinding(DefaultParameterSetName = 'LegacyOutputXml')]
    param(
        [Parameter(Position = 0)]
        [Alias('Path', 'relative_path')]
        [System.Object[]]
        ${Script},

        [Parameter(Position = 1)]
        [Alias('Name')]
        [string[]]
        ${TestName},

        [Parameter(Position = 2)]
        [switch]
        ${EnableExit},

        [Parameter(ParameterSetName = 'LegacyOutputXml', Position = 3)]
        [string]
        ${OutputXml},

        [Parameter(Position = 4)]
        [Alias('Tags')]
        [string[]]
        ${Tag},

        [string[]]
        ${ExcludeTag},

        [switch]
        ${PassThru},

        [System.Object[]]
        ${CodeCoverage},

        [switch]
        ${Strict},

        [Parameter(ParameterSetName = 'NewOutputSet', Mandatory = $true)]
        [string]
        ${OutputFile},

        [Parameter(ParameterSetName = 'NewOutputSet', Mandatory = $true)]
        [ValidateSet('LegacyNUnitXml', 'NUnitXml')]
        [string]
        ${OutputFormat},

        [switch]
        ${Quiet}
    )

    $params = $PSBoundParameters

    Start-Job -ScriptBlock { Set-Location $using:pwd; Invoke-Pester @using:params } |
        Receive-Job -Wait -AutoRemoveJob
}
Set-Alias ipj Invoke-PesterJob

Set-Location C:\

Clear-Host
Write-Host "
      ___                                ___           ___           ___           ___
     /__/\        ___                   /__/\         /  /\         /  /\         /__/|
     \  \:\      /  /\                 |  |::\       /  /::\       /  /::\       |  |:|
      \__\:\    /  /:/                 |  |:|:\     /  /:/\:\     /  /:/\:\      |  |:|
  ___ /  /::\  /__/::\               __|__|:|\:\   /  /:/~/::\   /  /:/~/:/    __|  |:|
 /__/\  /:/\:\ \__\/\:\__           /__/::::| \:\ /__/:/ /:/\:\ /__/:/ /:/___ /__/\_|:|____
 \  \:\/:/__\/    \  \:\/\          \  \:\~~\__\/ \  \:\/:/__\/ \  \:\/:::::/ \  \:\/:::::/
  \  \::/          \__\::/           \  \:\        \  \::/       \  \::/~~~~   \  \::/~~~~
   \  \:\          /__/:/             \  \:\        \  \:\        \  \:\        \  \:\
    \  \:\         \__\/               \  \:\        \  \:\        \  \:\        \  \:\
     \__\/                              \__\/         \__\/         \__\/         \__\/
" -ForegroundColor DarkGreen

Write-Host "$([DateTime]::now.ToString("MM-dd HH:mm:ss"))"