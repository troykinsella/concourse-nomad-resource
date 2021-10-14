# Concourse Nomad Resource

A [Concourse CI](https://concourse-ci.org) resource for manipulating [HashiCorp Nomad](https://www.nomadproject.io).

The resource image contains the latest available version of `nomad`, installed by apt, as
of when the image was created.

See [Docker Hub](https://cloud.docker.com/repository/docker/troykinsella/concourse-nomad-resource)
for tagged image versions available.

## Source Configuration

* `address`: Required.
* `token`: Optional.
* `region`: Optional.
* `namespace`: Optional.

### Example

```yaml
resource_types:
- name: nomad
  type: docker-image
  source:
    repository: troykinsella/concourse-nomad-resource
    tag: develop

resources:
- name: nomad
  type: nomad
  source:
    address: https://nomad-0.your-stuff.com:4646
    token: ((nomad_api_token))
    namespace: foobis
```

## Behaviour

### `check`: No Op

### `in`: No Op

### `out`: Execute `nomad`

Execute a `nomad` `job plan`, `job run`, or `job stop` command.

#### Parameters

* `dir`: Required. The directory in which `nomad` executes.
* `job_file`: Optional. The path to the nomad HCL job file.
* `job_name`: Optional. 
* `job_stop`: Optional. Boolean.
* `job_plan`: Optional. Boolean.
* `job_run`: Optional. Boolean.

#### Example

```yaml
# Extends example in Source Configuration

jobs:
- name: deploy
  plan:
  - get: master # git resource
  - put: nomad
    params:
      dir: master/nomad
      job_file: job.hcl
      job_run: true
```

## Testing

```bash
docker build .
```

## License

MIT © Troy Kinsella
