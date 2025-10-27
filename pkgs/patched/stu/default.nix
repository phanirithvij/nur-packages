# Opened https://github.com/lusingander/stu/issues/83
{ stu, ... }:
stu.overrideAttrs {
  patches = [ ./0001-try-no-creds.patch ];
}
