# etz

- [Install](#install)
	- [etzba darwin amd64 v1](#etzba-darwin-amd64-v1)
    - [etzba linux amd64 v1](#etzba-linux-amd64-v1)
- [Config](#config)
	- [General Config](#general-config)
    - [Executions](#executions)
- [CMD](#cmd)
	- [Run etz with general config](#run-etz-with-general-config)
    - [Run etz with executions file](#run-etz-with-executions-file)

### Install

To Download and install `etz`:  

#### etzba linux amd64 v1

[etzba_linux_amd64_v1](repo/blob/master/etzba_linux_amd64_v1/etz)

Move the file to `/usr/bin`:

```
mv ~/Downloads/etz /usr/bin/
etz --version
```

#### etzba darwin amd64 v1

[etzba_darwin_amd64_v1](repo/blob/master/etzba_darwin_amd64_v1/etz)

Move the file to `/usr/local/bin`:

```
mv ~/Downloads/etz /usr/local/bin/
etz --version
```

### Config

To run `etz` a configuration or executions file is needed

#### General config


#### Executions

##### api

##### sql

##### file

### CMD

#### Run etz with general config


#### Run etz with executions file


#### Cli params and args

| *Arg     | *Type    | *Description |
| -------- | -------- | ------------ |
| workers  | int      | how many go routines to run during the test. exmaple: `--workers 12`        |
| rps      | int      | define request per second while running api test. exmaple: `-r 20`        |
| duration | str      | using `-d` define for how long the test should run. example: `-d 30s` will run the test for 30 seconds. s/m/h are the available time units        |