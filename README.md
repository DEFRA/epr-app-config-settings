# Config Settings

## Introduction

This repository contains configurations for Function Apps and Web Apps for various environments.

The configuration is split by environments and stored in the following folders:

- [devX](dev) - DEV environments 1-7 and 9
- [dev8](dev8) - DEV environment 8 (PRE-TST)
- [tst1](tst1) - TST environment
- [pre1](pre1) - PRE PRD environment
- [prd1](prd1) - PRD environment

## DevX setup

DevX environments share the same JSON templates for app configuration. The values are populated from ADO variables using the token replace task. ADO variables are defined in YAML var files (`pipelines/vars` folder) and can be overwritten by a higher priority var file. Here's a list of the files:

- `common.yaml` - common values shared across all/most environment
- `development.yaml` - common values for the DEV environments, this overwrites the `common.yaml` ones.
- `dev1.yaml` - DEV environment 1. Values defined here have the highest priority. Each dev environment has it's own configuration file that can be used for env specific overwrites.  However there are a few pipelines that use the <b>dev1.yaml</b> template without the <b>common.yaml</b> and the <b>development.yaml</b> files, so to ensure these pipelines run successfully, <b>dev1.yaml</b> has to declare its own copy of variables normally held in <b>development.yaml</b>



If the JSON template uses an ADO variable it needs to be wrapped in  `#{{` and `}}` to inject the value into the actual setting.
Here is an example how to set `myapp__configvar1` using the ADO variable `ado.variable1`:

```JSON
...
  {
    "name": "myapp__configvar1",
    "slotSetting": false,
    "value": "#{{ ado.variable1  }}"
  },
```

# Release versions

Release pipelines can reference this repository via git repo tag for easy Docker ImageTags reference. Image tags are defined in Yaml files stored under `pipelines/image-tags` and are loaded as ADO variables.

In order to create a new release:

1. Update the content of the `tst.yaml`, `preprod.yaml` and `prod.yaml` files with the corresponding Docker Tags used in that release
2. Merge the changes into main
3. Create a git tag named `Release-MAJOR.MINOR.PATCH` e.g. Release-2.8.2 that points to the relevant commit (HEAD in main)

# Contributing to this project
Please read the [contribution guidelines](CONTRIBUTING.md) before submitting a pull request.

# Licence
[Licence information](LICENCE.md).