resource "aws_glue_catalog_database" "data" {
  name = "tf_glue_${random_id.suffix.hex}"
}
