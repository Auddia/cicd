# Deploy Keys
Deploy keys are used to allow our CI instances to install directly from private git repos. 
This is relevant for `git` and `pip` interactions with private repos.

## STEPS
1. Generate the ssh key for the specific repo you want ot grant access to.
   1. Here is a reference on [how to properly generate the key](https://github.com/webfactory/ssh-agent#support-for-github-deploy-keys).
   2. Command: `ssh-keygen -t ed25519 -C "<user>@github.com:Auddia/<repo>.git"`
      1. `user`: The git user specified when cloning the git repo
         1. Default/Recommended: `git` 
         2. `pip` defaults the user to git
      2. Name the key file `<repo>_deploy_key`
2. Add both the public and private ssh keys to the auddia 1Password
3. Add the generated **_public_** (i.e. the `.pub` file) key to the repos `deploy_keys`
   1. NOTE: To add the key you need to own or be an admin of the repo
   2. Here is a guide on [how to add a deploy key to a repo](https://docs.github.com/en/developers/overview/managing-deploy-keys#deploy-keys).
   3. Name the deploy key `<repo>-deploy-key`
4. Add the generated private key as a secret to the repos that need access to the private repo.
5. Enable SSH and add the secrets to the CI workflow
```yaml
    with:
      ...
      enable_ssh: true
    secrets:
      ssh_private_keys: |
        ${{ secrets.REPO_ONE_DEPLOY_KEY }}
        ${{ secrets.REPO_TWO_DEPLOY_KEY }}
```

***Note that in case of multiple deploy keys you must set the
multiple_deploy_keys flag to true in the cloud_run_api_deployment job***. See
[Using Multiple Deploy Keys Inside Docker
Builds](https://github.com/webfactory/ssh-agent#using-multiple-deploy-keys-inside-docker-builds)
for an explanation.
