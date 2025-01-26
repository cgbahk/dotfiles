print("Loading custom `.Rprofile`...")

if (interactive()) {
  .First <- function() try(utils::loadhistory("~/.Rhistory"))
  .Last <- function() try(utils::savehistory("~/.Rhistory"))

  helpme <- function (obj) {
    tools::Rd2txt(
      utils:::.getHelpFile(as.character(help(obj))),
      path.expand("~/buffer"),
      options=list(underline_titles=FALSE),
    )

    help(obj)
  }

  # Inspired by `data()`
  get_all_datasets <- function () {
    utils::capture.output(
      print(
        as.data.frame(utils::data()$results)[,c("Item", "Title", "Package")],
        right=FALSE,
        row.names=FALSE,
        width=10000,
      ),
      file=path.expand("~/buffer")
    )
  }

  fzf <- function() {
    hist_path = "~/.Rhistory"
    try(savehistory(hist_path))
    command = system("cat ~/.Rhistory | fzf --tac", intern=TRUE)
    cat(command, "\n\n")
    eval(parse(text=command))
  }
}
