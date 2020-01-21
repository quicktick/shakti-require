# shakti-require

Dependency management for [Shakti](https://shakti.com/) inspired by node

[![CircleCI](https://circleci.com/gh/quicktick/shakti-require.svg?style=svg)](https://circleci.com/gh/quicktick/shakti-require)

## Getting started

You can use Yarn or npm manage shakti dependencies.

Install [Yarn](https://yarnpkg.com/lang/en/)

Run:

```bash
yarn init
yarn add shakti-require
yarn add example-shakti-module
```

Then at the start of your program run:

```
\l ./node_modules/shakti-require/require.k
.rq.init[]
```

You then require other modules like this:
```
.rq.require["example-shakti-module"] / loads the module from ./node_modules
.example.add[1;2] / call loaded function
.rq.require["./exampleModule.k"]
```
or
```
.rq.requireWithoutCache["./exampleModule.k"]
```

## Require syntax

You can pass the require function an absolute or relative path.

If your path doesn't end with `.k` it will append `/index.k` to the end of your path:

### Examples

```
\l ./node_modules/shakti-require/require.k

.rq.require["./exampleModule.k"]

.rq.require["./folder/index.k"]

.rq.require["./folder"] / same as above

.rq.require["module"] / this resolves to node_modules/module/index.k

.rq.require["module/folder"] / this resolves to node_modules/module/folder/index.k

.rq.require["module/folder/index.k"] / this resolves to node_modules/module/folder/index.k

.rq.require["module/folder/index.k"] / won't run module/folder/index.k again a cached response is returned

.rq.requireWithoutCache["module/folder/index.k"] / loads ./exampleModule.k again
```

### Example module

We've written an example shakti module which has been published to npm here: https://github.com/quicktick/example-shakti-module
