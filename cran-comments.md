## Release summary

This is an update from 1.6-0.0 to 1.7-0.0. It stops losing valid gender and ethnicity codes that are mixed with text or invalid values, turns silent `NULL` returns for invalid arguments into errors, corrects the documentation, removes the `pkgsearch` and `crayon` dependencies (the startup message now uses `cli`, is interactive-only, waits at most two seconds and can be switched off), adds a testthat 3e suite and requires R >= 4.1. Seeded output is unchanged; tests pin it.

## Test environments

* local macOS (aarch64), R release: `R CMD check --as-cran`
* GitHub Actions: ubuntu-latest (release, oldrel-1, devel), macos-latest (release), windows-latest (release)
* win-builder (release, devel): to be run before submission

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

Checked the CRAN reverse dependencies ahpsurvey, diffpriv, NHSRwaitinglist, raw, simulist and SGP against this version with `R CMD check`: no new problems. (diffpriv has one Rd NOTE about lost braces that does not involve randomNames.)
