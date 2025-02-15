# Requirements Quality Impact: Prototype Study

[![GitHub](https://img.shields.io/github/license/JulianFrattini/rqi-proto)](./LICENSE)
[![DOI](https://zenodo.org/badge/702902445.svg)](https://zenodo.org/doi/10.5281/zenodo.10423665)
[![arXiv](https://img.shields.io/badge/arXiv-2401.01154-b31b1b.svg)](https://arxiv.org/abs/2401.01154)

This repository contains the replication package for the prototype study that empirically investigates the impact of requirements quality defects on subsequent activities. It is the first implementation of the requirements quality theory[^1] with the goal of quantifying the impact that alleged requirements quality defects (like passive voice or ambiguous pronouns) have on subsequent software engineering activities (like domain modeling).

The study comprises of an experiment in which participants were tasked to generate one domain model for each of four single sentence natural language requirements specifications. Each specification contained different requirements quality defects (passive voice and ambiguous pronouns). The experiment is used to evaluate whether these alleged quality defects have an impact on the properties of the resulting domain model. The experiment is an external, differentiated replication of a study by Femmer et al.[^2]

## Structure

This repository contains the following files:

```
├── data: folder containing all data obtained from the experiment
│   ├── raw: folder containing the raw data as collected during the experiment
│   │   ├── responses: folder containing the raw submissions of experiment participants (i.e., their created domain models)
│   │   ├── rqi-demographics.csv: anonymized demographic data about the experiment participants
│   │   ├── rqi-objects.csv: attributes of the four experimental objects (single-sentence requirements specifications)
│   │   ├── rqi-results.csv: evaluation of the domain models produced by the experiment participants
│   │   └── rqi-results-overlap.csv: evaluation of a part of the domain models produced by the experiment participants, but by a different evaluator
│   ├── results: folder containing data produced during the evaluation
│   │   ├── rel-duration-superfluous-entities: estimate and confidence interval of the marginal effect of the relative duration on superfluous entities
│   │   └── rel-duration-wrong-associations: estimate and confidence interval of the marginal effect of the relative duration on wrong associations
│   └── rqi-data.csv: data sheet aggregated from the individual data files (demographics, objects, and results) via data-loading
├── doc: folder containing all supplementary material for the planning and execution of the experiment
│   ├── instrument: folder containing the experiment instrument
│   │   ├── evaluation-guideline.pdf: guidelines on how to evaluate the collected data
│   │   ├── study-document.pdf: instructions for the experimental task
│   │   └── survey.pdf: additional survey for demographic variables of study participants
│   ├── causal-model.pdf: fundamental causal assumptions informing the design of the experiment
│   ├── experiment-design.pdf: documentation of the experimental design
│   └── experimental-objects.pdf: the requirements specifications for the experimental task as well as the ground truth
├── figures: folder containing all figures of the manuscript (in `pdf` format) which are either generated via the scripts or from `graphml` files
│   ├── dags: all directed, acyclic graphs
│   ├── demographics: visualization of the distribution of demographic variables
│   ├── examples: visualizations of domain models generated from requirements specifications
│   ├── quality-theory: graphical representation of the requirements quality theory
│   └── results: marginal and interaction plots evaluating the Bayesian models
├── src: R code processing the data
│   ├── bayesian: Bayesian data analyses of the following hypotheses:
│   │   ├── combined-defects.Rmd: "Requirements quality has an effect on the number of total defects (missing entities, superfluous entities, missing associations, and wrong associations)"
│   │   ├── duration.Rmd: "Requirements quality has an effect on the duration to create a domain model"
│   │   ├── missing-associations.Rmd: "Requirements quality has an effect on the number of associations missing from a domain model"
│   │   ├── missing-entities.Rmd: "Requirements quality has an effect on the number of entities missing from a domain model"
│   │   ├── superfluous-entities.Rmd: "Requirements quality has an effect on the number of superfluous entities in a domain model"
│   │   └── wrong-associations.Rmd: "Requirements quality has an effect on the number of wrong associations in a domain model"
│   ├── frequentist: Frequentist analysis of the data (investigating the hypotheses by Femmer et al. [2])
│   ├── html: folder containing a pre-compiled `html` version of each `Rmd` file (using `knitr`)
│   ├── meta: meta-analyses assessing the validity of the research
│   │   ├── interrater-agreement.Rmd: calculation of the inter-rater agreement of two evaluators between rqi-results.csv and rqi-results-overlap.csv
│   │   └── participant-type.Rmd: investigation of the eligibility of subsuming a participant type predictor by more fine-grained predictors (e.g., experience and domain knowledge)
│   └── util: helper files for the data analysis
│       ├── data-loading.Rmd: assembly of the rqi-data.csv sheet for analysis and initial visualization of distributions
│       ├── data-preparation.R: helper method to load the rqi-data.csv sheet and ensure the correct column types
│       ├── model-eval.R: helper method to run posterior predictions from a `brms` model
│       └── setup.R: collection of library calls for all analysis scripts
└── rqi-proto.Rproj : R project setup file
```
    
## System Requirements

To render and edit `graphml` files, install a graph editor like [yEd](https://www.yworks.com/products/yed).

In order to run the `R` scripts in the src folder, ensure that you have [R](https://ftp.acc.umu.se/mirror/CRAN/) (version > 4.0) and [RStudio](https://posit.co/download/rstudio-desktop/#download) installed on your machine. 
Then, ensure the following steps:

1. Install the C toolchain by following the instructions for [Windows](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Windows#r40), [Mac OS](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Mac), or [Linux](https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux) respectively.
2. Restart RStudio and follow the instructions starting with the [Installation of RStan](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started#installation-of-rstan)
3. Install the latest version of `stan` by running the following commands
```
    install.packages("devtools")
    devtools::install_github("stan-dev/cmdstanr")
    cmdstanr::install_cmdstan()
```
4. Install all required packages via `install.packages(c("tidyverse", "xlsx", "stringr", "rcompanion", "psych", "dagitty", "ggdag", "brms", "tidyverse", "posterior", "bayesplot", "marginaleffects", "broom.mixed", "patchwork"))` (see [setup.R](./src/util/setup.R) for the setup of the main libraries).
5. Create a folder called *fits* within *src/bayesian/* such that `brms` has a location to place all Bayesian models.
6. Open the `rqi-proto.Rproj` file with RStudio, which will setup the environment correctly.

## Usage

To use this replication package, we recommend investigating the artifacts in this repository in the following order. For each script, you can choose between the *interactive* `Rmd` file that allows to inspect and manipulate each variable and the *static* `html` file, which is a pre-compiled version of each `Rmd` notebook located in the [html](./src/html) folder. When opting for the static `html` files, you do not need to fulfill the [system requirements](#system-requirements) listed above and instead just need a browser and a `PDF` viewer.

1. **Assumptions**: To understand the general causal assumptions that informed the design of the study, consider the [causal assumptions](./doc/causal-model.pdf)
2. **Design**: To review the design derived from this causal model, consider the [experiment design](./doc/experiment-design.pdf) and the [experimental objects](./doc/experimental-objects.pdf).
3. **Instrumentation**: The implementation of the experiment design consists of the [experiment task](./doc/instrument/study-document.pdf) and the [survey](./doc/instrument/survey.pdf) of demographic variables.
4. **Data**: To inspect the collected data, consider the data preparation notebook ([static](./src/html/data-loading.html)/[interactive](./src/util/data-loading.Rmd)) or the [raw data](./data/raw). 
5. **Data Evaluation**: To verify the evaluation of the raw data, consider the [evaluation guidelines](./doc/instrument/evaluation-guideline.pdf). Also, consider the calculation of the inter-rater agreement ([static](./src/html/interrater-agreement.html)/[interactive](./src/meta/interrater-agreement.Rmd)) to check the reliability of the data evaluation.
6. **Frequentist Analysis**: Check the frequentist data analysis ([static](./src/html/frequentist-analysis.html)/[interactive](./src/frequentist/frequentist-analysis.Rmd)) to review the application of null-hypothesis significance tests as proposed by Femmer et al.[^2]
7. **Bayesian Analysis**: Check the Bayesian data analyses (static files in [src/html](./src/html) named after the five response variables (e.g., [duration.html](./src/html/duration.html) or [wrong-associations.html](./src/html/wrong-associations.html)), interactive files in [src/bayesian](./src/bayesian)) to review the application of a Bayesian data analysis framework for statistical causal inference.[^3]

## License

Copyright © 2023 Julian Frattini. This work (source code) is licensed under [MIT License](./LICENSE).

[^1]: Frattini, J., Montgomery, L., Fischbach, J., Mendez, D., Fucci, D., & Unterkalmsteiner, M. (2023). Requirements quality research: a harmonized theory, evaluation, and roadmap. Requirements Engineering, 1-14.
[^2]: Femmer, H., Kučera, J., & Vetrò, A. (2014, September). On the impact of passive voice requirements on domain modelling. In Proceedings of the 8th ACM/IEEE international symposium on empirical software engineering and measurement (pp. 1-4).
[^3]: Siebert, J. (2023). Applications of statistical causal inference in software engineering. Information and Software Technology, 107198.