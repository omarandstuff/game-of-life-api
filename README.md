# Conways Game of Life API

This is a simple API for the game of life. It is written in Ruby using the Rails framework.

## Installation

To install the API, clone the repository and run the following commands:

```bash
bundle install
rails db:create
rails db:migrate
```

## Running the API

To run the API, run the following command:

```bash
rails s
```

The API will be available at `http://localhost:3000`.

## Run the tests

To run the tests, run the following command:

```bash
rspec
```

## Endpoints

The API has the following endpoints:

### Create a new board

```bash
curl -X POST http://localhost:3000/boards -d '{"state": [[0, 1, 0], [0, 1, 0], [0, 1, 0]]}' -H 'Content-Type: application/json'
```

### Get the current state of a board

```bash
curl http://localhost:3000/boards/1
```

### Get the next state of a board

```bash
curl http://localhost:3000/boards/1/next
```

You can also pass the number of iterations to get the state after a certain number of iterations:

```bash
curl http://localhost:3000/boards/1/next?iterations=10
```

### Get the final state of a board

```bash
curl http://localhost:3000/boards/1/final
```

You can also pass the number of iterations to get the final state after a certain number of iterations:

```bash
curl http://localhost:3000/boards/1/final?iterations=10
```
