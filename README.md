# Tax filling automation scripts with Cucumber, Capybara and Cuprite

This project uses Ruby, Cucumber, Capybara and Cuprite to calculate taxable revenue, withheld taxes and fill them into the Brazilian Government system for taxing international revenue for brazilian citizens.

The only purpose of this repo is automating a task I have to do manually every month, and couldn't trust anybody else to do it at this moment, so I, as a programmer, thought "why not write code to do that for me?".

The scripts parse a PDF document, get the taxes and revenue information, prepare it and input that into the government system.

The document to be parse is a statement from Charles Schwab broker. At this moment, I have no intent on parsing any other broker statements.

## Development environment

I'm using [VS Code Dev Container](https://code.visualstudio.com/docs/remote/containers) for this project.

## Configuration

Configuration can be tweaked at `features/support/env`.

## Executing the scripts

First of all, create a .env file and fill the GOV_USERNAME and GOV_PASSWORD variables in it. Then you can run the scripts by typing `cucumber` at the project's root directory. Just follow the instructions that pop up in the terminal and it'll be ok.
