login_git() {
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/company/repos/github/local/orion/key
}

login_1p() {
  op signin
}
