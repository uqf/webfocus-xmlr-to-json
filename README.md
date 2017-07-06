# WebFocus XMLR to JSON
This repository provides an example of how to generate useful JSON output of WebFocus reports by transforming the XMLR output format with a simple XSL transform. This is particularly useful for making the data from existing WebFocus reports available in a form that can be parsed or processed by an external system.

## How to Run
`php -f run.php > ./examples/car/output.json`

## Notes
One of the current shortcomings of the XMLR format is that there is no way to reference the columns of a subtotal or total row back to the column metadata. This is particularly problematic if new columns are added to the report or existing columns are reordered since this may result in the generated keys (ex: `CST1`) changing.