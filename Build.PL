
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.4003",
    "Test::More" => "0.98"
  },
  "configure_requires" => {
    "Module::Build" => "0.4003"
  },
  "dist_abstract" => "add paths to \@INC depending on which version of perl is running.",
  "dist_author" => [
    "Kent Fredric <kentfredric\@gmail.com>"
  ],
  "dist_name" => "lib-byversion",
  "dist_version" => "0.1.0",
  "license" => "perl",
  "module_name" => "lib::byversion",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "String::Formatter" => 0,
    "perl" => "v5.10.0",
    "strict" => 0,
    "version" => "0.77",
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
