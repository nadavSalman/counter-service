variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name                 = string
    cidr_block           = string
    availability_zone    = string
    map_public_ip_on_launch = bool
    internal_elb_tag    = string
    elb_tag             = string
  }))
  default = [
    {
      name                 = "private-eu-west-2a"
      cidr_block           = "10.0.0.0/19"
      availability_zone    = "eu-west-2a"
      map_public_ip_on_launch = false
      internal_elb_tag    = "1"
      elb_tag              = null
    },
    {
      name                 = "private-eu-west-2b"
      cidr_block           = "10.0.32.0/19"
      availability_zone    = "eu-west-2b"
      map_public_ip_on_launch = false
      internal_elb_tag    = "1"
      elb_tag              = null
    },
    {
      name                 = "public-eu-west-2a"
      cidr_block           = "10.0.64.0/19"
      availability_zone    = "eu-west-2a"
      map_public_ip_on_launch = true
      internal_elb_tag    = null
      elb_tag              = "1"
    },
    {
      name                 = "public-eu-west-2b"
      cidr_block           = "10.0.96.0/19"
      availability_zone    = "eu-west-2b"
      map_public_ip_on_launch = true
      internal_elb_tag    = null
      elb_tag              = "1"
    }
  ]
}
