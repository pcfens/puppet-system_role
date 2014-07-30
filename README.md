# puppet-system_role

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview

Facts (and a module) for identifying information about a system.

## Module Description

This module provides information about a node by breaking apart a structured
hostname into usable facts. If the hostname is, or could not be
structured, the module provides a mechanism for writing an informational file
that will be read by facter on the next run.

For the facts to run on the agents, `pluginsync` must be enabled.

## Usage

The module will provide 2 facts (`cluster_name` and `node_number`) from a
structured hostname that help identify the system (we had hiera in mind when
writing this).

The general hostname structure we use is
`[application name]-[tier]-[node number]`. The `cluster_name` fact is based on
application-name-tier, and the `node_number` fact is simply the node_number.

If the hostname isn't structured, the module can write out a file, the
contents of which will be read in lieu of the hostname to generate the 2 facts.

To manage the file, the class can be declared as

```puppet
class { 'system_role':
  application => 'test-application',
  tier        => 'prod',
  node_number => 0,
}
```

## Limitations

This module was developed and tested on Linux systems.

The concept used here is very simple, and can likely be translated to work
on other systems incredibly easily.
