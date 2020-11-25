# Tutorial for Pull Request Mergers

## Check branch

PR should be submitted from a **non-master** branch.

<img src="resources/tutorial_pull_request_mergers/1.png" width="700">
<br/>

If PR was submitted from the **master** branch, you can link to this explanation of what to do to fix it: 

https://edav.info/github#fixing-mistakes.

<br/>
<img src="resources/tutorial_pull_request_mergers/2.png" width="700">



<br/>

##  Examine files that were added or modified
<img src="resources/tutorial_pull_request_mergers/files_changed.png" width="700">
<br/><br/>

- There should be only ONE `.Rmd` file. 

- All of the additional resources should be in the `resources/<project_name>/` folder.

- There should be no other files in the root directory besides the `.Rmd` file.

## Check `.Rmd` filename

- The `.Rmd` filename should be words only and joined with underscores, no white space. (Update: It does not need to be the same as the branch name.)
- The `.Rmd` filename can only contain **lowercase letters**. (Otherwise the filenames do not sort nicely on the repo home page.)

## Check `.Rmd` file contents

- The file should **not** contain a YAML header nor a `---` line.
- The second line should be blank, followed by the author name(s).
- The first line should start with a **single hashtag `#`**, followed by a **single whitespace**, and then the title.
- There should be no additional single hashtag headers in the chapter. (If there are, new chapters will be created.)
- NEW: Other hashtag headers should **not** be followed by numbers since the hashtags will create numbered subheadings. Correct: `## Subheading`. Incorrect: `## 3. Subheading`.
- If the file contains a setup chunk in `.Rmd` file, it should **not** contain a `setup` label. (The bookdown render will fail if there are duplicate chunk labels.)
<br/>i.e. use `{r, include=FALSE}` instead of `{r setup, include=FALSE}`.
<br/>[See sample `.Rmd`](https://github.com/jtr13/cc20/blob/master/sample_project.Rmd)
- Links to internal files must contain `resources/<project_name>/` in the path, such as: `![Test Photo](resources/sample_project/election.jpg)`
- The file should not contain any `install.packages()`, `write` functions, `setwd()`, or `getwd()`. 
- If there's anything else that looks odd but you're not sure, assign `jtr13` to review and explain the issue.


## Request changes 

If there are problems with any of the checks listed above, explain why the pull request cannot be merged and request changes by following these steps:

<img src="resources/tutorial_pull_request_mergers/check_format.png" width="700">
<img src="resources/tutorial_pull_request_mergers/request_change_lines.png" width="700">
<img src="resources/tutorial_pull_request_mergers/request_change_files.png" width="700">
<img src="resources/tutorial_pull_request_mergers/request_change_submit_review.png" width="700">

Then, add a `changes requested` label to this pull request.

Your job for this pull request is done for now. Once contributors fix their requests, review again and either move forward with the merge or explain what changes still need to be made.

<br/> 

## Merge the pull request

If all is good to go, it's time to merge the pull request. There are several steps. 

### Add chapter filename to `_bookdown.yml` in PR's `branch`

- To access the PR branch:

<img src="resources/tutorial_pull_request_mergers/3.png" width="700">

- Make sure you are on the PR branch by checking that the PR branch name is shown (not `master`):

<img src="resources/tutorial_pull_request_mergers/4.png" width="700">

- Open the `_bookdown.yml` file.

- NEW: **delete everything in the file beginning with `rmd_files: [` and then add the name of the new file in single quotes followed by a comma:**

<img src="resources/tutorial_pull_request_mergers/delete_most_of_bookdown_yml.png" width="700">

Why? Because it will be easier to fix the merge conflicts this way. (A better way to do this is to merge master into the PR branch *before* adding the new file but this can't be done on GitHub. If there's interest I will explain how to do this locally.)

- Save the edited version.

- Click the resolve conflicts button:

<img src="resources/tutorial_pull_request_mergers/resolve_conflicts.png" width="700">

- Cut the new filename and paste it into the proper location. Then delete the lines with `<<<<<<< xxxx`, `=======` and `>>>>>>>> master`. In short, the file should look correct when you're done. Click the "Marked as resolved" button and then the green "Commit merge" button.

### Add chapter names to `.Rmd` for every first article in each chapter (Chapter Organization)

**Only do this if you are adding the first chapter in a PART.**

For every first article of each part, add the chapter name on the top of the `.Rmd` file, then propose changes. The example is like this.
<img src="resources/tutorial_pull_request_mergers/chap_1.png" width="700">
<br/><br/>

### Merge PR and leave a comment

Now comes the final step.

**If you're not sure that you did things correctly, assign one of the PR merge leaders or @jtr13 to review before you merge the PR.**

Go back to the conversation tab of the pull requests page, for example: 

https://github.com/jtr13/cc20/pull/23#issuecomment-728506101

Leave comments for congratulations 🎉 (type `:tada:`) and then click on the green button for merge.
<br/> 


