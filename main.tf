# This built-in resource creates no Azure infrastructure and has no cost. Its
# only purpose is to put a small, visible object into Terraform state so that
# the migration from local state to Azure Blob Storage can be verified.
resource "terraform_data" "state_demo" {
  input = {
    task        = "terraform-task-5"
    state_store = "azure-blob-storage"
  }
}
