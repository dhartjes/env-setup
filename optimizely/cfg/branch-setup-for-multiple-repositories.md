# Branch Setup for Multiple Repositories

<-- [Back to CFG Setup](README.md)

Wausau has two repositories for Configured Commerce source code. Listed beneath each are the branches involved in building/deploying the application.

|Repository URL|Branch|Use|
|-|-|-|
|https://github.com/OptimizelyB2BES/wausausupply.git|origin/sandbox|Automated build and deploy to DEV (sandbox) environment|
|https://github.com/OptimizelyB2BES/wausausupply.git|origin/production|Automated build ONLY for PRD environment|
|https://github.com/OptimizelyB2BES/wausausupply2.git|origin/sandbox|Automated build and deploy to QA (sandbox2) environment|

When the wausausupply2 repo was created, base code was pulled in first and then all modified code from wausausupply was brought in via copy and paste. This approach is not great; code and build artifacts get included that ought to be ignored, git history is lost, and it feels clunky and error prone.

## How to set up the new repo:

1. Clone the original repo (wausausupply).
    ```
    git clone https://github.com/OptimizelyB2BES/wausausupply.git
    cd wausau
    git fetch origin
    ``` 

1. Add tracking for desired branches
    ```
    git branch --track origin sandbox
    git branch --track origin <main/master>
    ```

1. Remove the old remote (origin pointing to wausausupply).
    ```
    git remote remove origin
    ```

1. Add a new remote pointing to the new repo (wausausupply2).
    ```
    git remote add origin https://github.com/OptimizelyB2BES/wausausupply2.git
    ```

1. Push the code to the new repo.
    ```
    git push --all origin
    ```

## How to merge across repos using git using remotes
 
Set up the remote relationship from within the original sandbox repository. Add a remote named "ade" that points to the sandbox2 repository.
 
```
cd wausau
git remote add ade https://github.com/OptimizelyB2BES/wausausupply2.git
git remote -v
```
 
## Structure of git remotes and branches
 
Branch roles:
|Repo Name|Branch Name|Use|
|-|-|-|
|Wausausupply (DEV)|master|Not really used. In essence, sandbox is the master/main branch.|
|Wausausupply (DEV)|sandbox|The DEV release branch. Acts as master/main branch. Auto builds and deploys to DEV environment. Also the integration branch for any bugs/features.|
|Wausausupply (DEV)|production|The PROD release branch. Auto builds only. Support deploys build artifacts to PROD environment. Sometimes branches are created from production in the event of hotfixes while another effort is ongoing in sandbox.|
|Wausausupply (DEV)|(All other)|Bug/feature branches.|
|Wausausupply2 (ADE)|main|The integration branch between Wausausupply (DEV) and Wausausupply2 (ADE).|
|Wausausupply2 (ADE)|sandbox|The ADE release branch. Auto builds and deploys to ADE environment.|

## Moving between branches

### From local to DEV deploy

Checkout sandbox and pull.
Merge changes and push.

### From DEV to ADE deploy

Important! Before moving to a higher target branch, ensure that branch is fully synced down into the lower branch.

#### Merging down

1. From within local ADE repo:
    - Checkout ade/sandbox and pull.
    - Checkout ade/main and pull.
    - Merge ade/sandbox into ade/main and push.
1. Switch to local DEV repo:
    - Checkout remote ade/main and pull.
    - Checkout sandbox and pull.
    - Merge remote ade/main into sandbox and push.

#### Merging up

1. From within local DEV repo:
    - Checkout sandbox and pull.
    - Checkout remote ade/main and pull.
    - Merge sandbox into remote ade/main and push.
1. Switch to local ADE repo:
    - Checkout ade/main and pull.
    - Checkout ade/sandbox and pull.
    - Merge ade/main into ade/sandbox.
    - Build extensions and push.

### From ADE to PROD deploy

Important! Before moving to a higher target branch, ensure that branch is fully synced down into the lower branch.

#### Merging down

1. From within local DEV repo (ADE repo has no production branch):
    - Checkout production and pull.
    - Checkout ade-main (alias for "ade" remote and "main" branch) and pull.
    - Merge production into ade-main and push.
1. Switch to local ADE repo:
    - Checkout main and pull.
    - Checkout sandbox and pull.
    - Merge main into sandbox and push.

#### Merging up

1. From within local ADE repo:
    - Checkout sandbox and pull.
    - Checkout main and pull.
    - Merge sandbox into main and push.
1. Switch to local DEV repo:
    - Checkout ade-main and pull.
    - Checkout production and pull.
    - Merge ade-main into production.
    - Build extensions and push.

### Naming scheme for identification of remote/branch name

Track the remote main branch using a different name locally.
 
```
git fetch ade main
git checkout -b ade-main ade/main

git fetch ade sandbox
git checkout -b ade-sandbox ade/sandbox
```
 
<-- Prev: [.NET Framework 4.8 Setup](cfg-dotnet-framework-setup.md)
--> Next: [IIS Setup](iis-setup.md)
