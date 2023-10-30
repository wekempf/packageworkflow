# Package Workflow

This isn't a real repository. This is a scratch repository used by me to explore GitHub actions, specifically for creating workflows that handle package creation and publishing (the type of the package isn't relevant). The goals are to create two jobs, one to build the package and the other to publish it. When creating a pull request the workflow should build the package, but not publish it. Instead, if the slash command `/publish` is provided in a comment in the pull request, then the package should be published, allowing for on demand publishing of *beta* releases of the package. Likewise when merging to the main branch the package should be built, but not published. Instead, the package will be published when a release is created.

## build.ps1

I've used [PSubShell](https://github.com/wekempf/PSubShell) and created a `build.ps1` file, but this build script simply simulates building and publishing. I'm a firm believer in having the majority of the build and publish logic in a build script that the developer can run locally, with the CI/CD workflow being as thin a wrapper around that script as possible. This keeps the developer from having to commit and push changes just to realize the CI/CD pipeline fails on the build server.
