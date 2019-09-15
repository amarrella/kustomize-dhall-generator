# Kustomize dhall generator plugin

This simple project is a generator for [Kustomize](https://www.kustomize.io) using [dhall](https://dhall-lang.org), which will allow to use dhall templates everywhere that supports Kustomize.

## Installation
To install the plugin, you need to copy it into your plugin path.
If you clone this repository, you can do:
```sh
cp -r plugin/ $XDG_CONFIG_HOME/kustomize/plugin/
```

If undefined, the default `$XDG_CONFIG_HOME` is `$HOME/.config`.

Note: this also assumes you have `dhall-to-yaml` (from `dhall-json`) in your `$PATH`.

## Usage
To use the plugin, create a yaml template like this
```yaml
# your_file.yaml
apiVersion: com.alessandromarrella/v0
kind: DhallGenerator
metadata:
  name: notImportantHere
packageLocation: {YOUR_PACKAGE_LOCATION}
```

And then you should list your generators in your `kustomization.yaml`:
```yaml
# kustomization.yaml
generators:
- your_file.yaml
```

See the `example` folder for a simple example with `nginx`.

