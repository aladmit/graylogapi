# GraylogAPI

[![Gem Version](https://img.shields.io/gem/v/graylogapi.svg)][gem]
[![Build Status](http://img.shields.io/travis/postgred/graylogapi.svg)][travis]

[gem]: https://rubygems.org/gems/graylogapi
[travis]: https://travis-ci.org/postgred/graylogapi

# I don't care about this repo anymore. I think you shouldn't use this.

Ruby gem for working with [Graylog](https://www.graylog.org/) via the [Graylog REST API](http://docs.graylog.org/en/2.2/pages/configuration/rest_api.html?highlight=API)

## Installation

    gem install graylogapi
## Dependencies

- net/http
- json

## Graylog documentation

- [Graylog Homepage][Graylog]
- [Graylog API docs][GraylogAPI]

[Graylog]: https://www.graylog.org/
[GraylogAPI]: http://docs.graylog.org/en/2.2/pages/configuration/rest_api.html?highlight=API

## Usage

Structure of gem looks like Graylog REST Api or navigation menu in UI.
For example, you can find *Inputs* in *System/Inputs* in the UI and you can find *Inputs* in `GraylogAPI.new(...).system.inputs` in the gem.



### Authorization

#### user and password

```
graylogapi = GraylogAPI.new(base_url: 'http://localhost:9000/api', user: 'username', pass: 'password')
```

#### token

```
graylogapi = GraylogAPI.new(base_url: 'http://localhost:9000/api', token: 'token')
```



### Examples

#### get Input by id

    graylogapi = GraylogAPI.new(base_url: 'http://localhost:9000/api', user: 'username', pass: 'password')
    
    graylogapi.system.inputs.by_id('5947d3840b5712166af25009')

You can find more examples [here](./examples/)

## Supported methods

* **Alerts**: Manage stream alerts for all streams
  * recent(params) — Get the most recent alarms of all streams.
  * paginated(params) — Get alarms of all streams, filtered by specifying limit and offset parameters.
  * by_id(id, params) — Get an alert by ID.
* **Dashboards**: Manage dashboards
  * create(params) — Create a dashboard.
  * all — Get a list of all dashboards and all configurations of their widgets.
  * by_id(id) — Get a single dashboards and all configurations of its widgets.
  * update(id, params) — Update the settings of a dashboard.
  * delete(id) — Delete a dashboard and all its widgets.
* **StaticFields**: Static fields of an input.
  * create(input_id, params) — Add a static field to an input.
  * delete(input_id, key) — Remove static field of an input.
* **Streams**: Manage streams
  * all — Get a list of all streams.
  * create(params) — Create a stream.
  * enabled — Get a list of all enabled streams.
  * by_id — Get a single stream.
  * update(id, params) — Update a stream.
  * delete(id) — Delete a stream.
  * clone(id, params) — Clone a stream.
  * pause(id) — Pause a stream.
  * resume(id) — Resume a stream.
* **System**: System informatino of this node.
  * overview — Get system overview.
  * jvm — Get JVM information.
  * thread_dump — Get a thread dump.
* **System/Cluster**: Node discovery
  * node — Infromation about this node.
  * nodes — List all active nodes in this cluster.
  * node_by_id — Infromation about a node.
* **System/IndexSets**: Index sets
  * all — Get a list of all index sets.
  * default — Get default index set.
  * create(params) — Create index set.
  * update(params) — Update index set.
  * make_default(id) — Set default index set.
  * by_id(id) — Get index set by id.
  * delete(id) — Delete index set.
* **System/Inputs**: Message inputs
  * all — Get all inputs.
  * by_id(id, params) — Get information of a single input on this node.
  * create(params) — Launch input on this node.
  * update(params) — Update input on this node.
  * delete(id) — Terminate input on this node.
* **System/Inputs/Types**: Message input types of this node.
  * node — Get all available input types of this node.
  * all — Get informatino about all input types.
  * by_type(type) — Get information about a single input type.
  * name_to_type(name) — Convert name of type to type.
* **Users**: User accounts.
  * tokens(username) — Retrieves the list of access tokens for a user.
  * create_token(username, name) — Generate a new access token for a user.
  * delete_token(username, name) — Removes a token for a user.


## Copyright

Copytight (c) 2017 Andrey Aleksandrov

See [LICENSE][] for details.

[license]: LICENSE.md
