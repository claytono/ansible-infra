# k.oneill.net subdomain zone (records managed by external-dns)
resource "aws_route53_zone" "k_oneill_net" {
  name = "k.oneill.net"
}
