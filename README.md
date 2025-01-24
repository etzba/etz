# etz

- [Installing](#installing)
	- [etzba darwin amd64 v1](#etzba-darwin-amd64-v1)
    - [etzba linux amd64 v1](#etzba-linux-amd64-v1)
- [Configuring test cases](#configuring-test-cases)
	- [General Config](#general-config)
    - [Executions](#executions)
        - [Api](#api)
        - [Sql](#sql)
        - [File](#file)
- [Usage](#usage)
	- [Run etz with general config](#run-etz-with-general-config)
    - [Run etz with executions file](#run-etz-with-executions-file)
    - [Cli args](#cli-args)
    - [Examples](#examples)
- [Advanced configurations](#advanced-configurations)
    - [Use authentication file](#use-authentication-file)
    - [Using go template](using-go-template)

### Installing

To download and install `etz`:  

#### Linux installation

To download the file for linux: [etzba_linux_amd64_v1](repo/blob/master/etzba_linux_amd64_v1/etz)

Move the file to `/usr/bin`:

``` sh
mv ~/Downloads/etz /usr/bin/
etz --version
```

#### Installation on a mac

To download the file for iOS: [etzba_darwin_amd64_v1](repo/blob/master/etzba_darwin_amd64_v1/etz)

Move the file to `/usr/local/bin`:

``` sh
mv ~/Downloads/etz /usr/local/bin/
etz --version
```

### Configuring test cases

To run `etz` a configuration or executions file is needed

#### General config

``` yaml
settings:
  config:
    workers: 10   # number of workers during execution
    rps: 2    # request per second during execution
    duration: 3s   # execution duration
    output: /tmp/results.json   # results output file
    verbose: true   # debug workers during execution    

executions:
  locations:    # scenario name
    api:
    - url: http://localhost:8080/locations
      method: GET
    - url: http://localhost:8080/locations/2
      method: GET
  files:       # scenario name
    file:
    - url: http://localhost:8080/posts
      method: POST
      directory: myfiles/
```

#### Executions

`etz` has the ability to execute a specific tests for `api`, `sql` and upload a `file` to api server. This section will show how to create executions configuration for each kind. 

##### api

To prepare test against an http service, create `executions.yaml` file on your local machine, similar to the file below:

``` yaml
api:
- url: https://etzba.com/v1/some/endpoint
  method: GET
- url: https://etzba.com/v1/some/endpoint
  method: POST
```

##### sql

`pg` command will test the performance of postgresql instance by creating an execution file for sql:

``` yaml
sql:    # list of sql queries
- command: SELECT
  table: locations
  constraint: "longtitude BETWEEN 13.0 AND 15.0"
- command: UPDATE
  table: locations
  constraint: "longtitude BETWEEN 13.0 AND 15.0 AND latitude BETWEEN 13.0 AND 15.0"
  values: 
    latitude: 14.232134112
- command: INSERT
  table: locations
  values: 
    name: "someplace"
    address: "better_street_32" 
    longtitude: 89.123123123
    latitude: -98.1234123123
```

##### file

`file` execution will test the performance of file upload to an api server. A `file` execution yaml example:

```yaml
file:
- url: http://localhost:8080/posts
  method: POST
  directory: path/posts/
- url: http://localhost:8080/pics
  method: PUT
  directory: images/
```

### Usage

After installing `etz` locally and create a config or execution file, you can run tests from terminal with general config or execution file.

#### Run etz with general config

To run a test with general config:

```sh
etz --config=path/to/config.yaml
```

#### Run etz with executions file

`etz` has few more commands that can use also

```sh
etz api --auth=examples/api/gopu/secret.yaml --exec=examples/api/gopu/executions.yaml -d=8s -w=6 -r=24 --output=files/$$(date +%Y%m%d_%H%M%S)_result.json
```

```sh
etz pg --workers=3 --auth=examples/pgsql/secret.json --exec=examples/pgsql/executions.yaml --duration=3s
```

```sh
etz file --url=http://localhost:8080/docs --method=PUT --path=assets/ -w=6 -r=6 -v
```

#### Cli args

| Arg        | Type     | Description  |
| ---------- | -------- | ------------ |
| `workers`  | int      | How many go routines to run during the test. For exmaple: `--workers 12` |
| `rps`      | int      | Define request per second while running api test. For exmaple: `-r 20`   |
| `duration` | str      | Using `-d` define for how long the test should run. For example: `-d 30s` will run the test for 30 seconds. s/m/h are the available time units |
| `auth`     | str      | To use additional authentication file. |
| `exec`     | str      | While using executions file. |
| `config`   | str      | While using general config file. |
| `url`      | str      | Specify api service URL for the test, instead of specifying url in the file. |
| `output`   | str      | Generate a test results file in json. For example: `--output=~/results/20250123_result.json` |
| `verbose`  | bool     | To show logs from workers while running the test. |

#### Examples

These are few extended usage examples to run `etz` from cli: 

``` sh
etz --config=examples/pgsql/config.yaml
etz api --auth=examples/api/gopu/secret.yaml --exec=examples/api/gopu/executions.yaml -d=8s -w=6 -r=24 --output=files/$$(date +%Y%m%d_%H%M%S)_result.json
etz pg --workers=3 --auth=examples/pgsql/secret.json --exec=examples/pgsql/executions.yaml --duration=3s
etz file --url=http://localhost:8080/docs --method=PUT --path=assets/ -w=6 -r=6 -v
etz file --exec=examples/api/gopu/fileup.yaml -d=3s -w=1 -r=1
etz api --exec=examples/api/gopu/executions.yaml -d=8s -w=4 -r=12 --output=files/$$(date +%Y%m%d_%H%M%S)_result.json
```

### Advanced configurations

#### Use authentication file


#### Using go template

Creating variables and using functions inside yaml file is possible as well. For example:

``` yaml
{{ $baseUrl := printf "%s" "http://localhost:8080" }}
{{ $dir := printf "%s" "assets/" }}
{{ $slice := makeIntSlice 1 2 3 4 }}

settings:
  config:
    workers: 10   # number of workers during execution
    rps: 2    # request per second during execution
    duration: 3s   # execution duration
    output: /tmp/results.json   # results output file
    verbose: true   # debug workers during execution    

executions:
  locations:    # scenario name
    api:
    {{ range $slice }}
    - url: {{ $baseUrl }}/locations/{{ . }}
      method: GET
    {{ end }}
  files:
    file:
    - url: {{ $baseUrl }}/posts
      method: POST
      directory: {{ $dir }}
    - url: {{ $baseUrl }}/pics
      method: PUT
      directory: {{ $dir }}
```
For more details: [go template](https://pkg.go.dev/text/template)

##### Built-in yaml golang templates functions

