resource "aws_secretsmanager_secret" "prefect_api_key" {
  name = "prefect-api-key-2"

  tags = {
    Name = var.project_tag
  }
}

resource "aws_secretsmanager_secret_version" "prefect_api_key" {
  secret_id     = aws_secretsmanager_secret.prefect_api_key.id
  secret_string = var.prefect_api_key
}
resource "aws_secretsmanager_secret" "dockerhub_credentials" {
  name = "dockerhub-credentials-2"

  tags = {
    Name = var.project_tag
  }
}

resource "aws_secretsmanager_secret_version" "dockerhub_credentials_version" {
  secret_id     = aws_secretsmanager_secret.dockerhub_credentials.id
  secret_string = jsonencode({
    username = "avinashdocker2025"
    password = "dckr_pat_icTrCSnUMPJKNl1_JTvdOAv-Efc"
  })
}


