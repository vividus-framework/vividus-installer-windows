# vividus-installer-windows
vividus-installer installs and configures required environment for vividus Framework from the command line with a minimal amount of actions. It could be used for installation of:

- Build system required for vividus.
- Java Development Kit (JDK) requred for vividus.
- Integrated Development Environment (IDE) Eclipse

## How to use vividus-installer?
1. Install vividus-installer (see installation guide below)
2. Run vividus-installer with desired options from Powershell

### List of available commands
| Command | Description |
| --- | --- |
| vividus-installer install                  | Full installation          |
| vividus-installer install --build-system   | Install only Build system and environment variable BUILD_SYSTEM_ROOT                 |
| vividus-installer install --java           | Install only JDK and related environment variables                                   |
| vividus-installer install --eclipse        | Install Eclipse IDE and plugin for JBehave BDD framework (also JDK will be installed)|

Options could be chained in single command.
Example command below will install Java, Eclipse IDE and Build System:
```
vividus-installer install --java --eclipse --build-system
```
---
## Install
1. Install Scoop and Git
    - Open "Start" menu and type
       
        ```powershell 
        powershell
        ```

    - Make sure you have allowed PowerShell to execute local scripts:

        ```powershell
        set-executionpolicy remotesigned -scope currentuser
        ```
		
    - Install Scoop:

        ```powershell
        iwr -useb get.scoop.sh | iex
        ```
		
    - Install Git
	
        ```powershell
        scoop install git
        ```

2. Add Vividus Installer bucket to scoop:

    ```powershell
    scoop bucket add vividus-installer https://github.com/vividus-framework/vividus-installer-windows.git
    ```

3. Install vividus installer:

    ```powershell
    scoop install vividus-installer
    ```

4. Configure environment:

    ```powershell
    vividus-installer install
    ```

## Update
1. Update vividus installer:

    ```powershell
    scoop upgrade vividus-installer
    ```

## Help
To get more details about options use:

```powershell
vividus-installer help
```