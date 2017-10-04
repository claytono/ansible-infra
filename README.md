# Misc Notes

* When building a new system, the ansible user will not exist the first time
  and it may be necessary to override the user to use when provisioning with
  the `-u` username argument.   For example, when using the EC2 Ubuntu images,
  the default user will be `ubuntu`.
