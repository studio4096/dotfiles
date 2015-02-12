use strict;
use warnings;
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
use File::Path;
use Cwd;

my $username = 'studio4096';
my $project = 'dotfiles';
my $repo_url = "https://github.com/${username}/${project}.git";
my $tar_url = "https://github.com/${username}/${project}/tarball/master";
               
my @exclude_files = qw( README.md bootstrap.pl LICENSE-MIT.txt );
my %opts = ();
GetOptions(\%opts, qw( prefix|p=s homebrew! brewfile! js ie osx-defaults php vagrant wordpress zsh)) or exit 1;
exists $opts{homebrew} or $opts{homebrew} = 1;
exists $opts{brewfile} or $opts{brewfile} = 1;

my $home = $ENV{'HOME'};
if (!$home) { $home = '.' ; }
my $prefix = $opts{prefix};
if (!$prefix) {
    $prefix = "${home}/${username}/${project}";
}

my @dir = mkpath($prefix);
chdir($home);
my $retcode = system('which git > /dev/null');
if ( $retcode == 0 ) {
    $retcode = system('git clone '.$repo_url.' '.$prefix);
} else {
    $retcode = system('cd '.$prefix.'; curl -L '.$tar_url.' | tar -xzv --strip-components 1 --exclude={'.join(' ', @exclude_files).'}');
}
if ( $retcode != 0 ) {
    exit 1;
}

my @options = qw(homebrew brewfile js ie osx-defaults php vagrant wordpress zsh);
my $setup_command = "bash $prefix/setup.bash -p ${prefix}";
foreach (@options){
    if ($opts{$_}) {
        $setup_command .= " -o $_";
    }
}
print $setup_command;
exec($setup_command);
