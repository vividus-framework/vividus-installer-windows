<#
.SYNOPSIS
vividus-installer -- Tool that help to install environment to use vividus-framework

The following options are available:

     install     sets up vividus environment including JDK, IDE and environment variables.

                 Install process can be customized by adding following flags:
                 --java        install or update java and set JAVA_HOME environment variable
                 --eclipse     install latest Eclipse framework
                 --build-system
                               install or update vividus build system and set BUILD_SYSTEM_ROOT environment variable

                 By default (without any flags) full installation will be performed.
                 
.EXAMPLE
     vividus-installer install
     sets up vividus environment including IDE and environment variables.

.EXAMPLE
     vividus-installer install --build-system
     install or update vividus build system and set BUILD_SYSTEM_ROOT environment variable
#>

param (
	[String]$parameter = $(Read-Host -prompt "Enter the parameter. For the list of parameters enter `"help`".")
)

function Install-Jdk
{
	scoop bucket add java
	scoop install oracleJDK
}

function Install-BuildSystem
{
	if (Test-Path -Path $ENV:UserProfile\vividus\vividus_build_system)
	{
		Remove-Item -Path $ENV:UserProfile\vividus\vividus_build_system -recurse -force
	}
	git clone https://github.com/vividus-framework/vividus-build-system.git $ENV:UserProfile\vividus\vividus_build_system
	[Environment]::SetEnvironmentVariable("BUILD_SYSTEM_ROOT", "$ENV:UserProfile\vividus\vividus_build_system", "User")
	$env:BUILD_SYSTEM_ROOT = [System.Environment]::GetEnvironmentVariable("BUILD_SYSTEM_ROOT", "User")
}

function Install-Eclipse
{
	Install-Jdk
	scoop install eclipse-java
	[string]$eclipsePath = scoop prefix eclipse-java
	Set-Location -Path $eclipsePath
	./eclipsec.exe -application org.eclipse.equinox.p2.director -repository "http://jbehave.org/reference/eclipse/updates/" -installIU "org.jbehave.eclipse.feature.feature.group"
}

function Install-ByArgs
{
	if ($Script:args.count -eq 0)
	{
		Install-Eclipse
		Install-BuildSystem
		return
	}
	foreach ($option in $Script:args)
	{
		switch ($option)
		{
			"--java" {
				Install-Jdk
			}
			"--eclipse" {
				Install-Eclipse
			}
			"--build-system" {
				Install-BuildSystem
			}
			default {
				"Unknown option `"$option`""
			}
		}
	}
}

if ($parameter -eq "install")
{
	scoop bucket add extras
	Install-ByArgs
}
else
{
	$currentDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
	Get-Help $currentDirectory\vividus-installer.ps1
}
