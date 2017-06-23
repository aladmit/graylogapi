# GraylogAPI

[![Gem Version](https://img.shields.io/gem/v/graylogapi.svg)][gem]
[![Build Status](http://img.shields.io/travis/postgred/graylogapi.svg)][travis]

[gem]: https://rubygems.org/gems/graylogapi
[travis]: https://travis-ci.org/postgred/graylogapi

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

### get Input by id

    graylogapi = Graylog.new('http://localhost:9000/api', 'username', 'password')
    graylogapi.system.inputs.by_id('5947d3840b5712166af25009')

## Supported methods

* **Alerts**: Manage stream alerts for all streams
  * recent(params) — Get the most recent alarms of all streams.
  * paginated(params) — Get alarms of all streams, filtered by specifying limit and offset parameters.
  * by_id(id, params) — Get an alert by ID.
* **System/IndexSets**: Index sets
  * all — Get a list of all index sets.
  * create(params) — Create index set.
  * by_id(id) — Get index set by id.
* **System/Inputs**: Message inputs
  * all — Get all inputs.
  * by_id(id, params) — Get information of a single input on this node.
  * create(params) — Launch input on this node.
  * update(params) — Update input on this node.
  * delete(id) — Terminate input on this node.

## Copyright

Copytight (c) 2017 Andrey Aleksandrov

See [LICENSE][] for details.

[license]: LICENSE.md
