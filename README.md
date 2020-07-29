# Log Finder v1.0

![Log Finder](https://github.com/justAnotherDev/log-finder-action/workflows/Log%20Finder/badge.svg)

GitHub Action for searching a string to find all contained log files.


If you have a build log file that looks something like this:

```
Please update to the latest Carthage version: 0.35.0. You currently are on 0.34.0
*** No Cartfile.resolved found, updating dependencies
*** Fetching SomeProject
*** Fetching OtherProject
*** Checking out AnotherProject at "v3.17.3"
*** Checking out FinalProject at "1273cb428e0c9a43c1de964ef896c532ee67391e"
*** xcodebuild output can be found in /var/folders/wz/gfmnqb3x78sgz5vww3w2mrjh0000gn/T/carthage-xcodebuild.asdf.123.log
*** Building scheme "SomeProject-iOS" in AnotherProject.xcworkspace
*** Building scheme "SomeProject-watchOS" in AnotherProject.xcworkspace
*** Building scheme "OtherProject-watchOS" in FinalProject.xcodeproj\
*** Error, failed to build scheme. See error file: ./build-output/error.log for more info.
```

This action can parse the build log, and will return this:

```
/var/folders/wz/gfmnqb3x78sgz5vww3w2mrjh0000gn/T/carthage-xcodebuild.asdf.123.log
./build-output/error.log
```

This list can then easily be used with the [upload-artifact](https://github.com/actions/upload-artifact) action.


## Inputs


### `content`

The string to search for log files in.

- require: false


### `content-path`

The file(s) which contains the string to search for log files in.

- require: false


### `file-suffix`

The file type(s) to search for. Such as log, txt, etc.

- require: true

- default: log

## Outputs

### `log-files`

The found log file paths (separated by newlines).

## Example Usage

### Parsing a string to find all log and txt files

```yaml
- name: Find Log Files
  uses: justAnotherDev/log-finder-action@v1.0
  id: log-finder
  with:
    content: ${{ steps.some_build_step.outputs.build_output }}
    file-suffix: |
      log
      txt

- name: Upload Artifacts
  if: ${{ always() }}
  uses: actions/upload-artifact@v2
  with:
    name: build-logs
    path: ${{ steps.log-finder.outputs.log-files }}
```

### Parsing mutliple files to find all log files

```yaml
- name: Find Log Files
  uses: justAnotherDev/log-finder-action@v1.0
  id: log-finder
  with:
    content-path: |
      test/test.txt
      test/failure.log
```

For more example usage, see the [workflow](https://github.com/justAnotherDev/log-finder-action/blob/master/.github/workflows/main.yml) being used for tests.
