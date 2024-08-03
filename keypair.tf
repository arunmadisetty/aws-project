resource "aws_key_pair" "arun" {
  key_name   = var.key_name
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN79oshIfreAQxprkI/5Yddbqq92BXaLS9vYpeR9ggpa arunmadisetty@Aruns-MacBook-Pro.local"
}

variable "key_name" {
    type = string
    default = "terraform-github"
}
