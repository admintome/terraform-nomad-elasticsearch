resource "nomad_job" "logging" {
  jobspec = "${file("${path.module}/elk.hcl")}"
}
