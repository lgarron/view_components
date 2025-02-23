---
title: Moving Away From `Primer::LocalTime`
---

This guide will show you how to upgrade from the now deprecated
[`Primer::LocalTime`](https://primer.style/view-components/components/localtime)
to the latest [`Primer::Beta::RelativeTime`](https://primer.style/view-components/components/beta/relativetime)
component.

## A Migration Example

The most common use case of the `LocalTime` component can be migrated with only
a few minor changes.

For example, if the `LocalTime` was set up in this way:

```rb
<%= Primer::LocalTime(datetime: Time.now, initial_text: Time.now.iso8601) %>
```

It can be migrated by removing `initial_text`c, setting an empty `prefix`, and adding `threshold: "PT0S"`.

```rb
<%= Primer::Beta::RelativeTime(datetime: Time.now, prefix: "", threshold: "PT0S") %>
```

The `RelativeTime` component defaults to the `iso8601` format and does not need
to be specified directly.

The `threshold` value is an [ISO-8601 "duration"](https://en.wikipedia.org/wiki/ISO_8601#Durations) that tells the `RelativeTime`
component to display the absolute date/time, instead of relative time
description. The example of `PT0S` says to switch to absolute time display
starting zero (0) seconds ago. In practice, this means it will always display
the absolute time. With the `LocalTime` component, `PT0S` was the default
threshold. The `RelativeTime` component defaults to `P30D`, however, and
it will need to be zeroed out to always display a datetime.

## Arguments

The following arguments are different between `LocalTime` and `RelativeTime`.

| From `Primer::LocalTime` | To `Primer::Beta::RelativeTime` | Notes |
|--------------------------|---------------------------------|-------|
| `initial_text` | n/a         | No longer used.                                                                                                     |
| n/a            | `tense`     | Which tense to use. One of `:auto`, `:future`, or `:past`.                                                          |
| n/a            | `prefix`    | What to prefix the relative ime display with.                                                                       |
| n/a            | `threshold` | The threshold, in ISO-8601 'durations' format, at which relative time displays become absolute.                                                      |
| n/a            | `precision` | The precision elapsed time should display. One of nil, `:day`, `:hour`, `:minute`, `:month`, `:second`, or `:year`. |
| n/a            | `format`    | The format the display should take. One of `:auto`, `:elapsed`, or `:micro`.                                        |
| n/a            | `lang`      | The language to use.                                                                                                |
| n/a            | `title`     | Provide a custom title to the element.                                                                              |

The remaining arguments stayed the same.

Please see the following documentation for complete descriptions and examples.

* [Deprecated `Primer::LocalTime`](https://primer.style/view-components/components/localtime)
* [`Primer::Beta::RelativeTime` component](https://primer.style/view-components/components/beta/relativetime)
* [`Primer::Beta::RelativeTime` Lookbook examples](https://primer.style/view-components/lookbook/inspect/primer/beta/relativetime/default)

<p>&nbsp;</p>

[&larr; Back to migration guides](https://primer.style/view-components/migration)
