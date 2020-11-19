# Chapter Organization

Yibai Liu and Colin Payne-Rogers

This appendix contains information on how chapters in the `cc20` book are organized.

## Process for Organizing Chapters

1. Each pull request that contains a chapter will be marked with at least one label prefixed with `chap: #`. This identifies which part of the book it should be added to.

2. Additional labels may be added by chapter organizers or pull request reviewers. The goal for these is to add additional context to each chapter pull request. For instance, a "Python vs. R" cheat sheet and a "Mosaic Plot" cheat sheet will have different `chap:` labels, but the same `cheatsheet` label. These labels may help the chapter organizers re-organize chapters at a later date, if any initial chapters become bloated with contributions :)

3. The chapter organizers will request that pull requests are updated so that the `_bookdown.yml` chapter list is in accordance with the chapter organization.

## Initial Book Parts

These are subject to change based on the content of the classes contributions. They are:

1. Data Processing and Wrangling
2. Data Visualization
3. Reporting Results
4. Complete Analyses
5. Translations
6. Live Tutorials
7. Other Topics

### Motivation

The chapters are organized with a real-world data pipeline in mind. First, an analyst needs to obtain and organize the data they hope to explore and visualize ("data processing and wrangling"). This may include contributions related to tidying data, handling missing data, web scraping, and more.

Data in hand, our analyst will want to lean on data visualization tools, like those from this class, first for the exploratory data analysis and later for visualization aimed at their audience, customer, etc. These contributions are captured in "data visualization" but may become two sections if enough pull requests fall into each category.

The "final" step in a data analysis pipeline is to share the results of an analysis with interested third parties. This might be through a website build in R with Shiny, or using D3, or with a platform like Tableau. Community contributions that focus on how to format charts for an audience, rather than how to create them in R, may belong here in "Reporting Results."

At this point, readers of our "book" may be ready to appreciate the hard work that goes into "Complete Analyses" - those community contributions that find or import data, tidy and format it, explore and analyze it, and present conclusions to readers belong in the fourth section.

### Additional Categories

A careful reader will notice that sections `5` and `6` are missing from the chapter organization motivation. That's because these categories, "Translations," "Live Tutorials," and "Other Topics," don't fit neatly into the data pipeline heuristic. Chapters that are labeled and initially organized into those sections may find that that's where they belong, or they may have a new home when future pull requests update the chapter organization based on the community contributions we've received.
