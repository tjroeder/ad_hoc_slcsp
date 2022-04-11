# Ad Hoc SLCSP Take Home

## Problem:
Determine the second lowest cost silver plan (SLCSP) for a group of ZIP codes. Original problem description can be found [here](https://homework.adhoc.team/slcsp/) or below.

## Getting Started:
These instructions will allow you get your copy of this repo, up and running locally.

### Prerequisites:
Ruby `version 2.7.2`

Bundler `version 2.3.10`

Incompatabilities could occur if a different version is used.
```sh
$ ruby -v
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [arm64-darwin20]
$ bundle -v
Bundler version 2.3.10
```
Gems Utilized: `csv`, `optparse`

Please run Bundler with the following command while in the project directory to install an missing dependancies.
```sh
$ bundle
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
Using bundler 2.3.10
Fetching csv 3.2.3
Fetching optparse 0.2.0
Installing csv 3.2.3
Installing optparse 0.2.0
Bundle complete! 2 Gemfile dependencies, 3 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

### Running the Application:
To run the application three required CLI arguments will need to be provided with their options flag. To view the options use the `-h` or `--help` flag. The output file path is defaulted to `./data/slcsp_out.csv` this can be overriden by providing the `--output_path` flag.

```sh
$ ruby ./lib/find_slcsp_rates.rb -h
Usage: find_slcsp_rates.rb [path_option] relative filepath

Required CSV file paths: Plans CSV file path, Zips CSV file path, SLCSP CSV file path

Optional CSV file path: Output file path

        --plans_path PATH            Required CSV Plans file path
        --zips_path PATH             Required CSV Zips file path
        --slcsp_path PATH            Required CSV SLCSP file path
        --output_path [PATH]         Optional CSV SLCSP output file path, Default: ./data/slcsp_out.csv

    -h, --help                       Show this message
```

### Application Output:
```sh
$ ruby ./lib/find_slcsp_rates.rb --zips_path './data/zips.csv' --plans_path './data/plans.csv' --slcsp_path './data/slcsp.csv'
zipcode,rate
  64148,245.20
  67118,212.35
  40813,
  18229,231.48
  51012,252.76
  79168,243.68
  54923,255.26
  67651,249.44
  49448,221.63
  27702,283.08
  47387,326.98
  50014,287.30
  33608,268.49
  06239,
  54919,243.77
  46706,272.81
  14846,
  48872,280.47
  43343,260.94
  77052,243.72
  07734,
  95327,
  12961,
  26716,291.76
  48435,248.99
  53181,306.56
  52654,242.39
  58703,297.93
  91945,
  52146,254.56
  56097,
  21777,
  42330,
  38849,285.69
  77586,243.72
  39745,265.73
  03299,240.45
  63359,301.87
  60094,209.95
  15935,184.97
  39845,325.64
  48418,248.99
  28411,307.51
  37333,219.29
  75939,234.50
  07184,
  86313,292.90
  61232,222.38
  20047,
  47452,329.61
  31551,296.75
```

# Original Problem Statement:
# SLCSP

## Calculate the second lowest cost silver plan

## Problem

You've been asked to determine the second lowest cost silver plan (SLCSP) for
a group of ZIP codes.

## Task

You've been given a CSV file, `slcsp.csv`, which contains the ZIP codes in the
first column. Fill in the second column with the rate (see below) of the
corresponding SLCSP and emit the answer on `stdout` using the same CSV format as
the input. Write your code in your best programming language.

### Expected output

The order of the rows in your answer as emitted on stdout must stay the same as how they
appeared in the original `slcsp.csv`. The first row should be the column headers: `zipcode,rate`
The remaining lines should output unquoted values with two digits after the decimal
place of the rates, for example: `64148,245.20`.

It may not be possible to determine a SLCSP for every ZIP code given; for example, if there is only one silver plan available, there is no _second_ lowest cost plan. Check for cases where a definitive answer cannot be found and leave those cells blank in the output (no quotes or zeroes or other text). For example, `40813,`.

## Additional information

The SLCSP is the so-called "benchmark" health plan in a particular area. It's
used to compute the tax credit that qualifying individuals and families receive
on the marketplace. It's the second lowest rate for a silver plan in the rate area.

For example, if a rate area had silver plans with rates of `[197.3, 197.3, 201.1, 305.4, 306.7, 411.24]`, the SLCSP for that rate area would be `201.1`,
since it's the second lowest rate in that rate area.

A plan has a "metal level", which can be either Bronze, Silver, Gold, Platinum,
or Catastrophic. The metal level is indicative of the level of coverage the plan
provides.

A plan has a "rate", which is the amount that a consumer pays as a monthly
premium, in dollars.

A plan has a "rate area", which is a geographic region in a state that
determines the plan's rate. A rate area is a tuple of a state and a number, for
example, NY 1, IL 14.

There are two additional CSV files in this directory besides `slcsp.csv`:

- `plans.csv` — all the health plans in the U.S. on the marketplace
- `zips.csv` — a mapping of ZIP code to county/counties & rate area(s)

A ZIP code can potentially be in more than one county. If the county can not be
determined definitively by the ZIP code, it may still be possible to determine
the rate area for that ZIP code. A ZIP code can also be in more than one rate area. In that case, the answer is ambiguous
and should be left blank.

We'll want to compile your code from source and run it from a Unix-like command line, so please include the complete instructions for doing so in a COMMENTS file.
