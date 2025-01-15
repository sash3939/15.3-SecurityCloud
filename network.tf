resource "yandex_vpc_network" "net" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public" {
  name           = var.subnet_name
  zone           = var.zone_a
  v4_cidr_blocks = var.cidr-01
  network_id     = yandex_vpc_network.net.id
}
