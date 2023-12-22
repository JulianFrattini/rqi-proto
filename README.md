# Requirements Quality Impact: Prototype Study

[![GitHub](https://img.shields.io/github/license/JulianFrattini/rqi-proto)](./LICENSE)

This repository contains the replication package for the prototype study that empirically investigates the impact of requirements quality defects on subsequent activities. It is the first implementation of the requirements quality theory [1] with the goal of quantifying the impact that alleged requirements quality defects (like passive voice or ambiguous pronouns) have on subsequent software engineering activities (like domain modeling).

The study comprises of an experiment in which participants were tasked to generate one domain model for each of four single sentence natural language requirements specifications. Each specification contained different requirements quality defects (passive voice and ambiguous pronouns). The experiment is used to evaluate whether these alleged quality defects have an impact on the properties of the resulting domain model. The experiment is an external, differentiated replication of a study by Femmer et al. [2].

## Structure

This repository contains the following files:

* data: folder containing all data obtained from the experiment
  * raw: folder containing the raw data as collected during the experiment
    * rqi-demographics.csv: anonymized demographic data about the experiment participants
    * rqi-objects.csv: attributes of the four experimental objects (single-sentence requirements specifications)
    * rqi-results.csv: evaluation of the domain models produced by the experiment participants
    * rqi-results-overlap.csv: evaluation of a part of the domain models produced by the experiment participants, but by a different evaluator
  * results: folder containing data produced during the evaluation
    * rel-duration-superfluous-entities: estimate and confidence interval of the marginal effect of the relative duration on superfluous entities
    * rel-duration-wrong-associations: estimate and confidence interval of the marginal effect of the relative duration on wrong associations
  * rqi-data.csv: data sheet aggregated from the individual data files (demographics, objects, and results) via [data-loading](./src/util/data-loading.Rmd)
* figures: folder containing all figures of the manuscript (in `pdf` format) which are either generated via the scripts or from `graphml` files
  * dags: all directed, acyclic graphs
  * demographics: visualization of the distribution of demographic variables
  * examples: visualizations of domain models generated from requirements specifications
  * quality-theory: graphical representation of the requirements quality theory
  * results: marginal and interaction plots evaluating the Bayesian models
* src: R code processing the data
  * bayesian: Bayesian data analyses of the following hypotheses:
    * duration.Rmd: "Requirements quality has an effect on the duration to create a domain model"
    * missing-associations.Rmd: "Requirements quality has an effect on the number of associations missing from a domain model"
    * missing-entities.Rmd: "Requirements quality has an effect on the number of entities missing from a domain model"
    * superfluous-entities.Rmd: "Requirements quality has an effect on the number of superfluous entities in a domain model"
    * wrong-associations.Rmd: "Requirements quality has an effect on the number of wrong associations in a domain model"
  * frequentist: Frequentist analysis of the data (investigating the hypotheses by Femmer et al. [2])
  * meta: meta-analyses assessing the validity of the research
    * interrater-agreement.Rmd: calculation of the inter-rater agreement of two evaluators between rqi-results.csv and rqi-results-overlap.csv
  * util: helper files for the data analysis
    * data-loading.Rmd: assembly of the rqi-data.csv sheet for analysis and initial visualization of distributions
    * data-preparation.R: helper method to load the rqi-data.csv sheet and ensure the correct column types
    * model-eval.R: helper method to run posterior predictions from a `brms` model
    * setup.R: collection of library calls for all analysis scripts
    
## System Requirements

To render and edit `graphml` files, install a graph editor like [yEd](https://www.yworks.com/products/yed).

In order to run the `R` scripts in the src folder, ensure that you have [R](https://ftp.acc.umu.se/mirror/CRAN/) (version > 4.0) and (RStudio)[https://posit.co/download/rstudio-desktop/#download] installed on your machine. Then, ensure the following steps:

1. Install the `rstan` toolchain by following the instructions for [Windows](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Windows#r40), [Mac OS](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Mac), or [Linux](https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux) respectively.
2. Restart RStudio and follow the instructions starting with the [Installation of RStan](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started#installation-of-rstan)
3. Install the latest version of `stan` by running the following commands
```
    install.package("devtools")
    devtools::install_github("stan-dev/cmdstanr")
    cmdstanr::install_cmdstan()
```
4. Install all required packages via `install.packages(c("tidyverse", "xlsx", "stringr", "rcompanion", "psych", "dagitty", "ggdag", "brms", "tidyverse", "posterior", "bayesplot", "marginaleffects", "broom.mixed", "patchwork"))` (see [setup.R](./src/util/setup.R) for the setup of the main libraries).
5. Create a folder called *fits* within *src/bayesian/* such that `brms` has a location to place all Bayesian models.
6. Open the `rqi-proto.Rproj` file with RStudio, which will setup the environment correctly.

## References

[1] Frattini, J., Montgomery, L., Fischbach, J., Mendez, D., Fucci, D., & Unterkalmsteiner, M. (2023). Requirements quality research: a harmonized theory, evaluation, and roadmap. Requirements Engineering, 1-14.

[2] Femmer, H., Kučera, J., & Vetrò, A. (2014, September). On the impact of passive voice requirements on domain modelling. In Proceedings of the 8th ACM/IEEE international symposium on empirical software engineering and measurement (pp. 1-4).

## License

Copyright © 2023 Julian Frattini. This work (source code) is licensed under [MIT License](./LICENSE).