terraform {
  backend "gcs" {
    bucket = "mood-270122-tfstate"
    prefix = "env/dev"
  }
}
