requires Mojolicious => '0';
requires 'DBI' => '1.641';
#requires 'DBD::mysql' => '4.046';
requires 'DBD::SQLite' => '0';
requires 'Mojolicious::Plugin::AssetPack' => 0;
#requires 'Mojo::ACME' => '0.12';
requires "IPC::Run3"   => 0;

# required in old code
requires "File::Which" => 0;

recommends "CSS::Minifier::XS"        => 0;
recommends "CSS::Sass"                => 0;
recommends "Imager::File::PNG"        => 0;
recommends "IO::Socket::SSL"          => 0;
recommends "JavaScript::Minifier::XS" => 0;