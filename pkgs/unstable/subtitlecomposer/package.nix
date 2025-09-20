{
  fetchFromGitLab,
  subtitlecomposer,
}:
subtitlecomposer.overrideAttrs (
  _: _: {
    version = "0.8.2-unstable-2025-09-16";
    src = fetchFromGitLab {
      domain = "invent.kde.org";
      owner = "multimedia";
      repo = "subtitlecomposer";
      rev = "0043f4434886c5aabe99705d40bd7f633b8b73e7";
      hash = "sha256-AxkHX3/1Bghtpty/03/n1a+ujSLco+6lZdbBVfzDdsI=";
    };
  }
)
