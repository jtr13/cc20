# (PART) Appendices {-}

This chapter contains additional information regarding how to setup the Github to build the book. 

# Github Initial Setup

1. Create a repo called "CC20" by following the instructions written in the [bookdown-template](https://github.com/jtr13/bookdown-template){target="blank"}.

2. In `index.Rmd`, edit the title, github-repo and add description.

3. In `_bookdown.yml`, edit relevant github information.

4. In `index.Rmd`, include "Chapter 1: Instructions" similar to CC19. 

5. Add "Chapter 2: The Sample Project" by creating `sample_project.Rmd`. 

6. In `_bookdown.yml`, define our own order of Rmd files for the book in a field named `rmd_files`. Without `rmd_files`, the table of content of the book would be ordered alphabetically by the title of each Rmd file. Please read [bookdown Usage](https://bookdown.org/yihui/bookdown/usage.html){target="blank"} for further reference. 

